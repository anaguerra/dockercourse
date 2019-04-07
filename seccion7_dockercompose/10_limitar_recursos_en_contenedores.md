Limitar recursos en contenedores (Compose v2) 
---------------

Es similar a lo que se vio en la sección de Contenedores

    version: '3'
    services:
      web:
        container_name: nginx
        mem_limit: 20m
        cpuset: "0"
        image: nginx:alpine



mem_limit: cuánta memoria queremos
cpuset: cuántes cpu's queremos


Una vez levantado, con `docker stats` podemos ver los recursos que usa.