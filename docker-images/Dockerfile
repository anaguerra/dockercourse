FROM centos

LABEL version=1.0
LABEL description="This is an apache image"

RUN yum install httpd -y

COPY startbootstrap-sb-admin-2 /var/www/html/

RUN echo "$(whoami)" > /var/www/html/user1.html

RUN useradd ricardo

USER ricardo

RUN echo "$(whoami)" > /tmp/user2.html

USER root

RUN cp /tmp/user2.html /var/www/html/user2.html

COPY run.sh /run.sh

CMD sh /run.sh


#LISTAR CONTENEDORES docker ps -a
#docker rm -fv NAME --> Eliminar contenedor NAME
#docker build -t apache .
#docker run -d -p 80:80 apache
