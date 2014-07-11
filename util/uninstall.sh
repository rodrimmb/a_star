echo
echo "Borrar el codigo del proyecto"
echo
sudo rm -rf ~/a_star

echo
echo "Desinstalamos Graphviz"
echo
sudo apt-get purge graphviz

echo
echo "Desinstalamos Ruby"
echo
rvm remove 2.0.0

echo
echo "Desintalamos MongoDb"
echo
rm -rf ~/mongo
rm -rf /data

echo
echo "Desintalamos Curl"
echo
sudo apt-get --purge remove curl
