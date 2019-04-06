Variables entorno docker compose
---------------

Para este ejemplo creamos un servicio "db".

    version: '3'
    services:
        db:
            image: mysql:5.7
            container_name: mysql
            ports:
                - "3306:3306"
            environment:
                - "MYSQL_ROOT_PASSWORD=12345678"
    
    
En la documentación nos indican que podemos crearlas de dos formas:

    environment:
      RACK_ENV: development
      SHOW: 'true'
      SESSION_SECRET:
    
    environment:
      - RACK_ENV=development
      - SHOW=true
      - SESSION_SECRET
      
      
Entonces creamos el contenedor con `docker-compose up -d`:

    Creating network "dockercompose_default" with the default driver
    Creating mysql ... done

Con `docker ps` lo vemos funcionando.

Entramos al contenedor con 

    docker exec -ti mysql bash
    
    root@0fc95a300258:/# 
    
Y nos logueamos en mysql con la contraseña que definimos en las variables de entorno:

    root@0fc95a300258:/# mysql -u root -p12345678

Y....

    mysql: [Warning] Using a password on the command line interface can be insecure.
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 2
    Server version: 5.7.21 MySQL Community Server (GPL)
    
    Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.
    
    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.
    
    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
    
    mysql>    


**Otra manera de hacerlo**

Creamos la contraseña en un fichero p.e de extensión "env", p.e. "common.env"

    MYSQL_ROOT_PASSWORD=12345678

Y en nuestro docker-compose.yml:

    version: '3'
    services:
        db:
            image: mysql:5.7
            container_name: mysql
            ports:
                - "3306:3306"
            env_file: "common.env"
                
Volvemos a crear el contenedor, ingresamoes en el y escribimos "env":

    root@31d714b5d91d:/# env
    hola=hola12
    HOSTNAME=31d714b5d91d
    MYSQL_ROOT_PASSWORD=12345678
    PWD=/
    HOME=/root
    MYSQL_MAJOR=5.7
    GOSU_VERSION=1.7
    MYSQL_VERSION=5.7.21-1debian9
    TERM=xterm
    SHLVL=1
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    _=/usr/bin/env

    

