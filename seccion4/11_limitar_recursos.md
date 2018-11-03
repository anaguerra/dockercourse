Vamos a usar la imagen de mongo

    docker run -d --name mongo mongo
    
Con 
    
    docker stats mongo
    
vemos los recursos que usa.

    CONTAINER ID        NAME                CPU %               MEM USAGE / LIMIT    MEM %               NET I/O             BLOCK I/O           PIDS
    db3205043815        mongo               0.41%               40.7MiB / 7.697GiB   0.52%               11.9kB / 0B         105MB / 705kB       26

Vemos que usa 40.7MB sobre un límite de casi 8GB, que es la RAM del ordenador
porque por defecto docker usa todos los recursos libres

Podemos limitar el uso de RAM y CPU

**RAM**

-m equivale a --memory

    docker run -d -m "500mb" --name mongo2 mongo

**CPU**

Comando para ver cuantas CPUs hay en nuestra máquina:

    grep "model name" /proc/cpuinfo | wc -l
    
En mi caso 4. Por defecto docker le asigna las 4 al contenedor.

    docker run -d --cpuset-cpus 0-1 --name mongo3 mongo
    
Con esto solo se asignarían esas dos cpu al contenedor.
Con el comando stats no se podrá ver el uso de las cpus, pero sí el porcentaje.


 