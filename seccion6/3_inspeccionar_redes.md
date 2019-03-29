Inspeccionar redes
---------------

Con inspect vemos lo que hay en la red
 
     docker network inspect docker-test-network
     
     [
         {
             "Name": "docker-test-network",
             "Id": "6eae3b074699ce562d25d59f2070ed6af0b52fd80f19ced0ca023e27d96a518c",
             "Created": "2019-03-29T11:03:52.616773826Z",
             "Scope": "local",
             "Driver": "bridge",
             "EnableIPv6": false,
             "IPAM": {
                 "Driver": "default",
                 "Options": {},
                 "Config": [
                     {
                         "Subnet": "172.124.10.0/24",
                         "Gateway": "172.124.10.1"
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
