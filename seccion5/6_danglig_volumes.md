Danglig VOLÚMES

Cuando borramos contenedores sin borrar volúmenes se quedan colgados.

Con este comando vemos los volúmenes que no están ya referenciados a ningún contenedor: 

    docker volume ls -f dangling=true -q
    
Para eliminarlos 

    docker volume ls -f dangling=true -q | xargs docker volume rm
    
    
Es mejor siempre utilizar volúmenes de host o nombrados. Anónimos no recomendados.



