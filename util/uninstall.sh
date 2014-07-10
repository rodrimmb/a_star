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
sudo apt-get purge ruby2.0 ruby2.0-dev build-essential libssl-dev zlib1g-dev ruby-switch


# El siguiente codigo que esta comentado era para desinstalar rvm

#rvm remove 2.0.0

#echo
#echo "Desintalamos RVM"
#echo
#rm -rf ~/.rvm*
#sed '/Load RVM into a shell session/d' ~/.bash_profile>~/.bash_profile_final
#rm ~/.bash_profile
#mv ~/.bash_profile_final ~/.bash_profile
#sudo rm -rf /etc/rmv*
#sudo groupdel rvm

echo
echo "Desintalamos MongoDb"
echo
rm -rf ~/mongo
rm -rf /data

echo
echo "Desintalamos Curl"
echo
sudo apt-get --purge remove curl