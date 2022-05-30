#!/bin/sh

#Start SSH connection
sshpass -p "abc123!" ssh -o StrictHostKeyChecking=no admin05@$1 -p 2222 << EOF

#Create user
sudo -S useradd --shell /bin/false $3
abc123!
sudo passwd $3
$4
$4
sudo groupadd $3
sudo usermod -a -G $3 smbuser

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
sudo echo '<VirtualHost *:443>' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     ServerAdmin admin@$2.moonnetic.com' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     ServerName $2.moonnetic.com' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     ServerAlias www.$2.moonnetic.com' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     DocumentRoot /var/www/$2/public' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     ErrorLog \${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     CustomLog \${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     SSLEngine on' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     SSLCertificateFile /usr/certs/certificate.crt' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     SSLCertificateKeyFile /usr/certs/private.key' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '     SSLCertificateChainFile /usr/certs/ca_bundle.crt' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo echo '</VirtualHost>' >> /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo a2ensite $2.moonnetic.com.conf
sudo systemctl restart apache2

#SFTP
sudo chmod 777 /etc/ssh/sshd_config
sudo echo 'Match User $3' >> /etc/ssh/sshd_config
sudo echo '     ForceCommand internal-sftp' >> /etc/ssh/sshd_config
sudo echo '     PasswordAuthentication yes' >> /etc/ssh/sshd_config
sudo echo '     ChrootDirectory /home/$2' >> /etc/ssh/sshd_config
sudo echo '     PermitTunnel no' >> /etc/ssh/sshd_config
sudo echo '     AllowAgentForwarding no' >> /etc/ssh/sshd_config
sudo echo '     AllowTcpForwarding no' >> /etc/ssh/sshd_config
sudo echo '     X11Forwarding no' >> /etc/ssh/sshd_config
sudo systemctl restart ssh

#DNS
sudo curl -X POST "https://api.cloudflare.com/client/v4/zones/b022d30ac838cb03a5a605464a182606/dns_records" -H "X-Auth-Email: cody.volz@hotmail.com" -H "X-Auth-Key: 1ae81e993d1356aff16427b4eea78e0eec71f" -H "Content-Type: application/json" --data '{"type":"A","name":"$2","content":"172.26.5.10","ttl":1,"priority":10,"proxied":false}'

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