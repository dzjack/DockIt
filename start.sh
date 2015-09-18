#!/bin/sh
echo "Starting Development ENV"
echo "Deleting Nginx Docker, discarding old logs"
docker rm nginx
cd ~/DockIt

echo "Starting Dockers, in order of inclusion"
docker start redis mysql rabbitmq gopull php-fpm graphite

echo "CREATING CONTAINER (NGINX)"
echo "Vhosts directory: $(pwd)/images/nginx/vhosts"
docker run \
-d \
--privileged=true \
-p 80:80 \
-p 443:443 \
--name nginx \
-v $(pwd)/config/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
-v $(pwd)/config/nginx/vhosts/:/etc/nginx/sites-enabled/:ro \
--volumes-from php-fpm \
--link php-fpm:php-fpm \
nginx
