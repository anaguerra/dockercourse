**Destruir contenedores automáticamente**

    docker run --rm 
    
   
--rm significa que es temporal y que cuando se salga de la sesión debe destruirse.


**Cambiar el document root de docker**

    docker info | grep -i root
    
Con esto obtenemos el directorio de docker

    Root Dir: /var/lib/docker/aufs
    Docker Root Dir: /var/lib/docker

Cada vez que ejecutamos `docker images` el listado es el resultado de una consulta a 
/var/lib/docker. 
Si editamos el fichero `/lib/systemd/system/docker.service`, vamos a la línea que dice `ExecStart`

Ponemos 
    
    ExecStart=/usr/bin/dockerd --data-root /opt
    
Lee el cambio que acabamos de hacer 

    systemcl daemon-reload

Aplica el cambio que acabo de hacer

    systemctl restart docker

Si ahora hacemos `docker images` ahora está vacío, ya que cambiamos el document root, está leyendo
de /opt

**Listar último contenedor creado**

    docker ps -l
    
    


    
 

    

