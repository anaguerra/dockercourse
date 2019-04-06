Volúmenes
---------------

Recordemos que existen 3 tipos de volúmenes: anónimos, nombrados y de host

Vamos a ver nombrados y de host

**Volumen nombrado**

Con Docker haríamos

    docker volume create nombre_que_queramos
    
Con compose

    version: '3'
    services:
        web:
            container_name: mi-nginx
            ports:
                - "8080:80"
            volumes: 
                - "mi-vol:/usr/share/nginx/html"
            image: nginx
    volumes: 
        mi-vol: 
             
    
En /usr/share/nginx/html es donde nginx guarda sus ficheros html. Entonces creamos el 
volumen "mi-vol" y se lo montamos al contenedor

    docker-compose up -d
    
    Creating network "dockercompose_default" with the default driver
    Creating volume "dockercompose_mi-vol" with default driver
    Creating mi-nginx ... done

Observamos que el volumen que se creó se llama "dockercompose_mi-vol".
 
Si vamos a localhost:8080 está funcionando nuestro contenedor.

Cómo validamos que funciona nuestro volumen. Vamos a la ruta del document root de Docker 
(recordamos, se busca con `docker info | grep -i root`), que es `/var/lib/docker`
   
       sudo su
       cd /var/lib/docker
       cd volumes
       ll
       
Vemos la carpeta de nuestro volumen

    drwxr-xr-x  3 root root   4096 abr  6 11:22 dockercompose_mi-vol

Entramos a la carpeta del volumen y

    cd dockercompose_mi-vol
    cd _data
    ll

Modificamos nuestro index y ponemos ":)" , cuando vamos a localhost:8080 veremos esos 
caracteres en el navegador.


Otra forma de comprobar que el volumen funciona:

    docker-compose down
    
Elimina contenedor y red pero no el volumen. Y si lo levantamos de nuevo se mapeará de nuevo
con la data persistente y veremos nuestro icon ":)".



**Volumen de host**

Primero que nada miramos dónde tenemos/queremos el código fuente. P.e. en
 "/home/ana/Documentos/dockercompose/html". Creamos ahí un index.html

Nuestro docker-compose.yml

    version: '3'
    services:
        web:
            container_name: mi-nginx
            ports:
                - "8080:80"
            volumes: 
                - "/home/ana/Documentos/dockercompose/html:/usr/share/nginx/html"
            image: nginx
    
Levantamos

    Recreating mi-nginx ... done
    
Vamos al localhost:8080 y vemos nuestro index.html  :))))


     