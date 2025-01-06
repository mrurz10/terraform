#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
echo "<h2> zero-downtime webserver with EIP </h2>" > /var/www/html/index.html
sudo systemctl start httpd 
sudo systemctl enable http