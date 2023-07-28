#!/bin/bash

cd /var/myapp
echo "Copying nginx config to /etc/nginx/conf.d directory"
sudo cp nginx/sysmon.conf /etc/nginx/conf.d/

echo "start nodejs application as a process using PM2"
sudo pm2 start --name iconnect npm -- start

echo "restarting nginx..."
sudo systemctl restart nginx