Buenas prácticas
====================

- El servicio debe ser efímero. Se debe poder destruir con gran facilidad.

- Un solo servicio por imagen/contenedor

- Archivos pesados que no queremos que stén en el contexto de docker, agregarlos al .dockerignore

- Pocas capas. Imágenes pequeñas con pocas capas.

- Separar líneas con "\"

- Varios argumentos en una sola capa

- No instalar paquetes innecesarios (sólo el servicio)

- Usar labesl para agregar metadata a la imagen

Veamos un ejemplo por cada uno 



p.e.

- Efímero: p.e. si necesitamos Apache y MySQL, crear una imagen por cada uno.




