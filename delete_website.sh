#!/bin/sh

#Start SSH connection
sshpass -p "abc123!" ssh -o StrictHostKeyChecking=no admin05@$1 -p 2222 << EOF

#Remove user
sudo -S deluser $3
abc123!
sudo deluser smbuser $3
sudo groupdel $3

#Remove structure
sudo rm -R /home/$2
sudo rm -R /var/www/$2

#Remove virtual Host
sudo rm /etc/apache2/sites-available/$2.moonnetic.com.conf
sudo a2dissite $2.moonnetic.com.conf
sudo systemctl restart apache2

#PhpMyAdmin
sudo mysql
DROP USER '$5'@'%';
DROP DATABASE $5;
exit

#End SSH connection
EOF