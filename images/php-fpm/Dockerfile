FROM php:5.6-fpm

# Copy the dev php.ini
COPY config/php.ini /usr/local/etc/php/

# Enable Reporting
RUN echo "php_flag[display_errors] = On">>/usr/local/etc/php-fpm.conf
RUN echo "php_admin_flag[log_errors] = On">>/usr/local/etc/php-fpm.conf
RUN echo "php_admin_value[display_errors] = 'stderr'">>/usr/local/etc/php-fpm.conf

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
imagemagick \
php-pear \
php5-redis \
php5-xcache \
php5-mysql \
php5-curl \
php5-mcrypt \
php5-imagick \
&& docker-php-ext-install mysql \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install iconv \
&& docker-php-ext-install exif \
&& docker-php-ext-install pdo \
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install gd

CMD ["php-fpm"]