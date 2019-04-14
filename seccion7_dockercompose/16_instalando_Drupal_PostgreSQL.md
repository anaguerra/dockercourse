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