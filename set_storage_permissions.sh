#!/bin/sh

#Start SSH connection
sshpass -p "abc123!" ssh -o StrictHostKeyChecking=no admin05@$1 -p 2222 << EOF

sudo -S chmod -R 777 /home/$2/$2/storage
abc123!

#End SSH connection
EOF