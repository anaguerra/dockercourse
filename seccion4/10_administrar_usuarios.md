Cambiar el hostname y variables de entorno dentro de un contenedor

Dockerfile

    FROM centos
    
    ENV prueba 1234
    
    RUN useradd ricardo
    
    
    
Creamos la imagen
    
    docker build -t centos:prueba .
    

Levantamos contenedor 

    docker run -d -ti --name prueba centos:prueba
    
    
Por defecto, si entramos al contenedor con el comando por defecto, estaremos como root:

    docker exect -ti prueba bash
    

Pero si ejecutamos esto:

    docker exect -u ricardo -ti prueba bash

Entramos al contenedor con el usuario "ricardo". Otra opción es poner en el Dockerfile 
esta línea

    USER ricardo
    
    
    