FROM php:7-fpm

# Copy the dev php.ini
COPY config/php.ini /usr/local/etc/php/

# Copy custom scripts in
COPY bin/docker-php-pecl-install /usr/local/bin/

# Enable Reporting
RUN echo ";\n">>/usr/local/etc/php-fpm.conf
RUN echo "php_value[session.save_handler] = redis">>/usr/local/etc/php-fpm.conf
RUN echo "php_value[session.save_path] = 'tcp://redis:6379/'">>/usr/local/etc/php-fpm.conf

# Setting SAST Time
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
RUN "date"

# Install modules TODO
RUN apt-get update && apt-get install -y \
libfreetype6-dev \
libjpeg62-turbo-dev \
libmcrypt-dev \
libpng12-dev \
imagemagick

RUN docker-php-ext-install mysqli iconv exif pdo pdo_mysql opcache bcmath mbstring zip
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

RUN usermod -u 33 www-data

# Use composer to install dependencies
RUN mkdir -p /usr/share/nginx/html
WORKDIR "/usr/share/nginx/html"
RUN curl -sS https://getcomposer.org/installer|php

# Install Git for Composer
RUN apt-get install -y git

EXPOSE 9000

#Get Redis
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz \
&& tar xfz /tmp/redis.tar.gz \
&& rm -r /tmp/redis.tar.gz \
&& mv phpredis-2.2.7 /usr/src/php/ext/redis

# Install Redis
RUN apt-get install -y git
RUN git clone -b php7 https://github.com/phpredis/phpredis.git
RUN mv phpredis /usr/src/php/ext/
RUN ls /usr/src/php/ext
RUN cd /usr/src/php/ext && docker-php-ext-install phpredis

CMD ["php-fpm"]
