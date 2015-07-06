#!/bin/sh
echo "Stopping Development ENV"
docker stop redis
docker stop mysql
docker stop php-fpm
docker stop nginx