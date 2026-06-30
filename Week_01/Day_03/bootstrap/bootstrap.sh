#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Avoid interactive prompts during installation
export DEBIAN_FRONTEND=noninteractive

echo "Updating repositories..."
apt-get update -yqq

echo "Installing packages..."
apt-get install -y nginx git curl

echo "Configuring Nginx..."
systemctl enable nginx
systemctl start nginx

echo "Copying web files..."
cp /vagrant/index.html /var/www/html/index.html
cp /vagrant/contact.html /var/www/html/contact.html
cp /vagrant/projects.html /var/www/html/projects.html
cp /vagrant/resume.html /var/www/html/resume.html 
cp -a /vagrant/css /var/www/html/
cp -a /vagrant/js /var/www/html/
cp -a /vagrant/assets /var/www/html/

echo "Setting up permissions..."
# Change ownership to www-data recursively
chown -R www-data:www-data /var/www/html/

# Apply 755 to directories and 644 to files
find /var/www/html/ -type d -exec chmod 755 {} +
find /var/www/html/ -type f -exec chmod 644 {} +

echo "Site provisioned successfully."