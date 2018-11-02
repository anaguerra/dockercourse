Listar contenedores corriendo

    docker ps
    
Listar todos, incluso los detenidos

    docker ps -a
    
Cómo crear un contenedor.
Requisito: una imagen.
Usamos la oficial de Jenkins, https://hub.docker.com/_/jenkins/, con `docker pull jenkins`

Para ver las opciones de run

    docker run --help

Correr contenedor en segundo plano, `-d` 

    docker run -d jenkins

Tendremos un contendor con la imagen oficial de jenkins. 
Vamos a analizar la salida del `docker ps`

CONTAINER ID: secuencia alfanumérica
IMAGE: Imagen desde el que se creó
COMMAND: comando que ejecuta la img
PORTS: 80808/tcp...
NAMES:

No vemos nada al acceder a http://localhost porque no hemos mapeado los puertos en el "run"

** Mapeo de puertos **

    docker run -d -p 8080:8080 jenkins
    
El puerto 8080 de mi máquina se mapee al 8080 del contenedor

Ahora vemos en PORTS
 
    0.0.0.0:80890->8080/tcp
     
Todas las interfaces de nuestra máquina están siendo mapeadas al 8080 del contenedo.
También se puede usar un puerto no estándar.  

** Borrar contenedores **

    docker rm -f name1 name2....
    
    