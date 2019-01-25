**MONGODB**
 
    docker run -d -p 27017:27017 -v /opt/mongo/:/data/db
    
    
`/opt/mongo` es una carpeta de nuestro pc
`/data/db`  es la carpeta que contiene toda la información por defecto en MongoDB. Esto lo consultamos en su página oficial,
  https://hub.docker.com/_/mongo
 

Para ejecutar

    docker exec -ti 
