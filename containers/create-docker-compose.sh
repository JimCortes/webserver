# Set your desired container names

read -p "Enter container name: " WORDPRESS_CONTAINER_NAME
source .env
# Save the entered values to the .env file
cat <<EOL >> .env

DB_NAME=${WORDPRESS_CONTAINER_NAME}_DB

EOL

echo "DB name loaded"

cat <<EOL > docker-compose.yml
version: "3.7"

services:
  wordpress:
    image: wordpress
    container_name: ${WORDPRESS_CONTAINER_NAME}
    restart: always
    init: true
    depends_on:
      - mariadb
      - redis
    environment:
      WORDPRESS_DB_HOST: mariadb
      WORDPRESS_DB_USER: \${DB_USER}
      WORDPRESS_DB_PASSWORD: \${DB_PASSWORD}
      WORDPRESS_DB_NAME: \${DB_NAME}
    volumes:
      - ${WORDPRESS_CONTAINER_NAME}:/var/www/html
      - ./plugins:/var/www/html/wp-content/plugins
      - ./themes:/var/www/html/wp-content/themes
      - ./uploads:/var/www/html/wp-content/uploads
      - ./wp-config.php:/var/www/html/wp-config.php
    networks:
      - proxy 
      - internal
    labels:
      - caddy="\${FQDN}"
      - caddy.reverse_proxy="{{upstreams 80}}"
  
  mariadb:
    image: mariadb
    container_name: ${WORDPRESS_CONTAINER_NAME}_mariadb
    restart: always
    init: true
    environment:
      MYSQL_DATABASE: \${DB_NAME}
      MYSQL_USER: \${DB_USER}
      MYSQL_PASSWORD: \${DB_PASSWORD}
      MARIADB_ROOT_PASSWORD: \${DB_ROOT_PASSWORD}
    volumes:
      - ${WORDPRESS_CONTAINER_NAME}_mariadb:/var/lib/mysql
    networks:
      - internal

  redis:
    image: redis
    container_name: ${WORDPRESS_CONTAINER_NAME}_redis
    restart: always
    init: true
    depends_on:
      - mariadb
    volumes:
      - ${WORDPRESS_CONTAINER_NAME}_redis:/data
    networks:
      - internal

volumes:
  ${WORDPRESS_CONTAINER_NAME}: {}
  ${WORDPRESS_CONTAINER_NAME}_mariadb: {}
  ${WORDPRESS_CONTAINER_NAME}_redis: {}

networks:
  internal:
  proxy:
    external: true


 

EOL
echo "Docker Compose file docker-compose.yml has been generated"
