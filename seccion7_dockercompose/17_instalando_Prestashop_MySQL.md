Instalar Prestashop y MySQL
---------------

El docker-compose.yml

version: '3'

    services:
      db:
        container_name: ps-mysql
        image: mysql:5.7
        volumes:
           - $PWD/data:/var/lib/mysql
        environment:
           MYSQL_ROOT_PASSWORD: 12345678
           MYSQL_DATABASE: ps
           MYSQL_USER: ps
           MYSQL_PASSWORD: ps
        ports:
          - "3306:3306"
        networks:
          - my_net
    
      ps:
        container_name: ps-web
        volumes:
          - "$PWD/html:/var/www/html"
        depends_on:
          - db
        image: prestashop/prestashop
        ports:
          - "80:80"
        environment:
          DB_SERVER: db
          DB_USER: ps
          DB_PASSWD: ps
          DB_NAME: ps
        networks:
          - my_net
    networks:
      my_net:


Vamos a explorar el servicio "db".

Mapeamos la carpeta de almacenamiento de MySQL ("var/lib/data") a una carpeta "data" dentro de
nuestra carpeta actual.


Con el servicio "ps" mapeamos "var/www/html" a una carpeta "html" en nuestra carpeta actual.
En DB_SERVER ponemos el nombre del servicio "db" que hemos definido anteriormente.
La imagen oficial de prestashop corre sobre la última versión de Apache y PHP.

Recordemos que con `docker-compose logs -f` podemos ver la actividad de los servicios.
 