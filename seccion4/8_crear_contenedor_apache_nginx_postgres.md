Ya teníamos la imagen de nginx, así que:

    docker run -d -p 8888:80 nginx

Lo comprobamos en localhost:8888 
    
Para Apache

    docker run -d -p 9999:80 httpd
    
Comprobamos en localhost:9999
    

POSTGRESQL

    docker run -d --name postgres -e "POSTGRES_PASSWORD=12345" -e "POSTGRES_USER=docker" -e "POSTGRES_DB=docker-db" -p 5432:5432 postgres
    
    
Podemos ver todos los contenedores corriendo. 
     
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
    30d9d6d36edd        nginx               "nginx -g 'daemon of…"   20 seconds ago      Up 19 seconds       0.0.0.0:8888->80/tcp   brave_jones
    1c311b4f3ecf        httpd               "httpd-foreground"       11 minutes ago      Up 11 minutes       0.0.0.0:9999->80/tcp   apache
    046c9f982c73        postgres            "docker-entrypoint.s…"   7 minutes ago       Up 7 minutes        0.0.0.0:5432->5432/tcp   postgres

Para entrar al contenedor de postgres

    docker exec -ti postgres bash
    
Y una vez dentro accedemos a la bd que creamos "docker-db", con el usuario que definimos ("docker")

    psql -d docker-db -U docker
    
    




    