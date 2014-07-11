#!/bin/bash
# Arrancamos la base de datos
cd ~/
sudo ./mongodb/mongodb-linux-x86_64-2.6.2/bin/mongod --fork --logpath /var/log/mongodb.log

echo
echo "La web esta disponible en http://localhost:9292/"
echo "crtl + C para parar el servidor"
echo
# Arrancamos el servidor
cd ~/a_star/lib
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use 2.0.0
rackup

echo "Se detiene la base de datos"
sudo ./mongodb/mongodb-linux-x86_64-2.6.2/bin/mongod --shutdown