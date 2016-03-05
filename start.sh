#!/bin/sh
# CHECK IF DOCKER IS INSTALLED
command -v docker >/dev/null 2>&1 || {
    echo "Docker not installed!!  Aborting!!" >&2;
    echo "Installation Documentation: https://docs.docker.com/engine/installation/" >&2;
}
docker -v

echo "Starting Development ENV - PHP7"
echo "Deleting Nginx Docker, discarding old logs"
docker rm nginx
cd ~/DockIt

echo "Starting Dockers, in order of inclusion"
docker start redis mysql gopull php-fpm

echo "CREATING CONTAINER (NGINX)"
echo "Vhosts directory: $(pwd)/images/nginx/vhosts"
docker run \
--rm \
-p 80:80 \
-p 443:443 \
--name nginx \
-v $(pwd)/config/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
-v $(pwd)/config/nginx/vhosts/:/etc/nginx/sites-enabled/:ro \
--volumes-from php-fpm \
--link php-fpm:php-fpm \
nginx
