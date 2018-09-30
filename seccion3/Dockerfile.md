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


USER: qué usuario está ejecutando la tarea en este momento. 
Cuando no definimos uno, lo hace el usuario root.

    RUN echo "$(whoami)" > /var/www/html/user1.html
    
    RUN useradd ricardo
    
    USER ricardo
    
    RUN echo "$(whoami)" > /tmp/user2.html 
    
    USER root
    
    RUN cp /tmp/user2.html /var/www/html/user2.html


Log de creación de un contenedor

    docker logs NAME
    
    
VOLUME: Para persistir la data en el contenedor. Que aunque el contenedor muera se queda guardado
 en la máquina
 
 
CMD, dockerignore
---------------------

CMD: lo que mantiene vivo el contenedor. Tiene que ser un proceso en primer plano.
También puede ser un script

    COPY run.sh /run.sh
    
    CMD sh /run.sh

Con  `docker ps -a` vemos en COMMAND lo que se está ejecutando. 
Para ver la salida de `docker ps -a` sin truncar
 
    docker ps --no-trunc


    CONTAINER ID                                                       IMAGE               COMMAND                     CREATED             STATUS              PORTS                NAMES
    592be97c7f6d4f6e572aa338b3d5466405000eaf43c7083e5e7997fa947d4718   apache              "/bin/sh -c 'sh /run.sh'"   4 seconds ago       Up 3 seconds        0.0.0.0:80->80/tcp   gallant_edison

Si hacemos un log del container (por NAME, gallant_edison) vemos el echo de sh

    $ docker logs -f gallant_edison
    iniciando contenedor...


El dockerignore es normalmente un archivo oculto. 
Definimos qué archivos NO QUEREMOS ENVIAR al contenedor


#LISTAR CONTENEDORES docker ps -a
#docker rm -fv NAME --> Eliminar contenedor NAME
#docker build -t apache .
#docker run -d -p 80:80 apache

**Dockerfile con todos los argumentos vistos**

Constuir imagen, con un tag (v1)

    docker build -t nginx:v1 .
    
Correr el contenedor

    docker run -d -p 80:80 nginx:v1
    
Comprobamos que esté levantado
    
    docker ps 
    
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                        NAMES
    ebd314b557dd        nginx:v1            "/bin/sh -c 'nginx -…"   4 seconds ago       Up 2 seconds        0.0.0.0:80->80/tcp, 90/tcp   zealous_brattain
  
Comprobamos que en localhost tenemos el site de fruit

Y comprobamos que la imagen está

    docker images | grep nginx

