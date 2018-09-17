FROM centos

RUN yum install httpd -y

COPY startbootstrap-sb-admin-2 /var/www/html

CMD apachectl -DFOREGROUND


#LISTAR CONTENEDORES docker ps -a
#docker rm -fv NAME --> Eliminar contenedor NAME
#docker build -t apache .
#docker run -d -p 80:80 apache
