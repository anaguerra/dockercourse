Imagen oficial: https://hub.docker.com/_/mongo/

    docker pull mongo
    
Para correr la imagen

    docker run -d --name my-mongo -p 27017:27017  mongo
    
Para ver la RAM que consumen un contenedor

    docker stats my-mongo
    
    CONTAINER ID        NAME                CPU %               MEM USAGE / LIMIT    MEM %               NET I/O             BLOCK I/O           PIDS
    525679ef3d67        my-mongo            0.39%               40.3MiB / 7.697GiB   0.51%               7.1kB / 0B          16.4kB / 696kB      26

Se puede limitar la cantidad de RAM y CPU. Se verá en siguientes secciones.


Para conectarnos, necesitaremos un cliente de MongoDB
Para entrar al contenedor:

    docker exec -ti my-mongo bash
    
    