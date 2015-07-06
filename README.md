# DockIt
#### Just my Docker Development environment scripts.

This helps me get my Development environment up and running in a matter of minutes. <3 Docker. It is really helping me get everything setup, and easily repeatable.

#### Get all the base images we will be extending
```
# Pull all the required images to extend from
docker pull debian:jessie
docker pull nginx
docker pull php:5.6-fpm
docker pull redis
docker pull mariadb
```

#### Custom PHP image
```
# Create custom PHP image
cd images/php-fpm/
docker build -t drpain/php-custom .
```
#### Create the containers in the order of dependencies
```
# Create the containers in the order of dependencies
cd ../../
./init_container.sh
```

#### Starting Docker 
```
./start.sh
```

#### Stopping Docker
```
./stop.sh
```
