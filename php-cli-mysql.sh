#!/bin/sh

# CHECK IF DOCKER IS INSTALLED
command -v docker >/dev/null 2>&1 || {
    echo "Docker not installed!!  Aborting!!" >&2;
    echo "Installation Documentation: https://docs.docker.com/engine/installation/" >&2;
}
docker -v

# Use this to manually run a script, which requires communication to either Redis or MySQL
# Usage: ./php-cli-mysql.sh script.php
echo "Running php-cli Docker with arguments $@"
docker run -it --rm --name php-cli \
-v "$PWD"/src/public:/usr/src/myapp \
-w /usr/src/myapp \
-p 5000:5000 \
--link redis:redis \
--link mysql:mysql \
--link elasticsearch:elasticsearch \
drpain/php-cli:latest php "$@"
