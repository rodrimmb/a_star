#!/bin/bash
# Arrancamos la base de datos
cd ~/
sudo ./mongodb/mongodb-linux-x86_64-2.6.2/bin/mongod --fork --logpath /var/log/mongodb.log


echo "La web esta disponible en http://localhost:9292/"
echo "crtl + C para parar el servidor"
# Arrancamos el servidor
cd ~/a_star/lib
rackup