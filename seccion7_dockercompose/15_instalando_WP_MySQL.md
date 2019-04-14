Instalar WP y MySQL
---------------

El docker-compose.yml
Tiene dos servicios en la misma red: "my_net"

    version: '3'
    
    services:
      db:
        container_name: wp-mysql
        image: mysql:5.7
        volumes:
           - $PWD/data:/var/lib/mysql
        environment:
           MYSQL_ROOT_PASSWORD: 12345678
           MYSQL_DATABASE: wordpress
           MYSQL_USER: wordpress
           MYSQL_PASSWORD: wordpress
        ports:
          - "3306:3306"
        networks:
          - my_net
    
      wp:
        container_name: wp-web
        volumes:
          - "$PWD/html:/var/www/html"
        depends_on:
          - db
        image: wordpress
        ports:
          - "80:80"
        environment:
          WORDPRESS_DB_HOST: db:3306
          WORDPRESS_DB_USER: wordpress
          WORDPRESS_DB_PASSWORD: wordpress
        networks:
          - my_net
    networks:
      my_net:

**redes**
Hay que incluir siempre los contenedores en la misma red para que se vean.

**depends-on**

Define dependencia entre servicios.  

    depends_on: 
       -db
       
En este caso le estamos diciendo que primero se creará el servicio "db" y luego "wp".
Puede ser también una lista de servicios.
    
Recordemos que si no existe "data" en el directorio actual, se crea.    
    
    $PWD/data:/var/lib/mysql
    

**imagen wordpress**

Ver https://hub.docker.com/_/wordpress/
Es una imagen basada en Apache. Es por eso que el directorio web es "var/www/html".

Necesita varias variables de entorno:

    WORDPRESS_DB_HOST 
    WORDPRESS_DB_USER
    WORDPRESS_DB_PASSWORD
    
Los valores que hemos pueso corresponden a los del servicio mysql
   
Como siempre, levantamos los contenedores con `docker-compose up -d`. La imagen de
wordpress se tiene que descargar porque no la teníamos.

Y con `docker-compose logs` -f siempre podemos ver cómo va el proceso.
Una vez ha acabado accedemos al navegador con "localhost" y acabamos la instalación.
Tenemos la administración del sitio en http://localhost/wp-admin/

Ahora si eliminamos nuestros servicios con `docker-compose down`

    Stopping wp-web   ... done
    Stopping wp-mysql ... done
    Removing wp-web   ... done
    Removing wp-mysql ... done
    Removing network wp_my_net

Pero como todo estaba guardado en data y html, si volvemos a levantar el servicio vamos
a tener todo al día ya que está todo en volúmenes.




 