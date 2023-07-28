#!/bin/bash

# Check if Nginx process is running using pgrep
if pgrep nginx > /dev/null; then
    echo "Nginx is running."

    echo "stopping all apps"
    sudo pm2 stop all

    # Stop Nginx
    echo "Stopping Nginx..."
    sudo systemctl stop nginx
    echo "Nginx has been stopped."
else
    echo "Nginx is not running."
fi
