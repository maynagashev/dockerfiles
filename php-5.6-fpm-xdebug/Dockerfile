FROM php:5.6-fpm

# sources:
# - https://github.com/laradock/laradock/blob/master/php-fpm/Dockerfile-56
# - https://github.com/dgtlmoon/dockerfiles
# - https://serversforhackers.com/t/containers


# Install modules
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libpq-dev \
    apt-utils \
    mysql-client \
    zlib1g-dev

RUN docker-php-ext-install pdo_mysql mbstring opcache \
	&& pecl channel-update pecl.php.net \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd && apt-get install -y libmemcached-dev

RUN pecl install memcached-2.2.0 \
	&& docker-php-ext-enable memcached

RUN pecl install xdebug-2.5.5 \
    && docker-php-ext-enable xdebug

#####################################
# PHP REDIS EXTENSION FOR PHP 5
#####################################

ARG INSTALL_PHPREDIS=true
RUN if [ ${INSTALL_PHPREDIS} = true ]; then \
    # Install Php Redis Extension
    printf "\n" | pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis \
;fi


#####################################
# MongoDB (new driver): http://fi2.php.net/manual/en/set.mongodb.php
#####################################

ARG INSTALL_MONGODB=false
RUN if [ ${INSTALL_MONGODB} = true ]; then \
    # Install the mongodb extension
    pecl install mongodb && \
    docker-php-ext-enable mongodb \
;fi


#####################################
# Mongo (old driver): http://fi2.php.net/manual/en/book.mongo.php
#####################################

ARG INSTALL_MONGO=true
RUN if [ ${INSTALL_MONGO} = true ]; then \
    # Install the mongo extension
    pecl install mongo && \
    docker-php-ext-enable mongo \
;fi


COPY configs/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# replace config for default [www] pool
COPY configs/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

# delete docker extra config wich rewrites listen
RUN unlink /usr/local/etc/php-fpm.d/zz-docker.conf

COPY configs/start-container /usr/local/bin/start-container

RUN chmod +x /usr/local/bin/start-container

#EXPOSE 9000

CMD ["start-container"]