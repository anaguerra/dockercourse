# Instalar Docker

Config file /lib/systemd/system/docker.service


# Ubuntu
---------

https://www.udemy.com/docker-de-principiante-a-experto/learn/v4/t/lecture/10435144?start=0

# Actualiza los repos

sudo apt-get update

# Instala utilidades

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

# Agregar el gpg 

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Agregar el repo

 sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Actualizar de nuevo

 sudo apt-get update

# Instalar docker

 sudo apt-get install docker-ce

# Iniciarlo con el sistema

sudo systemctl enable docker

# Agregar usuario al grupo docker 

whoami # Saber el nombre de tu usuario
sudo usermod -aG docker nombre_de_salida_en_whoami

# Salir de la sesión
exit

# Iniciar de nuevo con el usuario y probar 

docker run hello-world

