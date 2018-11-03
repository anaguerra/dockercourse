Si pasamos un argumento adicional al crear el contenedor, p.e.

    docker run -dti centos echo hola mundo
    
Esto sobreescribirá el /bin/bash del CMD original
    
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS                NAMES
    246923d2a3cd        centos              "echo hola mundo"        10 seconds ago      Exited (0) 8 seconds ago                        affectionate_ardinghelli

El container muere después del echo.

Otro ejemplo: contenedor que sobreescribe el CMD

    docker run -d -p 8080:8080 centos python -m SimpleHTTPServer 8080
    
En este caso es `python -m SimpleHTTPServer 8080` (crea un mini webserver)

Al ejecutar esto, no va a morir

    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
    4c02e7b14578        centos              "python -m SimpleHTT…"   4 seconds ago       Up 3 seconds        0.0.0.0:8080->8080/tcp   wonderful_jang


En resumen, el CMD se sobreescribe pasando el nuevo al final del comando