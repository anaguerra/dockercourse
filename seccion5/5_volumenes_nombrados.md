VOLÚMENES nombrados

La unión de un volumen de host y un volumen anónimo

    docker volume create mysql-data
    
Si vamos a la carpeta de volúmenes (dentro del directorio root de docker) encontramos allí la carpeta
mysql-data.
La carpeta root de docker (recordemos que se busca con `docker info | grep -i root`), que 
en Ubuntu es /var/lib/docker.

Para borrarla:

    docker volumen rm mysql-data
    
    
Para asignar este volumen a un contenedor:

    docker run -d --name mysql -v mysql-data:/var/lib/mysql -p 3306:3306 -e "MYSQL_ROOT_PASSWORD=12345" -e "MYSQL_DATABASE=docker-db" mysql:5.7
    
como se ve, en vez de mapear la carpeta del equipo, se nombra el volumen "mysql-data" que creamos
anteriormente

Si vamos a la carpeta /var/lib/docker/volumes/mysql-data/_data encontramos nuestros ficheros.

La diferencia con el volumen anónimo es que si eliminamos el contenedor con 

    docker rm -fv mysql
    
el volumen no se elimina, persiste. Lo podemos comprobar tecleando `docker volumen ls`






    



    