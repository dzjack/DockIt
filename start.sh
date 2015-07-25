#!/bin/sh
echo "Starting Development ENV"
docker rm nginx
./init_container.sh
docker start redis mysql rabbitmq gopull php-fpm nginx