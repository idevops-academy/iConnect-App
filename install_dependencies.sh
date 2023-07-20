#!/bin/bash


# Function to check if a package is installed
is_package_installed() {
    if [ -x "$(command -v $1)" ]; then
        return 0 # Package is installed
    else
        return 1 # Package is not installed
    fi
}

# Update the system
sudo yum update -y

# Install Git if not installed
if ! is_package_installed git; then
    echo "Installing Git..."
    sudo yum install git -y
else
    echo "Git is already installed."
fi

# Install Node.js if not installed
if ! is_package_installed node; then
    echo "Installing Node.js..."
    curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo -E bash -
    sudo yum install -y nodejs
else
    echo "Node.js is already installed."
fi

# Install PM2 if not installed
if ! is_package_installed pm2; then
    echo "Installing PM2..."
    sudo npm install -g pm2
else
    echo "PM2 is already installed."
fi

# Install Nginx if not installed
if ! is_package_installed nginx; then
    echo "Installing Nginx..."
    sudo yum install nginx -y
else
    echo "Nginx is already installed."
fi

# Display installed versions
echo "Git version:"
git --version
echo "Node.js version:"
node --version
echo "Nginx version:"
nginx -v

#create directory for cloning the app
echo "Creating application directory with the unique commint hash...."
sudo mkdir -p /var/myapp/<commit-sha>
cd /var/myapp/<commit-sha>

#clone the application from github
echo "Cloning the source branch from the repo to the directory....."
sudo git clone -b <branchname> https://<username>:<password>@gitlab.com/shaik447/iConnect-App.git
cd iConnect-App/

echo "Installing node dependencies....."
sudo npm install --omit=dev

echo "Copying nginx config to /etc/nginx/conf.d directory"
sudo cp nginx/sysmon.conf /etc/nginx/conf.d/

echo "Deleting pm2 app and recreating ...."
sudo pm2 stop all
sleep 5
echo "this is current directory"

sudo pm2 start --name iconnect-<commit-sha> npm -- start

echo "restarting nginx..."
sudo systemctl restart nginx

# Wait for Nginx to start (optional, if needed)
sleep 5

# Perform a smoke test with curl
if curl -s http://localhost | grep -q "iConnect"; then
    echo "App installation successful."
    exit 0
else
    echo "App installation failed."
    exit 1
fi

