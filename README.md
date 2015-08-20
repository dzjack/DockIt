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

#### HOW To import a MySQL DB

After starting the server with ./start.sh you will have an empty database.
To import a Database you will need to have at least the mysql client installed.

A bit of googling will sort you out.

```shell
# For Ubuntu this is
sudo apt-get install mysql-client
```

Once you have the client installed and the mysql running you can import it with the following command.
Let's use a example sql file of database.sql

```shell
mysql -h 127.0.0.1 -u root -proot < database.sql
```

#### HOW To connect to the Redis Server

You can also install the Redis Server tools, and connect to it for anything. Like Monitor.

```shell
# Ubuntu Example
sudo apt-get install redis-tools
```

Connecting to and monitoring redis.

```shell
redis-cli MONITOR
```