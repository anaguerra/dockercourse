Apache - PHP - SSL
====================

**Dockerfile**

    FROM centos
    
    RUN \
        yum -y install httpd php php-cli php-common
        
    CMD apachectl -DFOREGROUND
    

Construimos la imagen con 

    docker build -t apache:php .
    
Corremos el contenedor con 

    docker run -d --name miapache -p 80:80 apache:php
    

Si vamos al navegador , en localhost veremos nuestro Apache funcionando.
Para ingresar al contenedor hacemos

    docker exec miapache bash
    
    [root@a5d41fdf9b6b /]# 



