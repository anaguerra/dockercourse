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


**always**
    
    restart: always
    
Cuando muere Docker lo reinicia automáticamente. Hacemos `docker-compose up d` para recrear el servicio, y para ver 
como lo reinicia nos ayudamos del comando `watch`:

    watch -d docker ps

    Cada 2,0s: docker ps                                                                                                                                                                        Sun Apr  7 19:49:54 2019
   
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                          PORTS               NAMES
    a529d2eed432        restart-image       "/bin/sh -c /start.sh"   2 minutes ago       Restarting (0) 13 seconds ago                       test

Y si miramos los logs habrán muchos mensajes:

    ana@ana-Inspiron-3542:~/Documentos/dockercompose$ docker logs -f test
    Estoy vivo
    Estoy detenido
    Estoy vivo
    Estoy detenido
    Estoy vivo
    Estoy detenido
    ...
    
    
**unless-stopped**

A menos que hayamos detenido el contenedor, se va a seguir reiniciando. En principio funciona igual que always, a menos
que lo detengamos manualmente con:

    docker stop test
    
     
**on-failure**
 
El contenedor muere por error interno, entonces se reinicia.
Vamos a provocar un error interno para verlo. Añadimos esta línea al fichero sh, para que Docker interprete que hubo un error.

    exit 1
    
Recreamos la imagen y levantamos contenedor  
    
    docker-compose build
    docker-compose up -d 
    
Con `watch -d docker ps` vemos lo que está ocurriendo. La columna STATUS va cambiando ...
 
    Up Less than a second
    Restarting(1)...
    Up 2 seconds...
    




        

