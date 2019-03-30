La red None
---------------

Existe una red por defecto llamada "none". La vemos con `docker network ls`. Viene con Docker
por defecto.

Sirve para que los contenedores que metamos ahí no tengan red

    docker run --network none --name hola -dti centos
    
Al hacer `docker inspect hola` vemos que en Networks está adjuntado a esta red.
    
    
