#!/bin/bash


# executing a script using commnads 
#chmod +x install.sh
#sudo ./install.sh


#adding repository universe

sudo add-apt-repository universe

#Update the repositories

sudo apt-get update

# video player vlc 

sudo apt-get install vlc

# setting open permissions on /var recursively 
sudo chmod -R ugo=rwx /var

#Apache, Php, MySQL and required packages installation

sudo apt-get -y install apache2 php7.0 libapache2-mod-php7.0 php7.0-mcrypt php7.0-curl php7.0-mysql php7.0-gd php7.0-cli php7.0-dev mysql-client
php7.0enmod mcrypt php7.0-cli php7.0-mbstring php7.0-xml


cd /var/www/html

sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php
sudo php -r "unlink('composer-setup.php');"

#The following commands set the MySQL root password to root?3 when you install the mysql-server package.

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root?3'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root?3'
sudo apt-get -y install mysql-server

#Restart all the installed services to verify that everything is installed properly

echo -e "\n"

service apache2 restart && service mysql restart > /dev/null

echo -e "\n"


# installing phpmyadmin

sudo apt-get install phpmyadmin
sudo cp  /etc/phpmyadmin/apache.conf /etc/apache2/conf-enabled/apache.conf
sudo apache2ctl restart

# setting open permissions on /var recursively  
sudo chmod -R ugo=rwx /var

php -v

if [ $? -ne 0 ]; then
   echo "Installation was not done succesfully, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
   echo "The installation process run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi

echo -e "\n"
