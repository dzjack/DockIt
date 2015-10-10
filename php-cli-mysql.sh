#!/bin/sh
# Use this to manually run a script, which requires communication to either Redis or MySQL
# Usage: ./php-cli-mysql.sh script.php
echo "Running php-cli Docker with arguments $@"
docker run -it --rm --name php-cli \
-v "$PWD":/usr/src/myapp \
-w /usr/src/myapp \
--link redis:redis \
--link mysql:mysql \
--link graphite:graphite \
--link elasticsearch:elasticsearch \
drpain/php-cli:latest php "$@"