#!/bin/bash

# Prompt the user to enter values for the environment variables
read -p "Enter the WordPress DB user: " DB_USER
read -s -p "Enter the WordPress DB password: " DB_PASSWORD
read -s -p "Enter the MariaDB root password: " DB_ROOT_PASSWORD

read -p "Enter the FQDN (domain name): " FQDN


# Save the entered values to the .env file
cat <<EOL > .env
# WordPress
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
FQDN=$FQDN
DB_ROOT_PASSWORD=$DB_ROOT_PASSWORD
EOL

echo "The .env file has been created"
