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
    
    
    
