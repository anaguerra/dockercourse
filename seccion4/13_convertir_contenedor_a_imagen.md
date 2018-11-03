En realidad lo mejor es hacer volúmenes

Creamos Dockerfile

    FROM centos
    
    VOLUME  /opt/volumen
    
Construimos imagen

    docker build -t centos-test .
    
Creamos contenedor

    docker run -dti --name centos centos-test
    
Entramos al contenedor y modificamos algo dentro. Esos cambios son temporales.
Si los cambios son fuera de la ruta de VOLUME se perderán al destruir el contenedor.

Si hacemos cambios y nos interesa capturarlos

    docler commit centos centos-resultante
    
Si eliminamos el contenedor y creamos otro con la misma imagen, al entrar al contenedor tenemos
los cambios de la ejecución anterior del contenedor, que NO esté en la ruta de VOLUME.

https://docs.docker.com/engine/reference/commandline/commit/



    