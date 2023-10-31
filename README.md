# webserver

### Requirements 
[Docker-compose](https://docs.docker.com/)

### Set up
Install [Caddy](https://caddyserver.com/docs/install#debian-ubuntu-raspbian) your server
```bash
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```

### Containers

Copy the repository
```bash
git clone git@github.com:JimCortes/webserver.git
```
Add the execute permission
```bash
chmod +x create-docker-compose.sh createenv.sh wordpress.sh
```
copy and pase on wp config
```
define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_TIMEOUT', 1);
define('WP_REDIS_READ_TIMEOUT', 1);
define('WP_REDIS_DATABASE', 0);
```

Create proxy Network
```docker network create proxy```

Create and start the services
```sudo docker-compose up```

Find the IP address of your WordPress container
```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' {container_name}
```

Update your caddyfile:
```/etc/caddy/Caddyfile```

```
domain.com {
        # Set this path to your site's directory.
        # root * /usr/share/caddy

        # Enable the static file server.
        #file_server

        # Another common task is to set up a reverse proxy:
        # reverse_proxy localhost:8080

        # Or serve a PHP site through php-fpm:
        # php_fastcgi localhost:9000
        reverse_proxy 000.00.0.0:80
}
```

Run caddy or reload

```
caddy run 
or 
caddy reload
```


### Requirements 
[Docker-compose](https://docs.docker.com/)

### Set up
Install [Caddy](https://caddyserver.com/docs/install#debian-ubuntu-raspbian) your server
```bash
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```

### Containers

Copy the repository
```bash
git clone git@github.com:JimCortes/webserver.git
```
Add the execute permission
```bash
chmod +x create-docker-compose.sh createenv.sh wordpress.sh
```
copy and pase on wp config
```
define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_TIMEOUT', 1);
define('WP_REDIS_READ_TIMEOUT', 1);
define('WP_REDIS_DATABASE', 0);
```

Create proxy Network
```docker network create proxy```

Create and start the services
```sudo docker-compose up```

Find the IP address of your WordPress container
```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' {container_name}
```

Update your caddyfile:
```/etc/caddy/Caddyfile```

```
domain.com {
        # Set this path to your site's directory.
        # root * /usr/share/caddy

        # Enable the static file server.
        #file_server

        # Another common task is to set up a reverse proxy:
        # reverse_proxy localhost:8080

        # Or serve a PHP site through php-fpm:
        # php_fastcgi localhost:9000
        reverse_proxy 000.00.0.0:80
}
```

Run caddy or reload

```
caddy run 
or 
caddy reload
```

_____
Note: in case of any error to upload files or themes: Check Directory Permissions within the Container

```
docker exec -it {container_name} /bin/bash
ls -l /var/www/html/wp-content/uploads

```

If necessary, change the ownership and permissions within the container using the chown and chmod commands:
```bash
chown -R www-data:www-data /var/www/html/wp-content/uploads
chmod -R 754 /var/www/html/wp-content/uploads
```
