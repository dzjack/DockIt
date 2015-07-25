#!/bin/sh
echo "Starting Development ENV"
docker rm nginx
docker start redis mysql rabbitmq gopull php-fpm nginx