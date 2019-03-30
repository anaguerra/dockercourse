Eliminar redes
---------------

La nomenclatura es

    docker network rm NOMBRE_RED
    
En nuestro caso, y siguiendo con los ejemplos de las lecciones anteriores, si hacemos 

    docker network rm docker-test-network
    
nos va a dar este error:

    Error response from daemon: error while removing network: network docker-test-network id 8c31f1a4964f26c9a6add0483b86bb413e74c6e42adb22f4c6a9592165cbde67 has active endpoints

O sea, que hay contenedores conectados a esa red. Hay que eliminarlos antes de eliminar 
la red, con:

    docker rm -fv cont1
    docker rm -fv cont2
    
Y luego `docker network rm docker-test-network`. Para comprobar que se eliminó hacemos
`docker network ls | grep docker-test`
    
Lo mismo haremos con la red "test1". Antes de eliminarla hay que eliminar el contenedor 
"micontenedornginx"


    