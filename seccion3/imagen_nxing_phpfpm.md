En centos, para instalar nginx es

    yum -y install nginx --enablerepo=nginx
    
El "nginx" de enablerepo se refiere al fichero nginx.repo

Instalación de PHP: 

    https://linuxize.com/post/install-php-7-on-centos-7/

Y los paquetes:

    https://ius.io/Packages/
    
Para crear la imagen

    docker build -t test1 .
    
Para correrla

    docker run -d --name test3 -p 80:80 test1   

Y con `docker ps` la podemos ver

    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                         NAMES
    53b274a64372        test1               "/bin/sh -c /start.sh"   28 seconds ago      Up 27 seconds       0.0.0.0:80->80/tcp, 443/tcp   test3

Para validar que funciona bien, vamos al navegador, ponemos localhost y debemos ver
la página de info de PHP.                