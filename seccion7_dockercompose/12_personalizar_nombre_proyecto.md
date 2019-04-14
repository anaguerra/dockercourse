Personalizar nombre del proyecto  
---------------

Tomando de ejemplo este docker-compose.yml 

        version: '3'
        services:
          web:
            image: centos
            command: python -m SimpleHTTPServer 8080
            ports:
              - "8080:8080"
              
              
Cuando hacemos `docker-compose up -d`....

    Creating network "docker_default" with the default driver
    Creating docker_web_1 ... done
 
Docker va a crear un servicio con nombre "docker_default". Y una red por defecto ("_default").
 
El prefijo "docker" hace referencia a la carpeta actual. Si queremos cambiar el prefijo podemos hacer

    docker-compose -p webtest up -d
 
    Creating network "webtest_mi-red" with the default driver

 