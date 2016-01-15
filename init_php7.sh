#!/bin/bash
echo "Ensuring that www-data owns /var/www/"
chown -R 33:33 /var/www
chmod +x /var/www/composer.phar


echo "CREATING CONTAINER (PHP)"
docker run \
-d \
-p 9000:9000 \
-i \
-t \
--restart always \
--user www-data \
--name php7-fpm \
--net host \
-v /var/www:/var/www \
-w /var/www \
drpain/php-custom:php7 \
/bin/bash -c "./composer.phar update && php-fpm"
echo
