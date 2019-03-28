Ejercicio
---------

En donde trabajas, solicitan los siguientes contendores con las siguientes características:

- Un contenedor con la imagen de Apache + php creada en la anterior solicitud con:

  * 50Mb límites de RAM

  * Solo podrá acceder a la CPU 0

  * Debe tener dos variables de entorno:

      * ENV = dev

      * VIRTUALIZATION = docker

  * El webserver debe ser accesible vía puerto 5555 en el navegador

  * En /opt/source1 (Debes crear el directorio en tu máquina local) debe persistir el código 
  que se incluya en el webserver. En este caso, para pruebas, utilizarás un phpinfo que debe sobrevivir 
  a la eliminación del contenedor.
  
  
  
Solución
---------

    docker run -d --name ejercicio -e ENV='dev' -e VIRTUALIZATION='docker' -v /opt/apache/source:/var/www/html -p 5555:80 apache:php
    
apache:php es la imagen que creamos en la sección 3, la cual creaba un fichero "hola.php" con un phpinfo dentro.

Comprobamos que está corriendo bien entrando a http://localhost:5555/hola.php.

Para entrar al contenedor 

    docker exec -ti ejercicio bash         



