Ejercicio propuesto
---------------

¡Hola!

La idea de este articulo es que le des solución al siguiente problema utilizando lo que has aprendido.

Deberás crear un dockre-compose para cada definición de contenedores de los ejercicios anteriores:

Puntos a tener en cuenta:

* Docker Compose V2

* La imagen (De apache y php) debe poder construirse desde el docker-compose

* Se deben definir los volúmenes solicitados en el ejericicio anterior, más las variables de entorno, límite y
demás requisitos especificados en los ejercicios anteriores.

---

Adicional a esto, te piden:

Crear un docker-compose v3 con dos servicios:

db y admin.

En el servicio DB, debe ir una db con mysql:5.7 y las credenciales de tu preferencia.

En el admin, debes usar la imagen oficial de phpmyadmin, y por medio de redes, comunicarla con mysql. Debes exponer el puerto de tu
 preferencia y para validar que funcione, debes loguearte en el UI de phpmyadmin vía navegador, usando las credenciales del root de mysql.

Que te diviertas!



