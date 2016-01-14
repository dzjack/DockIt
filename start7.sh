#!/bin/sh
echo "Starting Development ENV - PHP7"
chmod +x /var/www/composer.phar
docker start -a php7-fpm

