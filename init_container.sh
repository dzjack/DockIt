#!/bin/bash

echo "CREATING CONTAINER MySQL (Mariabd)"
docker run \
-d \
-e MYSQL_ROOT_PASSWORD=root \
-p 3306:3306 \
-i \
--name mysql \
mariadb

echo "CREATING CONTAINER RabbitMQ"
docker run \
-d \
-e RABBITMQ_NODENAME=rabbitmq \
--name rabbitmq \
rabbitmq:3


echo "CREATING CONTAINER (Redis)"
docker run \
-d \
-p 6379:6379 \
-i \
--name redis \
redis

echo "CREATING CONTAINER GOLANG (Gopull)"
docker run \
-d \
-i \
-t \
-v $(pwd)/src/public:/usr/share/nginx/html \
--link rabbitmq:rabbitmq \
-w /usr/share/nginx/html/gopull \
--name gopull \
golang \
/bin/bash -c "apt-get update&& apt-get install -y imagemagick && go get github.com/streadway/amqp && go run start.go -uri=\"amqp://guest:guest@rabbitmq:5672/\""

echo "CREATING CONTAINER (PHP)"
docker run \
-d \
-p 9000:9000 \
-i \
-t \
--name php-fpm \
-v $(pwd)/src/public:/usr/share/nginx/html \
--link rabbitmq:rabbitmq \
-w /usr/share/nginx/html \
--link redis:redis \
--link mysql:mysql \
drpain/php-custom \
/bin/bash -c "./composer.phar update && php-fpm"

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
