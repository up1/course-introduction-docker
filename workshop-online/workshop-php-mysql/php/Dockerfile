FROM php:7.3.0-apache-stretch

RUN set -x \
    && apt-get update \
    && apt-get install -y libldap2-dev libjpeg-dev libpng-dev libzip-dev libicu-dev libbz2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install ldap \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \    
    && docker-php-ext-install opcache \
    && docker-php-ext-install zip \
    && docker-php-ext-install bz2 \ 
    && docker-php-ext-install bcmath \
    && docker-php-ext-install intl \
    && pecl install apcu \    
    && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini \
    && rm -rf /var/lib/apt/lists/* 
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY ./www /var/www/html
RUN a2enmod rewrite
