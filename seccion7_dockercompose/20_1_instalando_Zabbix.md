Instalar Zabbix
---------------

Zabbix es una herramienta de monitereo de servidores


El docker-compose.yml

    version: '3'
    services:
      zabbix:
        container_name: zabbix-web
        image: zabbix
        build: .
        volumes:
          - "$PWD/html:/usr/share/zabbix"
        ports:
          - "80:80"
        networks:
          - net
      db:
        container_name: zabbix-db
        image: mysql:5.7
        environment:
          MYSQL_ROOT_PASSWORD: 123456
          MYSQL_USER: zabbix
          MYSQL_PASSWORD: zabbix
          MYSQL_DATABASE: zabbix
        volumes:
          - "$PWD/data:/var/lib/mysql"
          - "$PWD/conf/create.sql:/docker-entrypoint-initdb.d/zabbix.sql"
        ports:
          - "3306:3306"
        networks:
          - net
    networks:
      net:

Dos servicios, un webserver "zabbix" y un MySQL, "db"

La imagen oficial de Zabbix por lo visto no está muy fina y es una hecha por el profesor.

El servicio "zabbix" se crea a partir del Dockerfile que está en la misma carpeta. Esto se indica en 

    build: .
    

Se le mapea un volumen a "nuestracarpeta/html". En esa carpeta tenemos una instalación limpia.

    volumes:
       - "$PWD/html:/usr/share/zabbix"
       
Zabbix leerá los archivos de nuestra carpeta html.

En el servicio "db" tenemos dos volúmenes. Uno para persistir la base de datos y otro

    - "$PWD/conf/create.sql:/docker-entrypoint-initdb.d/zabbix.sql"
    
que es un esquema inicial de base de datos que se va a importar a la bd zabbix cuando el contenedor arranque por primera
vez.
La imagen oficial de MySQL tiene esta funcionalidad: si colocamos en un volumen un fichero .sql, en la ruta "/docker-entrypoint-initdb.d/" 
lo que hará cuando inicie la base de datos es importar el sql en la base de datos que hayamos definido en  la variable de entorno
MYSQL_DATABASE.

Analizamos el Dockerfile

El Dockerfile

    FROM centos:7
    
    ENV ZABBIX_REPO http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm
    
    RUN                              \
      yum -y install $ZABBIX_REPO && \
      yum -y install                 \
         zabbix-get                  \
         zabbix-server-mysql         \
         zabbix-web-mysql            \
         zabbix-agent
    
    EXPOSE 80 443
    
    COPY ./bin/start.sh /start.sh
    
    COPY ./conf/zabbix-http.conf /etc/httpd/conf.d/zabbix.conf
    
    COPY ./conf/zabbix-server.conf  /etc/zabbix/zabbix_server.conf
    
    COPY ./conf/zabbix-conf.conf /etc/zabbix/web/zabbix.conf.php
    
    VOLUME /usr/share/zabbix /var/log/httpd
    
    RUN chmod +x /start.sh
    
    CMD /start.sh
    
    
La variable de entorno ZABBIX_REPO es la URL del repositorio de Zabbix. Tenemos que instalarlo para poder acceder a los paquetes.

En RUN instalamos el repo y los diferentes paquetes.

Se exponen los puertos por defecto.

En la siguiente línea se copia el start.sh

    #!/bin/bash
    
    # Start zabbix server
    /usr/sbin/zabbix_server -c /etc/zabbix/zabbix_server.conf
    
    # Start zabbix agent
    /usr/sbin/zabbix_agentd
    
    # Start httpd
    apachectl -DFOREGROUND
    
que lo que hace es iniciar el zabbix server y luego el agente. Y finalmente inicia Apache.

Luego tenemos otra línea con la configuración de Apache para Zabbix.

La siguiente línea es la configuración del Zabbix Server. Se puede encontrar en github. 
    
    COPY ./conf/zabbix-server.conf  /etc/zabbix/zabbix_server.conf

Si examinamos el fichero .conf podemos ver que en la conexión a la base de datos se especifica el servicio como el DBHOST, 
así como la bd y las credenciales.

    DBHOST=db
    DBUSER=zabbix
    ...
    
La siguiente línea es la configuración del agente. Si abrimos el fichero .conf, vemos variables de configuración
en PHP.

En la siguiente línea se define un volumen, donde estarán los archivos de log.

Y por último se dan permisos de ejecución al script y se lanza.


Levantamos los servicios con `docker-compose up -d`

Una vez acabada la instalación comprobamos que están los servicios:

    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                         NAMES
    9f9ef4ec73b5        zabbix              "/bin/sh -c /start.sh"   8 minutes ago       Up 8 minutes        0.0.0.0:80->80/tcp, 443/tcp   zabbix-web
    daa188b14db1        mysql:5.7           "docker-entrypoint.s…"   8 minutes ago       Up 8 minutes        0.0.0.0:3306->3306/tcp        zabbix-db

Antes de nada vamos a ver los logs de la base de datos. Recordemos que se hacía un import de un fichero SQL.
Entonces miramos el log del servicio de base de datos. Con `docker logs -f zabbix-db`. Y así comprobamos si
acabó la importación.

    2019-05-01T17:35:21.579409Z 0 [Note] mysqld: ready for connections.
    Version: '5.7.21'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)

Listo pues.

Ahora vamos al navegador y escribimos "localhost/zabbix" y vemos nuestro Zabbix funcionando.
username: admin
password: zabbix



 



