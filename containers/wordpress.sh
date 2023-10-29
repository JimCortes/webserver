#!/bin/bash

echo "Welcome to WordPress assistant installation for Docker Compose"

read -p "Enter the folder path for your WordPress installation: " wordpress_folder

mkdir -p $wordpress_folder

# Create subdirectories for plugins, themes, and uploads
mkdir -p $wordpress_folder/plugins
mkdir -p $wordpress_folder/themes
mkdir -p $wordpress_folder/uploads

# Create wp-config.php file
touch $wordpress_folder/wp-config.php

./createenv.sh
./create-docker-compose.sh

cp docker-compose.yml $wordpress_folder
cp .env $wordpress_folder
cd $wordpress_folder