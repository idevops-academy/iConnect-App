#!/bin/bash

# Update the system
sudo yum update -y

# Install Git
sudo yum install git -y

# Install Node.js
curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo -E bash -
sudo yum install -y nodejs
sudo npm install -g pm2


# Install Nginx
sudo yum install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Display installed versions
echo "Git version:"
git --version
echo "Node.js version:"
node --version
echo "Nginx version:"
nginx -v

#create directory for cloning the app
sudo mkdir -p /var/myapp/<commit-sha>
cd /var/myapp/<commit-sha>

#clone the application from github
sudo git clone -b <branchname> https://<username>:<password>@gitlab.com/shaik447/iConnect-App.git
cd iConnect-App/

npm install --omit=dev
