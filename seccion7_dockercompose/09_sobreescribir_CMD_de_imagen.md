Sobreescribir el CMD de una imagen 
---------------

Vamos a aprender a modificar el CMD de una imagen sin necesidad de crear un Dockerfile
para ello.

Vamos a crear un `docker-compose-cmd.yml`

    version: '3'
    services:
      web:
        image: centos
        command: python -m SimpleHTTPServer 8080
        ports:
          - "8080:8080"

Hemos puesto una línea de python que viene en linux por defecto para crear un webserver.
Antes de ejecutar esto, para ver el CMD original de centos creamos un contenedor con

    docker run -dti centos
    
y hacemos `docker ps`

    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
    2b0aa310c7d6        centos              "/bin/bash"         3 seconds ago       Up 1 second                             recursing_chebyshev

Vemos que el CMD es `"bin/bash"` y nuestro docker compose debería sobreescribirlo

Vamos a levantar nuestro servicio

    docker-compose -f docker-compose-cmd.yml up -d
    
Y con `docker ps`

    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
    17be143d632f        centos              "python -m SimpleHTT…"   6 seconds ago       Up 4 seconds        0.0.0.0:8080->8080/tcp   dockercompose_web_1
    
Se ha sobreescrito.
Para comprobarlo vamos a localhost:8080 y lo vemos funcionando.