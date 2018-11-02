Recomendación:

Si tuviéramos este error al entrar en el contenedor y escribir "mysql" (para acceder a la bd):

    bash: mysql: command not found
    
Esto se produce porque se necesita un cliente mysql

Simplemente hay que instalar un paquete para ello. Si usamos Centos, el comando sería

    yum install mysql -y
    
Ingresamos en el contenedor de centos

    docker run --rm -ti centos bash
    
Y instalamos el paquete con el comando anterior.
En el caso de ubuntu sería:

    apt-get install mysql-client -y