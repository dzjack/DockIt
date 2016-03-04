#!/bin/sh
# CHECK IF DOCKER IS INSTALLED
command -v docker >/dev/null 2>&1 || {
    echo "Docker not installed!!  Aborting!!" >&2;
    echo "Installation Documentation: https://docs.docker.com/engine/installation/" >&2;
}
docker -v
echo "Stopping Development ENV"
docker stop gopull nginx php-fpm redis rabbitmq mysql
