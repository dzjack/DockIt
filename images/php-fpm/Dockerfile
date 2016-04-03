FROM php:7-fpm

# Copy the dev php.ini
COPY config/php.ini /usr/local/etc/php/

# Copy custom scripts in
COPY bin/docker-php-pecl-install /usr/local/bin/

# Enable Reporting
RUN echo ";\n">>/usr/local/etc/php-fpm.conf
RUN echo ";Enabling Error Logging\n">>/usr/local/etc/php-fpm.conf
RUN echo "php_flag[display_errors] = On">>/usr/local/etc/php-fpm.conf
RUN echo "php_admin_flag[log_errors] = On">>/usr/local/etc/php-fpm.conf
RUN echo "php_admin_value[display_errors] = 'stderr'">>/usr/local/etc/php-fpm.conf
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

# Use composer to install dependencies
RUN mkdir -p /usr/share/nginx/html
WORKDIR "/usr/share/nginx/html"
RUN curl -sS https://getcomposer.org/installer|php

# Install Git for Composer
RUN apt-get install -y git

# Expose ports
# php-fpm, sockets, and x-debug
EXPOSE 5000
EXPOSE 9000
EXPOSE 9999

# Sockets
RUN docker-php-ext-install sockets

# Install Redis
RUN apt-get install -y git
RUN git clone -b php7 https://github.com/phpredis/phpredis.git
RUN mv phpredis /usr/src/php/ext/
RUN ls /usr/src/php/ext | grep -i redis
RUN cd /usr/src/php/ext && docker-php-ext-install phpredis

# Try and install PECL xdebug
RUN docker-php-pecl-install xdebug

# Enable remote debugging, why thank you
RUN echo "xdebug.remote_port = 9999">>/usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
RUN echo "xdebug.idekey = 'PHPSTORM'">>/usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
RUN echo "xdebug.remote_enable = 1">>/usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
RUN echo "xdebug.remote_autostart = 0">>/usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
RUN echo "xdebug.remote_connect_back = 1">>/usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
RUN echo "xdebug.remote_handler = dbgp">>/usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
RUN echo "xdebug.profiler_output_dir = '/tmp/xdebug/'">>/usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini
RUN echo "xdebug.show_exception_trace = 1">>/usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini

# Install mcrypt
RUN docker-php-ext-install mcrypt

CMD ["php-fpm"]
