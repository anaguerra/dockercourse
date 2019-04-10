Redes
---------------

Para crear una red normal escribimos

    docker network create mi_red
    
En Compose para crear una red hacemos (a la altura de `services`)

    networks:
        mi-red:

        
Cómo incluimos al contenedor en esta red? En la documentación oficial tenemos:

    services:
      some-service:
        networks:
         - some-network
         - other-network
    
Entonces nuestro docker-compose.yml quedaría así:

    version: '3'
    services:
        web:
            container_name: mi-nginx
            ports:
                - "8080:80"
            image: nginx
            networks:
                - mi-red
    networks:
        mi-red:
    
Creamos con `docker-compose up -d`

Y miramos en qué contenedor está la red con `docker inspect mi-nginx`

    ....
    "Networks": {
        "dockercompose_mi-red": {
            "IPAMConfig": null,
            "Links": null,
            "Aliases": [
                "web",
                "75846426e989"

El nombre que le pone es "dockercompose_mi-red" porque nuestra carpeta actual es "dockercompose"

Vamos a crear otro servicio en la misma red. Esta vez con contenedores Apache (que traen 
"ping", cosa que nginx no trae, para poder testear después). 
Nuestro docker-compose.yml sería entonces:

    version: '3'
    services:
      web:
        container_name: mi-nginx
        ports:
          - "8080:80"
        image: httpd
        networks:
          - mi-red
      web2:
        container_name: mi-nginx2
        ports:
          - "8081:80"
        image: httpd
        networks:
          - mi-red
    networks:
      mi-red:
    
Creamos contenedores y comprobamos que están corriendo:

    CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS                  NAMES
    483101d68aef        httpd               "httpd-foreground"   52 seconds ago      Up 50 seconds       0.0.0.0:8080->80/tcp   mi-nginx
    b4e77e7aff38        httpd               "httpd-foreground"   52 seconds ago      Up 51 seconds       0.0.0.0:8081->80/tcp   mi-nginx2

Podemos hacer ping de un contenedor a otro (ojo, previo hay que instalar ping en los contenedores nginx porque ya no
viene por defecto por lo visto. Con `apt-get` y `apt-get install iputils-ping`):

    docker exec -ti mi-nginx bash -c "ping mi-nginx2"
    
    PING mi-nginx2 (172.18.0.3) 56(84) bytes of data.
    64 bytes from mi-nginx2.dockercompose_mi-red (172.18.0.3): icmp_seq=1 ttl=64 time=0.056 ms
    64 bytes from mi-nginx2.dockercompose_mi-red (172.18.0.3): icmp_seq=1 ttl=64 time=0.056 ms
