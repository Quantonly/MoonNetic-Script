#!/bin/sh

#Start SSH connection
sshpass -p "abc123!" ssh -o StrictHostKeyChecking=no admin05@$1 << EOF

#Create user
sudo -S useradd --shell /bin/false $3
abc123!
sudo passwd $3
$4
$4

#Structure
sudo mkdir /home/$2
sudo mkdir /home/$2/$2
sudo mkdir /home/$2/$2/public
sudo cp /home/index.html /home/$2/$2/public/index.html
sudo chown root:root /home/$2
sudo chmod 755 /home/$2
sudo chown -R $3:$3 /home/$2/$2
sudo chmod -R 777 /home/$2/$2
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
sudo echo "     CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/$2.moonnetic.com.com
sudo echo "</VirtualHost>" >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo a2ensite $2.moonnetic.com.conf
sudo systemctl restart apache2

#SFTP
sudo chmod 777 /etc/ssh/sshd_config
sudo echo "Match User $3" >> /etc/ssh/sshd_config
sudo echo "     ForceCommand internal-sftp" >> /etc/ssh/sshd_config
sudo echo "     PasswordAuthentication yes" >> /etc/ssh/sshd_config
sudo echo "     ChrootDirectory /home/$2" >> /etc/ssh/sshd_config
sudo echo "     PermitTunnel no" >> /etc/ssh/sshd_config
sudo echo "     AllowAgentForwarding no" >> /etc/ssh/sshd_config
sudo echo "     AllowTcpForwarding no" >> /etc/ssh/sshd_config
sudo echo "     X11Forwarding no" >> /etc/ssh/sshd_config
sudo systemctl restart ssh

#PhpMyAdmin
sudo mysql
CREATE USER '$5'@'%' IDENTIFIED WITH caching_sha2_password BY '$6';
GRANT USAGE ON *.* TO '$5'@'%';
ALTER USER '$5'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
CREATE DATABASE IF NOT EXISTS $5;
GRANT ALL PRIVILEGES ON $5.* TO '$5'@'%';
exit

#End SSH connection
EOF

