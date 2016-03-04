#!/bin/sh

# CHECK IF DOCKER IS INSTALLED
command -v docker >/dev/null 2>&1 || {
    echo "Docker not installed!!  Aborting!!" >&2;
    echo "Installation Documentation: https://docs.docker.com/engine/installation/" >&2;
}
docker -v

# Use this to manually run a script
# Usage: ./php-cli.sh script.php
echo "Running php-cli Docker with arguments $@"
docker run -it --rm --name php-cli \
-v "$PWD":/usr/src/myapp \
-w /usr/src/myapp \
php:5.6-cli php "$@"
