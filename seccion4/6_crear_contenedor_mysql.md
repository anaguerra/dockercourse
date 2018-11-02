
1) Descargamos la imagen del repo oficial, https://hub.docker.com/_/mysql/

    
    docker pull mysql
    

Para iniciar la instancia, según la documentación: 


"`docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag`
where some-mysql is the name you want to assign to your container, my-secret-pw is the 
password to be set for the MySQL root user and tag is the tag specifying the MySQL version 
you want. See the list above for relevant tags."

Entonces

    docker run -d --name my-db1 -e "MYSQL_ROOT_PASSWORD=12345" mysql:5.7
    
para ver lo que está ocurriendo en el contendor:

    docker logs -f my-db1
    
Cuando se ve "mysqld:ready for connections" ya se puede usar
OJO: No hemos mapeado puertos. Entonce si tratamos de entrar al mysql con: 

    mysql -u root -p12345
    
Nos da un error de

    ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2 "No such file or directory")

Sin necesidar de mapear podemos llegar a la base de datos
Con `docker inspect my-db1` obtenemos un JSON con toda la información del contenedor. Entre
ellas la ip:

        "IPAddress": "172.17.0.2",

Entonces, ahora podemos hacer:

    mysql -u root -h 172.17.0.2 -p12345
    
Y ya tenemos:

    Welcome to the MariaDB monitor.  Commands end with ; or \g.
    Your MySQL connection id is 2
    Server version: 5.7.21 MySQL Community Server (GPL)
    
    Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.
    
    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
    
    MySQL [(none)]> 



**Para usar el mysql como localhost**

Hay que tener el mapeo de puertos
Creamos otro contenedor, y usamos más variables de entorno:

    docker run -d -p 3306:3306 --name my-db2 -e "MYSQL_ROOT_PASSWORD=12345" -e "MYSQL_DATABASE=docker" -e "MYSQL_USER=docker" -e "MYSQL_PASSWORD=54321" mysql:5.7 

Y ahora ya podemos entrar al mysql en localhost, tanto como root como con el nuevo usuario
qu ehemos creado

    mysql -u root -p12345 -h 127.0.0.1
    mysql -u docker -p54321 -h 127.0.0.1

Eliminar los contenedores:

    docker rm -fv $(docker ps -aq)
    







    


    