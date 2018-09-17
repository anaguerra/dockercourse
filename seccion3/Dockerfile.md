Introducción al Dockerfile
============================

FROM, RUN, COPY/ADD
--------------------

COPY y ADD Son comandos similares salvo que ADD permite agregar URLs


ENV, WORKDIR, EXPOSE
-----------------------

    ENV contenido prueba
    
contenido es la variable y prueba el valor


WORKDIR: dónde estás trabajando actualmente


LABEL, USER, VOLUME
----------------------

LABEL: puede ir a cualquier nivel del Dockefile. Es metadata de la imagen. 

    LABEL version=1.0
    LABEL description="This is an apache image"
    
Si se añaden antes de la instalación, la metadata se guarda en la imagen y por tanto se fuerza la recreación de la imagen.


USER: qué usuario ejecuta la tarea. Cuando no definimos uno, lo hace el usuario root.

    RUN echo "$(whoami)" > /var/www/html/user1.html
    
    RUN useradd ricardo
    
    USER ricardo
    
    RUN echo "$(whoami)" > /tmp/user2.html 
    
    USER root
    
    RUN cp /tmp/user2.html /var/www/html/user2.html


Log de creación de un contenedor

    docker logs NAME
    
    
    