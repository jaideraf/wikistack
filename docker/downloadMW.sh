#!/usr/bin/env bash

MW_DIR="w"
MW_MAJOR_VERSION="1.39"
MW_MINOR_VERSION="1.39.4"
MW_BRANCH="REL1_39"
WIKI_NAME="BU"
wgDBserver="192.168.0.22"
wgDBuser="root"
wgDBpassword="root"
Adminpassword="Adminpassword"

if [ ! -d "../$MW_DIR" ]; then

    printf "* %s\n" "Downloading MediaWiki"
    curl -O "https://releases.wikimedia.org/mediawiki/${MW_MAJOR_VERSION}/mediawiki-${MW_MINOR_VERSION}.tar.gz" \
        --silent
    tar -xf mediawiki-${MW_MINOR_VERSION}.tar.gz
    mv mediawiki-${MW_MINOR_VERSION} ../w
    rm mediawiki-${MW_MINOR_VERSION}.tar.gz

    printf "* %s\n" "Downloading common extensions"
    cd ../w/extensions

    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/AdminLinks --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CodeMirror --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/DataTransfer --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/DeleteBatch --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Description2 --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/DisplayTitle --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/DynamicSidebar --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/ExternalData --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/HeaderTabs --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/MobileFrontend --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/MyVariables --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/RegexFunctions --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateSandbox --branch ${MW_BRANCH}
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateStyles --branch ${MW_BRANCH}
    cd TemplateStyles
    composer install --no-dev
    cd ..
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/RegexFunctions --branch ${MW_BRANCH}
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/SyntaxHighlight_GeSHi --branch ${MW_BRANCH}
    cd SyntaxHighlight_GeSHi
    composer install --no-dev
    chmod a+x pygments/pygmentize
    cd ..
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UrlGetParameters --branch ${MW_BRANCH}
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UserFunctions --branch ${MW_BRANCH}
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
    cd cldr
    git fetch --tags
    git checkout 2023.07
    cd ..
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/PageForms
    git clone https://github.com/gesinn-it-pub/SemanticDependencyUpdater.git

    printf "* %s\n" "Instaling MediaWiki"
    cd ..
    pwd 
    ls -l
    cp composer.local.json .


    php maintenance/install.php \
        --dbname=my_wiki \
        --dbserver=${wgDBserver} \
        --installdbuser=${wgDBuser} \
        --installdbpass=${wgDBpassword} \
        --dbuser=${wgDBuser} \
        --dbpass=${wgDBpassword} \
        --server="http://localhost:9000" \
        --scriptpath=/w \
        --lang=pt-br \
        --pass=${Adminpassword} \
        "${WIKI_NAME}" \
        "Admin"

else
    printf "* %s\n" "MediaWiki já presente"
fi
