#!/bin/bash

# Update package list and upgrade packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install NGINX
sudo apt-get install nginx -y

# Enable NGINX to start at boot
sudo systemctl enable nginx

# Start NGINX service
sudo systemctl start nginx

# Check NGINX status
sudo systemctl status nginx

# Output completion message
echo "NGINX installation completed!"