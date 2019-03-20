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
        echo $(date +%H:%M:%S) >> /opt/volumen/common/index.html && \
        sleep 10
    done
        
Para construir la imagen:

    docker build -t generador .


Vamos a correr la imagen con ($PWD es la ruta actual):
    
    docker run -v $PWD/common:/opt -d --name gen generador  
    