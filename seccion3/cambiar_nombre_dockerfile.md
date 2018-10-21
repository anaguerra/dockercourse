Hemos construido imágenes hasta ahora con ficheros de nombre Dockerfile

Pero se puede construir a partir de otro nombre de fichero, p.e.: my-dockerfile. Para
ello se utiliza el flag `-t` y el nombre del fichero

    docker build -t test -f my-dockerfile .