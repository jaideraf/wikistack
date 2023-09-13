FROM php:8.0-fpm

ARG WEB_USER
ARG WEB_GROUP
ARG PHP_ROOT_DIR

# set timezone
ENV TZ=America/Sao_Paulo
RUN set -eux; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY www.conf ${PHP_ROOT_DIR}/php-fpm.d/www.conf

RUN usermod -u 1000 ${WEB_USER} \
    && groupmod -g 1000 ${WEB_GROUP} \
    && chgrp -R staff ${PHP_ROOT_DIR}/php-fpm.d/www.conf

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    git \
    imagemagick \
    libfreetype-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libldap2-dev \
    liblua5.1-0-dev \
    libmagickwand-dev \
    libpng-dev \
    unzip \
    zip \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/

RUN docker-php-ext-install -j$(nproc) \
    calendar \
    exif \
    gd \
    intl \
    ldap \
    mysqli \
    opcache \
    sockets

RUN pecl install apcu; \
    docker-php-ext-enable apcu

RUN pecl install imagick; \
    docker-php-ext-enable imagick

RUN pecl install luasandbox; \
    docker-php-ext-enable luasandbox

WORKDIR /opt

COPY libdatrie-0.2.13.tar.xz .
RUN tar -xf libdatrie-0.2.13.tar.xz \
    && cd libdatrie-0.2.13 \
    && ./configure \
    && make \
    && make install

COPY libthai-0.1.29.tar.xz .
RUN tar -xf libthai-0.1.29.tar.xz \
    && cd libthai-0.1.29 \
    && ./configure \
    && make \
    && make install

RUN curl -O https://releases.wikimedia.org/wikidiff2/wikidiff2-1.14.1.tar.gz
RUN tar -xf wikidiff2-1.14.1.tar.gz \
    && cd wikidiff2-1.14.1 \
    && phpize \
    && ./configure \
    && make \
    && make install
RUN docker-php-ext-enable wikidiff2

# Clear
RUN rm -r libdatrie-0.2.13.tar.xz \
    libdatrie-0.2.13 \
    libthai-0.1.29.tar.xz \
    libthai-0.1.29 \
    wikidiff2-1.14.1.tar.gz \
    wikidiff2-1.14.1

WORKDIR /srv/app

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer