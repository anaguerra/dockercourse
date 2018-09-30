
Imagen
--------

Es un paquete que contiene todo lo necesario para que corra el servicio/aplicación: 
paquetes, configuraciones....

Las img se componen de capas, pueden tener n.

Capa 1 - FROM
Especifica con qué s.o. voy a utilizar (Ubuntu, Debian, Centos...)
La img contiene un mini sistema operativo

Capa 2 - RUN
Qué va a haber luego del sistema operativo. P.e. Apache
P.e.: Si estamos en Centos, cómo instalamos Apache. 
    
    yum install httpd

Capa 3 - CMD
Comando que inicie el servicio de la capa 2. 
P.e. Para Centos sería: "httpd" (o apache) 


Estas capas son de solo lectura. Se pueden añadir más capas encimas de la existentes 
o crear una imagen nueva. 


**Dockerfile**

Las imágenes se crean con un fichero Dockerfile, con las capas.

Ejemplo

    FROM centos:7
    RUN yum - y install httpd
    CMD ["apachectl", "-DFOREGROUND]
    
Es importante que la línea del CMD ejecute un servicio en primer plano.

https://docs.docker.com/engine/reference/builder/#cmd


Contenedor
-------------

Imagen: paquete con lo necesiario para correr la aplicación. Con capas

Contenedor: Es una capa adicional que trae una ejecución en tiempo real de las 3 capas 
anteriores.

La capa 4 es de escritura, ejecución. Los cambios en la capa 4 son temporales, se pierden al 
apagar el contenedor.

Para tener datos persistentes en el contenedor, aun cuando eliminemos la capa 4, se usan volúmenes.

Dentro del contenedor también hay redes, para comunicar contenedores entre sí.





 


