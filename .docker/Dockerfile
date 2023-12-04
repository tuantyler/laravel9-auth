FROM php:8.2-apache

USER root

WORKDIR /var/www/html

### Install PHP Library
RUN apt-get update && apt-get install -y \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        zip \
        curl \
        unzip \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete

### Install redis
RUN pecl install redis && docker-php-ext-enable redis
### Install Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY .docker/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

### Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

### Installl Node
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash
RUN apt-get install -y nodejs
RUN apt-get install -y npm

ENV PS1A="🐳\[\e[33m\]\u\[\e[m\]@laravel\[\e[36m\][\[\e[m\]\[\e[36m\]\w\[\e[m\]\[\e[36m\]]\[\e[m\]: "

RUN echo 'PS1=$PS1A' >> ~/.bashrc

RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite

RUN a2enmod ssl
