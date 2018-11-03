Copiar archivos desde nuestra máquina al contenedor

Creamos un contenedor sencillo

    docker run  -d --name apache -p 80:80 httpd
    
Para pasarle un fichero index.html

    docker cp index.html apache:/tmp
 
Copiamos el fichero index.html al contenedor "apache" en la ruta "/tmp"


Para llevarlo al document root de Apache (y sobreescribir el del contenedor)

    docker cp index.html /usr/local/apache/htdocs/index.html


A la inversa. P.e. traer un log de Apache a nuestra máquina:

El fichero está en la ruta "/var/log/dpkg.log" dentro del contenedor

    docker cp apache:/var/log/dpkg.log .
    
Esto traerá el fichero a la ruta actual.  