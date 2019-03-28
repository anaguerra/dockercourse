Apache - PHP - SSL
====================

**Dockerfile**

    FROM centos
    
    RUN \
        yum -y install httpd php php-cli php-common
        
    RUN echo "<?php phpinfo(); ?>" > /var/www/html/hola.php
        
    CMD apachectl -DFOREGROUND
    
El RUN echo es para que nos genere un archivo php para probar que se instaló bien.

Construimos la imagen con 

    docker build -t apache:php .
    
Corremos el contenedor con 

    docker run -d --name miapache -p 80:80 apache:php
    

Si vamos al navegador , en localhost veremos nuestro Apache funcionando.
Para ingresar al contenedor hacemos

    docker exec -ti miapache bash
    
    [root@a5d41fdf9b6b /]# 



