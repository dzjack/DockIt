#!/bin/sh
echo "Stopping Development ENV"
docker stop gopull nginx php7-fpm redis rabbitmq mysql elasticsearch
