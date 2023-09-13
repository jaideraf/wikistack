#!/bin/bash
set -e
 
docker compose down --volumes
#docker rmi wikistack-apache_img wikistack-php_img