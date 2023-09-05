#!/usr/bin/env bash

MW_DIR="w"
MW_MAJOR_VERSION="1.39"
MW_MINOR_VERSION="1.39.4"

if [ ! -d "$MW_DIR" ]; then
    curl -O "https://releases.wikimedia.org/mediawiki/${MW_MAJOR_VERSION}/mediawiki-${MW_MINOR_VERSION}.tar.gz" \
        --silent
    tar -xf mediawiki-${MW_MINOR_VERSION}.tar.gz
    mv mediawiki-${MW_MINOR_VERSION} w
    rm mediawiki-${MW_MINOR_VERSION}.tar.gz

    cd w/extensions
else
    printf "%s\n" "MediaWiki já presente"
fi
