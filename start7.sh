#!/bin/sh
echo "Starting Development ENV - PHP7"
chown -R www-data:www-data /var/www
chmod +x /var/www/composer.phar

docker start -a php7-fpm

