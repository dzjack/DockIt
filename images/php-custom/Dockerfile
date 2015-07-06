FROM debian:jessie

# Setting SAST Time
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
RUN "date"

# Copy the dev php.ini
#COPY config/php.ini /usr/local/etc/php/

# Enable Reporting php-fpm
#RUN echo "php_flag[display_errors] = On">>/usr/local/etc/php-fpm.conf
#RUN echo "php_admin_flag[log_errors] = On">>/usr/local/etc/php-fpm.conf
#RUN echo "php_admin_value[display_errors] = 'stderr'">>/usr/local/etc/php-fpm.conf

# Install PHP
RUN apt-get update && apt-get install -y --fix-missing \
php5 \
php5-fpm
#php5-cli \
#php5-curl \
#php5-common \
#php5-redis \
#php5-mysql \
#php-pear \
#php5-mcrypt \
#php5-imagick \
#sed
#imagemagick \

# Enable Reporting php.ini
RUN sed -i "s/error_reporting = .*/error_reporting = -1/" /etc/php5/fpm/php.ini
RUN sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/fpm/php.ini
RUN sed -i "s/cgi.fix_pathinfo = .*:/cgi.fix_pathinfo = 0/" /etc/php5/fpm/php.ini

# Changing PHP-FPM to port 9000
RUN sed -i "s/listen.owner = www-data/;listen.owner = www-data/" /etc/php5/fpm/pool.d/www.conf
RUN sed -i "s/listen.group = www-data/;listen.group = www-data/" /etc/php5/fpm/pool.d/www.conf
RUN sed -i "s/listen = .*/listen = [::]:9000/" /etc/php5/fpm/pool.d/www.conf
#RUN sed -i "s/;daemonize = .*/daemonize = no/" /etc/php5/fpm/pool.d/www.conf

EXPOSE 9000
CMD ["php5-fpm"]

#RUN service php5-fpm reload
#CMD tail -f /var/log/php5-fpm.log