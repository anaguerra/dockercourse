Instalar Guacamole
---------------

Guacamole es un servicio en html5 que nos permite conectarnos a escritorios remotos desde nuestro
navegador. Via SSH.

Se requieren dos imágenes oficiales de Guacamole. El proceso de instalación es un poco complejo. Ver 
https://guacamole.apache.org/doc/gug/guacamole-docker.html

El docker-compose.yml

    version: '3'
    services:
      db:
        container_name: guacamole-db
        networks:
          - net
        image: mysql:latest
        volumes:
          - $PWD/conf/initdb.sql:/docker-entrypoint-initdb.d/initdb.sql
          - $PWD/data:/var/lib/mysql
        env_file: .env
      daemon:
        container_name: guacamole-daemon
        networks:
          - net
        image: guacamole/guacd
        depends_on:
          - db
      web:
        container_name: guacamole-web
        networks:
          - net
        image: guacamole/guacamole
        env_file: .env
        depends_on:
          - daemon
      proxy:
        container_name: guacamole-proxy
        networks:
          - net
        image: nginx
        ports:
          - "80:80"
        volumes:
          - $PWD/conf/nginx.conf:/etc/nginx/nginx.conf
        depends_on:
          - web
    networks:
      net:
    
Tenemos 4 servicios. La base de datos, en la red "net". 

El fichero "init.sql" es el dump de la base de datos, con todos los schemas, tablas, etc que necesita
Guacamole para funcionar. Está en la documentación, explican como sacarla. Está mapeado a un volumen
para que Guacamole lo pueda leer.

https://guacamole.apache.org/doc/gug/guacamole-docker.html#guacamole-docker-mysql

El otro volumen es para la data de MySQL. "$PWD" podríamos sustituirlo por ".". Estas dos nomenclaturas
son equivalentes:

    - $PWD/data:/var/lib/mysql
    - ./data:/var/lib/mysql

Le definimos también un fichero de variables de entorno, ".env".

El servicio "daemon", que es para la imagen oficial de guacamole, depende del servicio de
base de datos, "db"

El servicio "guacamole-web", que depende de "daemon", con sus variables de entorno.

El servicio "proxy", es para colocar un nginx delante, ya que por defecto Guacamole usa el puerto
8080. Con el proxy, hacemos que escuche por el 80. 
Para los otros servicios no se exponen puertos ya que al estar en la misma red pueden verse entre
ellos por el nombre.

Definimos un volumen para pasarle al nginx la configuración, que la tenemos en un subdirectorio "conf".

"proxy" depende de "web".

OJO: La aplicación no me funcionaba con las configuraciones proporcionadas.  
Haciendo `docker-compose logs -f` Guacamole se quejaba de que faltaba una tabla.
Pasos que se hicieron para que funcionara:

1. La imagen de MySQL que uso es la 'latest' en vez de la versión 5.7
2. Recreo de nuevo el volcado de base de datos 'initdb.sql' tal como se especifica 
en la documentación de guacamole en la web de Docker y lo uso en sustitución del 
que tú ofreces (por si guacamole ha modificado alguna tabla en las nuevas versiones).
3. Por si las moscas he cambiado el archivo oculto '.env' a un archivo sin ocultar al que he llamado 'environfile'

Para que vuelva a construir el servicio "db", lo eliminamos primero y luego hacemos

    docker-compose up -d --no-deps --build db

Comprobamos que todos están activos

    CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                NAMES
    831664d4ae17        nginx                 "nginx -g 'daemon of…"   6 seconds ago       Up 4 seconds        0.0.0.0:80->80/tcp   guacamole-proxy
    9e58375ed9d5        guacamole/guacamole   "/opt/guacamole/bin/…"   7 seconds ago       Up 6 seconds        8080/tcp             guacamole-web
    c1e9b81e0c0e        guacamole/guacd       "/bin/sh -c '/usr/lo…"   8 seconds ago       Up 7 seconds        4822/tcp             guacamole-daemon
    6eda9f60d1a1        mysql:latest          "docker-entrypoint.s…"   9 seconds ago       Up 8 seconds        3306/tcp             guacamole-db

Ahora vamos a localhost y ya vemos la entrada a Guacamole.
user: guacadmin
password: guacadmin


**NOTAS:**

Entrar en el contenedor de mysql

    docker exec -ti guacamole-db bash

Entrar al mysql 
    
    mysql -u guacamole -h db -pqpalwosk10
    

Usar Guacamole
----------

Nos ayudamos de otro contenedor. Para crearlo tenemos este Dockerfile

    FROM centos:7
    
    RUN \
      yum -y install openssh-server sudo
    
    RUN \
      useradd guacamole && \
      /usr/bin/ssh-keygen -A
    
    WORKDIR /home/guacamole
    
    CMD /usr/sbin/sshd -D
    
    
Se instala el servicio ssh
Se crea un usuario "guacamole" y se le genera una key
Se establece una variable de entorno en el directorio que por defecto se le crea al crear
el usuario

    docker build -t test .
    
(puede que haya que ponerle "sudo")
    
Ahora vamos a incluirlo en la red donde están los servicios de Guacamole (recordemos 
que se concatena el nombre de la carpeta actual con el nombre de la red)

    docker run -d --name ssh --network guacamole_net test
    
Ahora ya tenemos un servicio adicional en la red de Guacamole. Para comprobarlo entramos
en el contenedor "ssh" y hacemos ping p.e. a "web"

    docker exec -ti ssh bash 
    
    [root@e6f21ada22d1 guacamole]# ping web
    PING web (172.26.0.4) 56(84) bytes of data.
    64 bytes from guacamole-web.guacamole_net (172.26.0.4): icmp_seq=1 ttl=64 time=0.117 ms
    64 bytes from guacamole-web.guacamole_net (172.26.0.4): icmp_seq=2 ttl=64 time=0.101 ms
    64 bytes from guacamole-web.guacamole_net (172.26.0.4): icmp_seq=3 ttl=64 time=0.126 ms

Cambiamos la password del usuario "guacamole" para poder conectarnos via SSH.

    passwd guacamole
    
Salimos del contenedor y ahora obtenemos su IP. Hacemos

    docker inspect ssh
    
    "IPAddress": "172.26.0.6",
    
Si intentamos hacer ssh desde nuestro equipo a esta ip debe funcionar.

    ssh guacamole@172.26.0.6
    guacamole@172.26.0.6's password: 
    [guacamole@e6f21ada22d1 ~]$ 

Estamos logueados dentro del contenedor via SSH.

Ahora vamos a hacerlo usando Guacamole, que es para hacerlo via web.
Entramos a Guacamole en localhost. Creamos una nueva conexión

Nombre: test
Protocolo: SSH

Nombre de host: 172.26.0.6
Puerto: 22

Usuario: guacamole
Contraseña: la_password_que_elegimos

Guardamos y ya tenemos la conexión disponible en el listado. Con ir a Inicio y clicar
en nuestra conexión ya accedemos por SSH via web :)))

