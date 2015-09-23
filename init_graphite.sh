#!/bin/bash

echo "CREATING CONTAINER (Graphite)"
echo "Cloning Into Graphite"
rm -rf docker-graphite-statsd
git clone https://github.com/hopsoft/docker-graphite-statsd.git
echo "Updating PORTS"
#sed -i "s/EXPOSE 80:80/EXPOSE 8888:80/" docker-graphite-statsd/Dockerfile
echo "Setting SAST Time"
sed -i '3i\RUN "date"\' docker-graphite-statsd/Dockerfile
sed -i '3i\RUN ln -s /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime' docker-graphite-statsd/Dockerfile
sed -i '3i\RUN rm /etc/localtime\' docker-graphite-statsd/Dockerfile
sed -i '3i\# Setting Timezone to SAST\' docker-graphite-statsd/Dockerfile
sed -i '3i\ \' docker-graphite-statsd/Dockerfile
echo "Building Graphite Image"
sudo docker build -t hopsoft/graphite-statsd ./docker-graphite-statsd
docker run \
-d \
--name graphite \
--restart=always \
#-p 8888:80 \
-p 80:80 \
-p 2003:2003 \
-p 8125:8125/udp \
hopsoft/graphite-statsd

