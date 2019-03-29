Agregar contenedores a una red distinta a la por defecto
---------------

Queremos conectar un contenedor (test3) a la red que creamos: "docker-test-network"

    docker run --network docker-test-network -dti --name test3 centos

Si hacemos `docker inspect test3`, en el apartado de redes tenemos..


    "Networks": {
        "docker-test-network": {
            "IPAMConfig": null,
            "Links": null,
            "Aliases": [
                "c0cd67f8ca9e"
            ],
            "NetworkID": "6eae3b074699ce562d25d59f2070ed6af0b52fd80f19ced0ca023e27d96a518c",
            "EndpointID": "b071ae59eca5a0d28ca8678a87db557bff36db205f624709762660b64b67882e",
            "Gateway": "172.124.10.1",
            "IPAddress": "172.124.10.2",
            "IPPrefixLen": 24,
            ...
            
Vemos que la red a la que el contenedor se adjuntó es "docker-test-network" y se le
asignó una ip de su subrango. Esto siempre lo podemos comprobar con

    docker network inspect docker-test-network    
   


**RESUMEN**

Crear red: `docker network create test1`
    
Crear contenedor dentro de nuestra red: `docker run -d --name micontenedornginx --network test1 nginx` 

Verificar que se creó en "test1": `docker inspect micontenedornginx`
