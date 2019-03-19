**compartir volúmenes**

Creamos un directorio "test" y dentro de el:

Creamos un fichero Dockerfile con:

    FROM centos
    
    COPY start.sh /start.sh
    
    RUN chmod +x /start.sh
    
    CMD /start.sh


El fichero start.sh será este:

    #!/bin/bash
    
    while true; do
        echo $(date +%H:%M:%S) >> /opt/index.html && \
        sleep 10
    done
        
Para construir el contenedor

    docker build -t generador .

 
    