Red definida por usuario
---------------

Vamos a crear una red usando el driver "brigde". 


    docker network create test-network
    
    
Si listamos ahora las redes con `docker network ls` nos aparece test-network

    NETWORK ID          NAME                DRIVER              SCOPE
    dbc32079dcd7        bridge              bridge              local
    ebb4f44b7faa        host                host                local
    162a2ed58233        none                null                local
    a4f9b7cd2c35        test-network        bridge              local


Y el rango que usa es 172.18.0.x

     docker network inspect test
     
     
    {
        "Name": "test-network",
        "Id": "a4f9b7cd2c35a59972e61bb167302df6b177406b3248a48537600f090dc7b30f",
        "Created": "2019-03-29T10:53:20.483235411Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]


**Crear red definiendo driver y subnet**

    docker network create -d bridge --subnet 172.124.10.0/24 --gateway 172.124.10.1 docker-test-network 
    
Comprobamos que se creó 

    docker network ls | grep docker-test
    
