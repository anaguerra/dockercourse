**MONGODB**
 
Para bajar la imagen oficial de Mongo es...

    docker pull mongo

Para arrancar el contenedor:

    docker run -d --name my-mongo -p 27017:27017 -v /opt/mongo/:/data/db mongo
 
    
`/opt/mongo` es una carpeta de nuestro pc
`/data/db`  es la carpeta que contiene toda la información por defecto en MongoDB. Esto lo consultamos en su página oficial,
  https://hub.docker.com/_/mongo
 

Para entrar en el contenedor:

    docker exec -ti my-mongo bash
    
Dentro del contenedor escribimos "mongo" y veremos el servicio funcionando.

Para crear una bd en Mongo e insertar un registro:

    > use mydb
    > db.movie.insert({"name":"tutorials point"})

Para ver nuestra bd:

    > showd bs

Nos salimos

    > exit
    
Si eliminamos el contenedor (con `docker rm -fv $(docker ps -aq)`) y vamos a la carpeta `/opt/mongo` la 
 data sigue ahí.
 
Ahora podemos crear otro contenedor con esa data:

    docker run -d -p 27017:27017 --name mongo2 -v /opt/mongo:/data/db mongo

Entramos al nuevo contenedor

    docker exect -ti mongo2 bash
    
Entramos al servicio:
    
    mongo
    
    > show dbs
    
Y vemos nuestra base de datos "mydb"



**JENKINS**

    
    
El contenedor de Jenkins guarda la información en /var/jenkins_home (ver documentación Jenkins). Entonces para
crear el contenedor hacemos (previo `docker pull jenkins`):

    docker run -d --name jenkins -p 8080:8080 -v /opt/jenkins/:/var/jenkins_home jenkins
    
Vamos al navegador y tecleamos localhost:8080 y nos va a pedir la password de administrador.
Para mirar el archivo de la contraseña de administrador lo hacemos de esta manera, sin necesidad de entrar al contenedor:

    docker exec jenkins bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"

La ponemos en el navegador e instalamos Jenkins.

Una vez instalado, creamos un job sencillo. En el panel web nos tiene que aparece el proyecto.

Ahora eliminamos el contenedor con 
    
    docker rm -fv jenkins

Si miramos en `/home/ana/jenkins` veremos todos los ficheros persistidos. 

Podemos recrear otra vez el contenedor con esta data si ejecutamos el mismo comando anterior. 


Por el contrario, si lo creamos sin volumen no usará esta data persistida y se ejecutará como si fuera la
primera vez, nos pedirá contraseña etc...


**NGINX**

    docker run -d --name nginx nginx

Ingresamos a él con `docker exec -ti nginx bash` y vamos a la carpeta de logs

    cd /var/log/nginx
    
Eliminamos el contenedor que acabamos de crear: 

    docker rm -fv $(docker ps -aq)

Ahora lo volvemos a crear con un volumen en una carpeta del pc, mapenado:

    docker run -d --name nginx -p 80:80 -v /opt/nginx:/var/log/nginx nginx
    
Con esto le decimos que todo lo que está en /var/log/nginx se va a mapear a la carpeta
/opt/nginx, de forma que si el contenedor muere tenemos los logs.

Vamos al navegador y comprobamos que Nginx funciona. 
Y podemos ver los logs en /opt/nginx.

Hacemos `tailf /opt/nginx/error.log` y visualizamos en tiempo real los logs. 
Generamos un 404 y podemos verlo.

Eliminamos el contenedor y lo volvemos a crear. Si volvemos al error.log seguimos 
teniendo el error generado antes.


