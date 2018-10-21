Buscar imágenes de centos

    docker images | grep centos
    
Si queremos eliminar alguna imagen, existe el comando `rmi`. Se le puede pasar el 
nombre de la imagen (con el tag) o el ID

    docker rmi centos:latest
    
Se pueden eliminar varias imágenes en una misma línea


    docker rmi centos:prueba apache-centos:latest
    
    
