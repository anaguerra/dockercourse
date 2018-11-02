Renombrar

    docker rename old_name new_name
    
Detener contenedor (sin eliminarlo)

    docker stop ID
    docker stop name
    
Iniciar 

    docker start ID
    docker start name
    
Reiniciar

    docker restart ID   
    docker restart name
    
Cómo podemos "entrar" al contenedor.
Para crear una img se necesita un sistema operativo. Por tanto tenemos una shell.

    docker exec -ti name bash
    docker exec -ti jenkins bash
Así se entra con el user por defecto, en este caso "jenkins"

Ingresar como root
   
    docker exec -u root -ti jenkins bash
   
¿Para qué sirve entrar con un usuari concreto? P.e. en el caso de Jenkins, en la página
de inicio pone que para desbloquear Jenkins hay que ir al fichero y copiar su contenido y 
pegarlo en la página de arranque.

    /var/jenkins_home/secrets/initialAdminPassword
    
Entonces, entramos al contenedor y editamos el contenido de ese fichero y se pega en el input del navegador.
Si tratamos de acceder desde fuera del contenedor, el fichero no existe.
La imagen de jenkins corre sobre Debian

** Eliminar todos los contenedores que están corriendo**

    docker ps -q | xargs docker rm -f

"-q" muestra los ID de las imágenes


   