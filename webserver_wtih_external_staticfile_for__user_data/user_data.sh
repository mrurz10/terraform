#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
echo "<h2>this is my first terraform code </h2>" > /var/www/html/index.html
service httpd start
