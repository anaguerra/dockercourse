#!/bin/bash

echo "Iniciando contenedor..."
echo "Inciado!" > /var/www/html/ini.html
apachectl -DFOREGROUND


git rm -r --cached .