Intro
---------------

Docker Compose es una herramienta que nos ayuda a crear aplicaciones multicontenedor

p.e. un sitio Wordpress que necesita un webserver con PHP y una base de datos

Crearíamos un contenedor para un webserver y otro para una bd y los conectaríamos por una 
red que definimos.

Se podría hacer a mano pero con docker compose definimos las imágenes, volúmenes, redes, etc...
en un fichero de texto. Normalmente es fichero de extensión `yml`.
Y luego haríamos `docker compose up ...`

 