Red por defecto
---------------
Existen 3 redes preconfiguradas en Docker, que se listan con

    docker network ls
    
    NETWORK ID          NAME                DRIVER              SCOPE
    dbc32079dcd7        bridge              bridge              local
    ebb4f44b7faa        host                host                local
    162a2ed58233        none                null                local

1. Bridge. La red standard que usarán todos los contenedores.
2. Host. El contenedor usará el mismo IP del servidor real que tengamos.
3. None. Se utiliza para indicar que un contenedor no tiene asignada una red.


Cuando instalamos docker, si escribimos

    ip a | grep docker

Vemos que tenemos una interfaz nueva en nuestra lista de interfaces, docker0, la cual 
tiene su propia ip

    4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
    
y le asigna un rango de subnet.

Cuando creamos un contenedor de ejemplo sin definir ningún tipo de red, p.e.

    docker run -dti --name test centos 
        
Si hacemos el inspect del contenedor...

    docker inspect test
    
vemos que la red a la que se conecta tiene que ser una "172.17.0.algo" 

    "IPAddress": "172.17.0.2",
    
y el Gateway es la IP de la interfaz por defecto de Docker (docker0).

    "Gateway": "172.17.0.1"
    
Si no especificamos una red al crear los contenedores, se van a crear en la red 
por defecto "bridge".


**Listado todas las redes**

     docker network ls
     
**Listado filtrado**

     docker network ls | grep bridge

"bridge" es la red por defecto de Docker. Para ver la configuración de esta red ponemos:

    docker network inspect bridge 
        
    [
        {
            "Name": "bridge",
            "Id": "dbc32079dcd7cc2cb61ab55e7719a954af5b13e8fed87f8c4765dc815e3793ca",
            "Created": "2019-03-29T09:29:56.985110985Z",
            "Scope": "local",
            "Driver": "bridge",
            "EnableIPv6": false,
            "IPAM": {
                "Driver": "default",
                "Options": null,
                "Config": [
                    {
                        "Subnet": "172.17.0.0/16",
                        "Gateway": "172.17.0.1"
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
            "Containers": {
                "0291e76cd46c0c3deb34055a963cdda3f3f3cbe79b9cfad19c147bdca7f47bb9": {
                    "Name": "test",
                    "EndpointID": "b484a89d0a3496ffc981abacb57a539a869045562633cf99ae98b1c477bd71d7",
                    "MacAddress": "02:42:ac:11:00:02",
                    "IPv4Address": "172.17.0.2/16",
                    "IPv6Address": ""
                }
            },
            "Options": {
                "com.docker.network.bridge.default_bridge": "true",
                "com.docker.network.bridge.enable_icc": "true",
                "com.docker.network.bridge.enable_ip_masquerade": "true",
                "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
                "com.docker.network.bridge.name": "docker0",
                "com.docker.network.driver.mtu": "1500"
            },
            "Labels": {}
        }
    ]


Vamos a crear otro contenedor

    docker run -dti --name test2 centos 

Si hacemos
    
    docker inspect test2
    
vemos que está en la red "bridge", y ha cogido otra ip

    "Networks": {
        "bridge": {
            "IPAMConfig": null,
            "Links": null,
            "Aliases": null,
            "NetworkID": "dbc32079dcd7cc2cb61ab55e7719a954af5b13e8fed87f8c4765dc815e3793ca",
            "EndpointID": "4344a19dc56c0d5ee80560febbb8474031aa05703e28019e2b02ca5912969e27",
            "Gateway": "172.17.0.1",
            "IPAddress": "172.17.0.3",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",


Si hacemos un ping desde test2 a test (cuya ip es 172.17.0.2)  

    docker exec test2 bash -c "ping 172.17.0.2"

Este es el resultado

    PING 172.17.0.2 (172.17.0.2) 56(84) bytes of data.
    64 bytes from 172.17.0.2: icmp_seq=1 ttl=64 time=0.082 ms
    64 bytes from 172.17.0.2: icmp_seq=2 ttl=64 time=0.057 ms
    ...
    
En la red por defecto los contenedores pueden vers por IP pero no por nombre
        


