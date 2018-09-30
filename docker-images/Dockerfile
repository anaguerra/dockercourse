#Creando una imagen con todos los argumentos vistos hasta ahora

#imagen oficial. En general tienen com ventaja que son muy livianas
#ventajas de las personalizadas, que puedes agregar más cosas
FROM nginx

RUN useradd ana

# document root por default de la imagen de nginx
# ver  https://hub.docker.com/_/nginx/
COPY fruit /usr/share/nginx/html

ENV archivo docker

WORKDIR /usr/share/nginx/html

# enviamos el valor de la variable al archivo env.html
RUN echo "$archivo" > /usr/share/nginx/html/env.html
EXPOSE 90

LABEL version=1

USER ana

RUN echo "Yo soy $(whoami)" > /tmp/yo.html

USER root

RUN cp /tmp/yo.html /usr/share/nginx/html/docker.html

# persitir logs
VOLUME /var/log/nginx

# si se deja en blanco toma el CMD de la imagen de nginx
# se puede ver este cmd con el comando "docker histori -H nginx --no-trunc
# --> /bin/sh -c #(nop)  CMD ["nginx" "-g" "daemon off;"
CMD nginx -g 'daemon off;'