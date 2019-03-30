La red de Host
---------------

La red de nuestra máquina es host, la vemos en el listado

    docker network ls

Si hacemos

    ip a | grep wl
    
Veremos algo como

    3: wlp6s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
        inet 192.168.1.129/24 brd 192.168.1.255 scope global dynamic wlp6s0
        
Para crear un contenedor en esta red hacemos:

    docker run --network host -dti --name test2 centos
    
Ahora ingresamos en nuestro contenedor

    docker exec -ti test2 bash
    
y si hacemos en la consola del centos `hostname` vemos que heredó el nombre de la 
 propia máquina (`ana-Inspiron-3542`). Si vamos a la consola de nuestra máquina y tecleamos
 `hostname` nos debe dar el mismo resultado.    
 
Para poder acceder al comando `ip` instalamos dentro del contenedor lo necesario con:

    yum -y install net-tools
    
Si ahora hacemos `ifconfig` en nuestra máquina y en el contenedor, vemos que el contenedor
ha heredado todos los componentes de la red de la máquina, incluso la ip y el nombre de host.
    
Eso es una red de host.
    
Lo único que cambia es que dentro del contenedor, el usuario que se ejecuta es "root". Como
estamos usando la imagen base de centos aparece root. En la sección "administrar usuarios" ver
como crear y cambiar usuario en el contenedor.