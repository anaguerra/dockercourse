Imágenes en Compose
---------------

Docker Compose nos permite crear nuestas imágenes personalizadas con el comando `build`.

Nombre de nuestra imagen con `image`
`build`: Ruta del Dockerfile 

    version: '3'
    services:
      web:
        container_name: web
        image: web-test
        build: .
        
Si ponemos `.` en build, buscará un fichero Dockerfile en la ruta actual.

Nuestro fichero Dockerfile:

    FROM centos
    
    RUN mkdir /opt/test
        
Ahora construimos nuestra imagen `docker-compose up -d`

    Building web
    Step 1/2 : FROM centos
     ---> 5182e96772bf
    Step 2/2 : RUN mkdir /opt/test
     ---> Running in 8481a6572e91
    Removing intermediate container 8481a6572e91
     ---> 07a8880af0b8
    Successfully built 07a8880af0b8
    Successfully tagged web-test:latest
    WARNING: Image for service web was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
    Recreating mi-nginx ... done

Ahora la vemos en nuestra lista de imágenes 

    docker images
    
    REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
    web-test             latest              07a8880af0b8        9 minutes ago       200MB
    httpd                latest              d4a07e6ce470        4 days ago          132MB
    ...
    
**Dockerfile con diferente nombre**

    version: '3'
    services:
      web:
        container_name: web
        image: web-test
        build:
            context: .
            dockerfile: Dockerfile1
        

Construimos imagen:    
    
    docker-compose build
    
    
    Building web
    Step 1/2 : FROM centos
     ---> 5182e96772bf
    Step 2/2 : RUN mkdir /opt/test
     ---> Using cache
     ---> 07a8880af0b8
    Successfully built 07a8880af0b8
    Successfully tagged web-test:latest


 