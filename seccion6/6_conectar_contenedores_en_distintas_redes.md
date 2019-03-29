Conectar contenedores en distintas redes
---------------

Hasta ahora tenemos dos redes, test1 y docker-test-network. Una con configuración asignada por 
Docker por defecto y otra en la que definimos el rango nosotros.

    docker network ls | grep test
    
    6eae3b074699        docker-test-network   bridge              local
    d491855c9a52        test1                 bridge              local

Lo cual podemos ver con `docker network inspect nombre`

Asimismo, el contenedor "micontenedornginx" está en la red "test1" y "cont1" y "cont2" están
en la red "docker-test-network"

**docker connect**

Si queremos conectar micontenedornginx a docker-test-network hacemos

    docker network connect docker-test-network micontenedornginx
    
Si hacemos `docker inspect micontenedornginx` vemos...

    "Networks": {
                    "docker-test-network": {
                        "IPAMConfig": {},
                        "Links": null,
                        "Aliases": [
                            "be91dbf01a93"
                        ],
                        "NetworkID": "6eae3b074699ce562d25d59f2070ed6af0b52fd80f19ced0ca023e27d96a518c",
                        "EndpointID": "e4132c719cb87abba17a1646d2c165a11eb1eb45297cce7687822209ef0d873c",
                        "Gateway": "172.124.10.1",
                        "IPAddress": "172.124.10.4",
                        "IPPrefixLen": 24,
                        "IPv6Gateway": "",
                        ....
                    },
                    "test1": {
                        "IPAMConfig": null,
                        "Links": null,
                        "Aliases": [
                            "be91dbf01a93"
                        ],
                        "NetworkID": "d491855c9a52ff3140bd357f7561116c4b91fc869f6f4cf75cb0eef4d034f413",
                        "EndpointID": "798541817b0267e0dd75204c30878e5de907579071dcf6c00afc5034c9cced98",
                        "Gateway": "172.19.0.1",
                        "IPAddress": "172.19.0.2",
                        "IPPrefixLen": 16,
                        "IPv6Gateway": "",
                        ....
                    }
 
Pertenece a dos redes!

Si ahora hacemos `docker exec cont1 bash -c "ping micontenedornginx"` ....

    PING micontenedornginx (172.124.10.4) 56(84) bytes of data.
    64 bytes from micontenedornginx.docker-test-network (172.124.10.4): icmp_seq=1 ttl=64 time=0.376 ms
    64 bytes from micontenedornginx.docker-test-network (172.124.10.4): icmp_seq=2 ttl=64 time=0.102 ms


**Desconectar contenedor de una red**

Para quitar "micontenedornginx" de la docker-test-network hacemos

    docker network disconnect docker-test-network micontenedornginx
    
Si ahora hiciéramos el ping no funcionará. Y si hacemos el inspect veremos que sólo pertenece
a la red "test1"





    