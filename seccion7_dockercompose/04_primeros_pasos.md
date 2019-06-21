Primeros pasos
---------------


Creamos un directorio dockercompose donde almacenaremos todo lo de esta sección

Docker compose lo que hace es ayudarnos a automatizar el proceso de creación de contenedores

Para crear un contenedor normal hacemos

    docker run -d --name mi-nginx -p 80:80 nginx

Vamos a crearlo con docker-compose.
En docker-compose lo definimos todo en un fichero yml. Por defecto se llama `docker-compose.yml`

Se compone de 4 grandes partes

    version:
    services:
    volumes:
    networks:
    
Las dos últimas son opcionales. Las dos primeras son obligatorias.
   
En version ponemos la más reciente: 3
   
    version: '3'
    
En "services" añadimos nuestros contenedores. Les damos los nombres que queramos.

    services:
        web:
            container_name: mi-nginx
            ports:
                - "8080:80"
            image: nginx
             
              
NOTA: El "-d" var por defecto siempre     
Documentación del fichero yml: https://docs.docker.com/compose/compose-file/
        
Para crear el contenedor hacemos EN EL MISMO DIRECTORIO del docker-compose.yml

     docker-compose up -d
     
    Creating network "dockercompose_default" with the default driver
    Creating mi-nginx ... done

Con `docker ps -a` lo vemos en nuestra lista

    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
    a400779cf7cc        nginx               "nginx -g 'daemon of…"   36 seconds ago      Up 34 seconds       0.0.0.0:8080->80/tcp   mi-nginx

Y para verlo funcionando vamos a localhost:8080


Para eliminarlo con docker-compose hacemos

    docker-compose down

    Stopping mi-nginx ... done
    Removing mi-nginx ... done
    Removing network dockercompose_default

Como se ve, también se eliminó la red por defecto que se creó al crear el contenedor.

Y ya en localhost:8080 no tenemos nada.