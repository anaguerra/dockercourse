Conectar contenedores en la misma red
---------------

    docker run -dti --network docker-test-network --name cont1 centos 
    
    docker run -dti --network docker-test-network --name cont2 centos
    
Si inspeccionamos los contenedores vemos que tienen las ip's 172.124.10.2 y 172.124.10.3

Recordemos que para entrar a la consola del contendor: `docker exec -ti cont1 bash`

En la red por defecto de Docker no podemos hacer ping a los contenedores por su nombre, pero
en las definidas por usuario sí que se puede.

    ~$ docker exec cont1 bash -c "ping cont2"
    PING cont1 (172.124.10.2) 56(84) bytes of data.
    64 bytes from cont2.docker-test-network (172.124.10.3): icmp_seq=1 ttl=64 time=0.083 ms
    64 bytes from cont2.docker-test-network (172.124.10.3): icmp_seq=2 ttl=64 time=0.132 ms

Lo que no se puede es hacer ping entre contenedores de diferentes redes. Obvio.



    