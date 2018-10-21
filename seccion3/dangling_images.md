**Dangling images**

Cuando hacemos un `docker images` en el listado nos puede aparecer imágenes como esta

    REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
    <none>               <none>              317f39fc8599        8 days ago          360MB

Sin nombre y sin tag, pero sí que tiene ID y demás

Son dangling images, huérfanas (sin referenciar).
Cada vez que cambiamos el Dockerfile y reconstruimos la misma imagen con docker build sin
especificar un tag, se creará una nueva imagen. 
Al tener las capas permisos de solo lectura, al modificar una capa en un Dockerfile, Docker
sabe que sus imágenes son solo lectura y no puede modificarlas. Entonces creará una imagen
totalmente nueva.
Si ya existe una imagen con el mismo nombre, le quita la referencia a la imagen anterior y 
se la pone a la nueva. (No puede modificar la capa en la imagen anterior).

**Cómo eliminarlas**

Primero, para filtrarlas en el listado: 
    
    docker images -f dangling=true
        
Con `-q` nos listaría solo los ID

    docker images -f dangling=true -q 
     
Se pueden eliminar una a una por su ID o todas con este comando

    docker images -f dangling=true -q | xargs docker rmi
    
Esto lanza un proceso `docker rmi` para cada ID de imagen dangling.     
        

