Notas sobre redes
---------------

Quiero enfatizar en un par de cosas en este artículo:

Tomaremos como premisa que la IP de nuestro Docker Host es 192.168.100.2 

Al exponer un puerto en un contenedor, por defecto, este utiliza todas las interfaces de nuestra máquina. 
Veámos un ejemplo:

    [ricardo@localhost ~]$ docker run -d -p 8080:80 nginx
    196a13fe6198e1a3e8d55aedda90882f6abd80f4cdf41b2f29219a9632e5e3a1

    [ricardo@localhost ~]$ docker ps -l
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
    196a13fe6198        nginx               "nginx -g 'daemon of…"   5 seconds ago       Up 2 seconds        0.0.0.0:8080->80/tcp   frosty_jenning

Si observamos la parte de ports, veremos un 0.0.0.0 . Esto significa que podremos acceder al servicio en el 
puerto 8080  utilizando localhost:8080 , o 127.0.0.1:8080 , 192.168.100.2:8080 .

Si quisiéramos que sea accesible solamente vía localhost  y no vía 192.168.100.2 , entonces haríamos lo siguiente:

    [ricardo@localhost ~]$ docker run -d -p 127.0.0.1:8081:80 nginx
    1d7e82ff15da55b8c774baae56827aef12d59ab848a5f5fb7f883d1f6d1ee6e1

    [ricardo@localhost ~]$ docker ps -l
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
    1d7e82ff15da        nginx               "nginx -g 'daemon of…"   3 seconds ago       Up 1 second         127.0.0.1:8081->80/tcp   musing_tesla

Como observamos, ahora en vez de 0.0.0.0  vemos un 127.0.0.1 , lo que indica que nuestro servicio es 
accesible sólo vía localhost  y no usando 192.168.100.2 