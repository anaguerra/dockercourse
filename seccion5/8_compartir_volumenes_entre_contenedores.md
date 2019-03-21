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
    
Queremos que todo lo que haya en /home/ana.vega se guarde en "/opt/volumen/common".



**Compartir ...**

Vamos a crear un contenedor de Nginx

    docker run -d --name nginx -v /opt/volumen/common:/usr/share/nginx/html -p 80:80 nginx:alpine
    
Lo que se genere en nginx(alpine) se guardará en nuestra carpeta common.

Si hacemos un `docker ps` veremos nuestro nginx funcionando.



