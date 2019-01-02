Si creamos el contenedo de MySQL de esta manera:

    docker run -d --name db -p 3306:3306 -e "MYSQL_ROOT_PASSWORD=12345" -v /var/lib/mysql mysql:5.7
    
, sin especificar la carpeta de volumen en mi máquina, Docker asignará una carpeta automáticamente
en mi equipo, a azar. Es por esto que se llaman anónimos.

Para encontrar esa carpeta escribimos

    docker info | grep -i root
    
y nos lista nuestro document root de Docker:

    Docker Root Dir: /var/lib/docker

Vamos como root a esa carpeta, y encontramos la carpeta "volumes" y al listar el contenido veremos
una carpeta con nombre de este tipo:

    83a23b14a9ba1c7bbef3cd372fa8adcc2c841754a00daf3a750050a88ef4ad8a

Otra opción para encontrar la carpeta en nuestro ordenador (siempre dentro del document root de docker) 
es

    docker inspect mysql | grep "Name"

    "Name": "83a23b14a9ba1c7bbef3cd372fa8adcc2c841754a00daf3a750050a88ef4ad8a",
    
Los volúmenes anónimos se borran al eliminar el contenedor con -v

    docker rm -f
    
    
No es aconsejable usar volúmenes anónimos. 

    
    

    

    