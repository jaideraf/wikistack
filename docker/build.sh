#!/bin/bash
set -e
 
if ! [[ -d ../logs/apache ]]; then
    mkdir -p ../logs/apache
fi
 
if ! [[ -d ../logs/php ]]; then
    mkdir -p ../logs/php
fi

# if ! [[ -d ../logs/mariadb ]]; then
#     mkdir -p ../logs/mariadb
# fi

if ! [[ -d ../database ]]; then
    mkdir ../database
fi
 
docker compose up -d --build --force-recreate
 
docker exec wikistack_apache_con chown -R root:www-data /usr/local/apache2/logs
docker exec wikistack_php_con chown -R root:www-data /usr/local/etc/logs