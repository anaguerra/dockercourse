**compartir volúmenes**

Creamos un directorio "volumen" y dentro de el:

Creamos un fichero Dockerfile con:

    FROM centos
    
    COPY start.sh /start.sh
    
    RUN chmod +x /start.sh
    
    CMD /start.sh


El fichero start.sh será este:

    #!/bin/bash
    
    while true; do
        echo $(date +%H:%M:%S) >> /home/ana.vega/index.html && \
        sleep 10
    done
        
Para construir la imagen:

    docker build -t generador .


Vamos a correr la imagen con ($PWD es la ruta actual):
    
    docker run -v /opt/volumen/common:/home/ana.vega -d --name gen generador
    
Queremos que todo lo que haya en "/home/ana.vega" se guarde en "/opt/volumen/common".

Ahora si hacemos 

    tailf /opt/volumen/common/index.html 
    
veremos el contenido del archivo con la hora escrita cada 10 seg. Ojo, en /home/ana/ no 
hay ningún fichero index.html. Ya la salida se vuelca directamente en la otra carpeta.



Ahora vamos a crear un contenedor de Nginx, para compartir el volumen /opt/volumen/common

    docker run -d --name nginx -v /opt/volumen/common:/usr/share/nginx/html -p 81:80 nginx:alpine
    
Lo que se genere en nginx(alpine) se guardará en nuestra carpeta common.

Si hacemos un `docker ps` veremos nuestro nginx funcionando en el puerto 81 y se ve en el 
index.html la hora cada 10 seg, y según vamos actualizando.

Formateamos el html, modificando el script start.sh en la línea del echo

        echo "<p> $(date +%H:%M:%S) </p>" >> /home/ana.vega/index.html && \

Eliminamos todos los contenedores y reconstruimos con build y run

    docker rm -fv $(docker ps -aq)
    docker build -t generador .
    docker run -v /opt/volumen/common:/home/ana.vega -d --name gen generador
    docker run -d --name nginx -v /opt/volumen/common:/usr/share/nginx/html -p 81:80 nginx:alpine
    
Y ya vemos formateada la hora en el navegador


RESUMEN

El "generador" ejecuta el start.sh, que envía párrafos html con la fecha hacia un index. Luego ese
volumen está siendo compartido con nginx, enviándolo al document root de Nginx.
Generador deja el fichero en un volumen compartido, y nginx lo lee.


