Asignar IP a un contenedor
---------------

Creamos una red

    docker network create --subnet 172.128.10.0/24 --gateway 172.128.10.1 -d bridge my-network
    
Comprobamos que se ha creado con `docker network inspect my-network`

Si creamos un contenedor en esta red y queremos especificar una IP hacemos:

    docker run --network my-network --ip 172.128.10.50 -d --name nginx1 -ti centos
    
Si no especificamos la IP, se crea con una ip al azar.    

Para comprobar que se creó correctamente podemos verlo con 

    docker network inspect my-network
    
y en el apartado "Containers" se ve el contenedor
O con 
    
    docker inspect nginx1
    
 y se ve en el apartado "Networks" la ip.
 
 