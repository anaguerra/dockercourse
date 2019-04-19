Instalar Drupal y PostgreSQL
---------------

El docker-compose.yml

    version: '3'
    services:
      drupal:
        volumes:
          - drupal:/var/www/html
        image: drupal:8-apache
        ports:
          - 80:80
        networks:
          - net
      postgres:
        image: postgres:10
        environment:
          POSTGRES_PASSWORD: example
        volumes:
          - $PWD/data:/var/lib/postgresql/data
        networks:
          - net
    volumes:
      drupal:
    networks:
      net:

Aquí usamos volúmenes nombrados. 

    volumes:
      - drupal:/var/www/html

    volumes:
      drupal:
      
Como imagen de Drupal se ha cogido la que tiene el tag 8-apache. Ver en la documentación
todas las imágenes y tags que existen.

Para postgres usamos la versión 10. La imagen de postgres requiere una variable de entorno POSTGRES_PASSWORD. Ver documentación:    

https://hub.docker.com/_/postgres

Esta línea:

    $PWD/data:/var/lib/postgresql/data
    
Indica que el directorio por defecto donde Postgres almacena la data se va a mapear a un directorio
"data" dentro nuestro directorio actual. Si no existe lo creará.

Levantamos los servicios con `docker-compose up -d`

    Creating network "drupal_net" with the default driver
    Creating volume "drupal_drupal" with default driver
    Pulling drupal (drupal:8-apache)...
    Creating drupal_drupal_1   ... done
    Creating drupal_postgres_1 ... done

Si ahora vamos a "localhost" ya tenemos la página de instalación de Drupal.
Lo único que habría que tener en cuenta aquí es que el host de PostgreSQL se llama ahora "postgres",
que es el nombre que le dimos al servicio.

Una vez tengamos el sitio funcionando, vamos a comprobar la persistencia de datos: 
Hacemos 

    docker-compose down
    
    Stopping drupal_drupal_1   ... done
    Stopping drupal_postgres_1 ... done
    Removing drupal_drupal_1   ... done
    Removing drupal_postgres_1 ... done
    Removing network drupal_net
    
Comprobamos en localhost que se ha eliminado. Y vemos que nuestra carpeta "data" sigue ahí.

Levantamos nuevamente los servicios y el volumen "drupal" se vuelve a mapear automáticamente a la
carpeta "data".



