Instalar Reaction ecommerce, NodeJS y MongoDB
---------------

Reaction es una ecommerce, tipo Prestashop, pero en Node.

El docker-compose.yml

    version: '3'

    services:
      reaction:
        image: reactioncommerce/reaction
        networks:
          - net
        depends_on:
          - mongo
        ports:
          - "3000:3000"
        environment:
          ROOT_URL: "http://localhost"
          MONGO_URL: "mongodb://mongo:27017/reaction"
    
      mongo:
        image: mongo
        volumes:
          - $PWD/data:/data/db
        networks:
          - net
    
    networks:
      net:


La imagen de "reaction" tiene dos variables de entorno, ROOT_URL y MONGO_URL.

Recordemos que docker-compose arma los nombres con respecto al directorio actual, así que poniendo
el nombre "net" en la red, tendremos... "react_net".

Persistimos la data de Mongo a nuestra carpeta local.

Levantamos los servicios con `docker-compose up -d`

    Creating network "react_net" with the default driver
    Pulling reaction (reactioncommerce/reaction:)...
    latest: Pulling from reactioncommerce/reaction
    5bba3ecb4cd6: Pull complete
    196b8e3c919d: Pull complete
    7d083412657b: Pull complete
    36b71377f6d7: Pull complete
    5dd053e625b2: Pull complete
    4f85b8fb4727: Pull complete
    Digest: sha256:44a38d9ea643e3d779b90359f269a90676bfbcccc22824a5ca4c54962edf0313
    Status: Downloaded newer image for reactioncommerce/reaction:latest
    Creating react_mongo_1 ... done
    Creating react_reaction_1 ... done
    
Tenemos que ir a los logs para ver el login que nos da Reaction en la aplicación:

    docker-compose logs -f
    
    reaction_1  | 10:24:44.298Z  WARN Reaction: Skipped loading settings from reaction.json.
    reaction_1  | 10:24:46.034Z  WARN Reaction:
    reaction_1  |   
    reaction_1  |    *********************************
    reaction_1  |           
    reaction_1  |     IMPORTANT! DEFAULT ADMIN INFO
    reaction_1  |           
    reaction_1  |     EMAIL/LOGIN: admin@localhost
    reaction_1  |           
    reaction_1  |     PASSWORD: r3@cti0n
    reaction_1  |           
    reaction_1  |    ********************************* 
    
    
Así que vamos a localhost:3000

Nos logueamos y ya tenemos acceso al panel de administración.




    

