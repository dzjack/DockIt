#!/bin/bash
initialDir=`pwd`
imageDir="${initialDir}/images/php-fpm"

function createContainers {
    echo "CREATING CONTAINER MySQL (Mariabd)"
    docker run \
    -d \
    -e MYSQL_ROOT_PASSWORD=root \
    -p 3306:3306 \
    -i \
    --name mysql \
    mariadb
    echo

    echo "CREATING CONTAINER (Redis)"
    docker run \
    -d \
    -p 6379:6379 \
    -i \
    --name redis \
    redis
    echo

    echo "CREATING CONTAINER GOLANG (Gopull)"
    docker run \
    -d \
    -i \
    -t \
    -v $(pwd)/src/public:/usr/share/nginx/html \
    -w /usr/share/nginx/html/gopull \
    --link redis:redis \
    --name gopull \
    golang \
    /bin/bash -c "apt-get update && apt-get install -y imagemagick && go get menteslibres.net/gosexy/redis && bash"
    echo

    echo "CREATING CONTAINER (PHP)"
    docker run \
    -d \
    -p 9000:9000 \
    -i \
    -t \
    --name php-fpm \
    -v $(pwd)/src/public:/usr/share/nginx/html \
    -w /usr/share/nginx/html \
    --link redis:redis \
    --link mysql:mysql \
    drpain/php-custom:php7 \
    /bin/bash -c "./composer.phar update && php-fpm"
    echo

    echo "CREATING CONTAINER (NGINX)"
    echo "Vhosts directory: $(pwd)/images/nginx/vhosts"
    docker run \
    --rm \
    -p 80:80 \
    -p 443:443 \
    --name nginx \
    -v $(pwd)/config/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v $(pwd)/config/nginx/vhosts/:/etc/nginx/sites-enabled/:ro \
    --volumes-from php-fpm \
    --link php-fpm:php-fpm \
    nginx
}


# CHECK IF DOCKER IS INSTALLED
command -v docker >/dev/null 2>&1 || {
    echo "Docker not installed!!  Aborting!!" >&2;
    echo "Installation Documentation: https://docs.docker.com/engine/installation/" >&2;
}
docker -v

# Build Docker image
while true; do
    read -p "CREATE DOCKER PHP-FPM Image? [y/n]: " yn1
    case $yn1 in
        [Yy]* ) cd $imageDir; ./build.sh; break;;
        [Nn]* ) echo "No image created"; break;;
        * ) echo "Please answer yes [y] or no [n].";;
    esac
done

# CREATE THE DOCKER CONTAINERS
while true; do
    read -p "CREATE DOCKER CONTAINERS? [y/n]: " yn1
    case $yn1 in
        [Yy]* ) cd $initialDir; createContainers; break;;
        [Nn]* ) echo "No containers created"; break;;
        * ) echo "Please answer yes [y] or no [n].";;
    esac
done
