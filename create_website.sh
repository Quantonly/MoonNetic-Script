#!/bin/sh
#Start SSH connection
sshpass -p abc123! ssh admin05@$1 << EOF

#Create user


#Structure
sudo -S mkdir /home/$2
abc123!
sudo mkdir /home/$2/$2
sudo mkdir /home/$2/$2/public
sudo cp /home/index.html /home/$2/$2/public/index.html
#sudo chown -R $3:$3 /home/$2/$2
#sudo chmod -R 777 /home/$2/$2
sudo ln -s /home/$2/$2 /var/www/$2

#Virtual Host
sudo touch /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo chmod 777 /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo "<VirtualHost *:80>" >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo "     ServerAdmin admin@$2.moonnetic.com" >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo "     ServerName $2.moonnetic.com" >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo "     ServerAlias www.$2.moonnetic.com" >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo "     DocumentRoot /var/www/$2/public" >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo "     ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo "     CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/$2.moonnetic.com.co>
sudo echo "</VirtualHost>" >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo a2ensite $2.moonnetic.com.conf
sudo systemctl restart apache2

#SFTP

#PhpMyAdmin

#End SSH connection
EOF

