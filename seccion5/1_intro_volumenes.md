**Volúmenes**

Son una herramienta que nos permite almacenar datos de una manera persistente en el contenedor (inclusi
aunque se elimine).


3 tipos:

- Host: se almacenan en el docker host. Definimos su carpeta
- Anonymus: No definimos una carpeta pero docker automaticamente crea una random y persiste ahí la info.
- Named Volumes: Los creamos nosotros, que no son carpetas nuestras sino que están administradas por docker pero sí tienen un nombre

 
**¿Por qué son importantes¿**
 
**Volúmenes HOST**

Recuperamos un container de MySQL
                                                                                                 
    docker run -d -p 3306:3306 --name my-db -e "MYSQL_ROOT_PASSWORD=12345" -e "MYSQL_DATABASE=docker-db" -e "MYSQL_USER=docker-user" -e "MYSQL_PASSWORD=54321" mysql:5.7
    
Esto creará una bd con nombre "docker-db" y un usuario "docker-user". Para verlo

    mysql -u root -h 127.0.0.1 -p
     
    SHOW DATABASES,
    
Vamos a hacer un dump de una bd e importarlo a "docker-db":
    
    mysqldump -u root -h 127.0.0.1 -p12345 sys > dump.sql
    mysql -u root -h 127.0.0.1 -p docker-db < dump.sql
    
Entramos otra vez al server mysql, a la bd "docker-db"

    mysql -u root -h 127.0.0.1 -p docker-db
    
    SHOW TABLES
Veremos las tablas importadas.
    
Si ahora destruimos el contenedor "my-db"

    docker rm -fv my-db
    
y lo creamos de nuevo (con el anterior comando de "run"), la bd está vacía.
Aquí entran los volúmenes a rescatarnos. 


