#!/bin/sh
echo "Starting Development ENV"
docker start redis
docker start mysql
docker start php-fpm
docker start nginx