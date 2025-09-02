#!/bin/bash
# Update packages
sudo yum update -y

# Install Apache
sudo yum install -y httpd

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Add a sample index.html
echo "<h1>Hello from EC2 Apache Web Server!</h1>" > /var/www/html/index.html
