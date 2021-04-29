#!/bin/bash

sudo apt-get update && sudo apt-get install apache2 -y
echo "Hello World" > index.html
sudo cp index.html /var/www/html