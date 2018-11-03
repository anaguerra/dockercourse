Ya teníamos la imagen. Si no:

    docker pull jenkins
    
Levantamos el contenedor en el puerto 7070

    docker run -d -p 7070:8080 --name jenkins jenkins
    
Y para verlo, vamos a localhost:7070

Se desbloquea con el contenido de 

    /var/jenkins_home/secrets/initialAdminPassword
    
Entramos al contenedor
    
    docker exec -ti jenkins bash
    
Hacemos 

    cat /var/jenkins_home/secrets/initialAdminPassword
    
y recuperamos la contraseña.
    
 
    