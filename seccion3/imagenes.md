imágenes oficiales
---------------------
Se descargan de Docker Hub

https://hub.docker.com/_/mongo/


    docker pull mongo

tag: qué versión de imagen es

Si al descargar la imagen no especificamos un tag, se descarga la última

    docker pull mongo:3.6.5-jessie
    

Utilizamos imágenes oficiales cuando ya existe una imagen con lo que necesitamos.

Si ya tenemos la última versión de una imagen y en el repositorio oficial se ha actualizado la "latest"
si hacemos otra vez `docker pull mysql` se descarga la latest actualizada pero no se borra la anterior.
Se quedará como "dangling" (colgada).

    REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
    mongo                latest              e3985c6fb3c8        8 days ago          381MB
    dockbox_mongo        latest              1a9e31791085        5 months ago        366MB
    mongo                <none>              5b1317f8158f        6 months ago        366M
 

**Crear nuestras propias imágenes**

P.e: necesitamos Apache con PHP, y queremos una versión antigua de PHP y no la 
encontramos en docker hub.

[docker-images/DockerFile.md](docker-images/Dockerfile.md) 

FROM centos (cogerá la última)

Para RUN buscamos "como instalar Apache en Centos". Nos dará este comando:

    yum install httpd -y
    
"-y" se pone porque la instalación mediante comandos requiere a veces confirmaciones 
de usuario (y/n) y no vamos a tener interacción con la instalación. El -y indicará afirmativo
para todo.

**docker build**

Comando que construye imágenes tomando como base un Dockerfile

    docker build -t apache-centos .
    
"-t" es el tag (también se puede poner --tag), el nombre que le ponemos a la imagen
"." indica que instalará en el directorio actual 

Al hacer el build, si no tuviéramos alguna imagen de las oficiales que usamos instalada se autodescarga.

El proceso mostrará

    Step 1/2 : FROM centos ...
    
Cuando acabe...

    Complete!
    Removing intermediate container 33b6c75cf1d8
     ---> 50dd475d1583
    Successfully built 50dd475d1583
    Successfully tagged apache-centos:latest

Se etiquetó como apache-centos:latest porque no especificamos ningún tag. Para ello podemos poner

    docker build --tag apache-centos:primera .


**docker history**

    docker history -H apache-centos
El -H es "human radable format"
Es un comando para ver las capas que se crearon:

    IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
    50dd475d1583        4 minutes ago       /bin/sh -c yum install httpd -y                 126MB               
    5182e96772bf        5 weeks ago         /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
    <missing>           5 weeks ago         /bin/sh -c #(nop)  LABEL org.label-schema.sc…   0B                  
    <missing>           5 weeks ago         /bin/sh -c #(nop) ADD file:6340c690b08865d7e…   200MB               

Lo que hemos es agregar capas sobre la capa FROM. La imagen tenía 3 capas originales y nosotros hemos
añadido la que dice la primera línea: `/bin/sh -c yum install httpd -y


**Crear un contenedo respecto a la imagen que hemos creado**

Si creamos un contenedor con esa imagen, lo más probable es que se "muera".

Para ver listado de contenedores:

    docker ps -a
    
Borrar por nombre:

    docker rm -fv NAME

Crear un contenedo a partir de nuestra imagen "apache-centos"

    docker run -d apache-centos
    
Aquí vemos como se "murió" (con docker ps -a) 
(en el listado aparece un nombre aleotorio porque no pusimos ninguno)

    CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS                      PORTS               NAMES
    3cede13d1996        apache-centos        "/bin/bash"              11 seconds ago      Exited (0) 10 seconds ago                       stupefied_edison

Se "murió" porque para crear un contenedo hace falta la capa CMD (COMMAND). Si no se pone nada, usa
el CMD de la imagen de centos (/bin/bash).

Para saber cuál será el CMD de Apache buscamos "run apache in foreground"

    CMD apachectl -DFOREGROUND

Ejecutará el servicio de Apache en primer plano.
 
    docker run -d --name apache apache-centos

Se volvió a morir porque el Dockerfile no lo hemos hecho "imagen". Hay que construir la imagen nuevamente.

Para ello: 
    
    docker build -t apache-centos:apache-cmd .

Ahora tirará de caché y solo hará la 3ª capa

    Sending build context to Docker daemon  2.048kB
    Step 1/3 : FROM centos
     ---> 5182e96772bf
    Step 2/3 : RUN yum install httpd -y
     ---> Using cache
     ---> 50dd475d1583
    Step 3/3 : CMD apachectl -DFOREGROUND
     ---> Running in d1e94bd5dd1b
    Removing intermediate container d1e94bd5dd1b
     ---> c207be54cf47
    Successfully built c207be54cf47
    Successfully tagged apache-centos:apache-cmd

Si miramos la historia de la imagen ahora aparecerá la capa nueva con el CMD.

Ahora borramos el anterior contenedor

    docker rm -fv apache
    
Finalmente lo reconstruimos con la nueva imagen:

    docker run -d --name apache apache-centos:apache-cmd
    
"-d" --> Para que se vaya al fondo
"--name apache" --> nombre del contenedor
"apache-centos:apache-cmd" --> imagen:tag 
    
    
    CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS              PORTS               NAMES
    658e3c8770a1        apache-centos:apache-cmd   "/bin/sh -c 'apachec…"   16 seconds ago      Up 15 seconds                           apache


**vamos a hacer algo más avanzado**
    
    docker run -d --name apache -p 80:80 apache-centos:apache-cmd

-p: el puerto 80 de nuestra máquina se va a mapear al puerto 80 del contenedor. Y es para poder ver el
servicio via web.
Si lo corremos sin el puerto no veremos nada.    




**Dangling images**

https://juanfranncisco.wordpress.com/2017/11/07/como-eliminar-imagenes-contenedores-y-volumenes-en-docker/
