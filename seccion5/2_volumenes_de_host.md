**MySQL**

Buscamos donde se guarda la información de MySQL en docker, https://hub.docker.com/_/mysql/
    
    /var/lib/mysql
    
Si salvamos ese directorio, tendremos todas las bd y la configuración

    docker run -d --name db -p 3306:3306 -e "MYSQL_ROOT_PASSWORD=12345" -v /opt/mysql/:/var/lib/mysql mysql:5.7
    
Todo lo que haya en "/var/lib/mysql" se va a mapear en nuestro pc en "/opt/mysql"


Entramos al contenedor con 

    mysql -u root -h 127.0.0.1 -p12345
 
Creamos bases de datos
   
    create database test1;
    create database test2;
    
Si vamos a "/opt/mysql" veremos las carpetas "test1" y "test2"

Si borramos el contenedor y volvemos a crearlo, veremos que las bases de datos siguen intactas.

Esta es la función de un volumen: persistir los datos aunque se elimine el contenedor.

    
    
