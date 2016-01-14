#!/bin/bash

echo "CREATING CONTAINER (PHP)"
docker run \
-d \
-p 9000:9000 \
-i \
-t \
--restart always \
--name php7-fpm \
--net host \
-v /var/www:/var/www \
-w /var/www \
drpain/php-custom:php7 \
/bin/bash -c "/var/www/composer.phar update && php-fpm"
echo
