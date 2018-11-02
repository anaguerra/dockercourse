Es una variable a la que podemos acceder desde cualquier parte del contenedor

Se pueden definir en varios sitios

1) Dockerfile

 
    FROM centos
    
    ENV prueba 1234
    
    RUN useradd ricardo
    
Creamos el contenedor de esta imagen "env" y lo llamamos env

    docker run -dti --name env env
    
Ingresamos al contenedor

    docker exec -ti env bash

Si hacemos `echo $prueba` obtenemos 1234.


**Definir una variable de entornos al crear el contenedor**

Creamos otro contenedor de esta manera:

    docker run -dti -e "prueba1=4321" --name environment env

Con "-e" creamos variable de entorno.
Con docker ps veremos esto:

    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
    456300db9017        env                 "/bin/bash"         5 seconds ago       Up 4 seconds                            environment
    7933906b85bc        env                 "/bin/bash"         4 minutes ago       Up 4 minutes                            env

Si entramos al segundo contenedor y tecleamos "env" veremos

    HOME=/root
    prueba=1234
    prueba1=4321

