Política reinicio de contenedores  
---------------

**Docker restart policy**

Son condiciones en las que un contenedor debería ser reiniciado o no.

Si creamos un contenedor con 

    docker run -dti centos
    
    docker ps
    
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
    f19beefbaf0d        centos              "/bin/bash"              3 seconds ago       Up 2 seconds                                 hungry_nobel

Si por alguna razón lo detengo:

    docker stop hungry_nobel
    
    hungry_nobel
    
se queda muerto y no va a revivir a menos que lo reiniciemos


**Reiniciar contenedor bajo ciertas circuntancias**

Se hace con el flag "restart".
En la documentación, https://docs.docker.com/config/containers/start-containers-automatically/
vemos que existen 4 opciones: no, on-failure, unless-stopped, always

El valor por defecto es "no".

Nuestro docker-compose.yml

    version: '3'
    services:
      test:
        container_name: test
        image: restart-image
        build: .
        

El Dockerfile

    FROM centos
    
    COPY start.sh /start.sh
    
    RUN chmod +x /start.sh
    
    CMD /start.sh
    
El start.sh

    #!/bin/bash
    echo "Estoy vivo"
    sleep 5
    echo "Estoy detenido"
    
Construimos imagen y levantamos contenedor

    docker-compose build
    docker-compose up -d
    
Nos crea un contenedor que va a morir a los 5 seg y que en el log va a decir "Estoy vivo" y
"Estoy detenido"  
    
    docker logs -f test
    
    ana@ana-Inspiron-3542:~/Documentos/dockercompose$ docker logs -f test
    Estoy vivo
    Estoy detenido

*always*
    
    restart: always
    
Cuando muere Docker lo reinicia. Hacemos `docker-compose up d` para recrear el servicio,
Y para ver que como lo reinicia hacemos

    watch -d docker ps


    Cada 2,0s: docker ps                                                                                                                                                                        Sun Apr  7 19:49:54 2019
   
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                          PORTS               NAMES
    a529d2eed432        restart-image       "/bin/sh -c /start.sh"   2 minutes ago       Restarting (0) 13 seconds ago                       test

*unless-stopped*

