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

if [ ! -d "$MW_DIR" ]; then

    printf "* %s\n" "Downloading MediaWiki..."
    curl -O "https://releases.wikimedia.org/mediawiki/${MW_MAJOR_VERSION}/mediawiki-${MW_MINOR_VERSION}.tar.gz" \
        --silent
    tar -xf mediawiki-${MW_MINOR_VERSION}.tar.gz
    mv mediawiki-${MW_MINOR_VERSION} w
    rm mediawiki-${MW_MINOR_VERSION}.tar.gz

    printf "* %s\n" "Downloading common extensions..."
    cd ${MW_DIR}/extensions

    for extension in AdminLinks CodeMirror DataTransfer DeleteBatch Description2 DisplayTitle DynamicSidebar ExternalData HeaderTabs HeadScript MobileFrontend MyVariables RegexFunctions UrlGetParameters UserFunctions; do
        if [ ! -d "$extension" ]; then
            git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/$extension.git --branch ${MW_BRANCH}
        fi
    done
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/PageForms
    cd PageForms && git checkout 5.6.1 && cd ..
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateStyles --branch ${MW_BRANCH}
    cd TemplateStyles && composer install --no-dev && cd ..
    # git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/SyntaxHighlight_GeSHi --branch ${MW_BRANCH}
    cd SyntaxHighlight_GeSHi && composer install --no-dev && chmod a+x pygments/pygmentize && cd ..
    git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
    cd cldr && git fetch --tags && git checkout 2023.07 && cd ..
    git clone https://github.com/gesinn-it-pub/SemanticDependencyUpdater.git
    cd ..

    printf "* %s\n" "Instaling MediaWiki..."
    cp ../composer.local.json ./composer.local.json
    composer install --no-dev

    php maintenance/install.php \
        --dbname=wiki \
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

    sleep 5
    printf "* %s\n" "Configuring LocalSettings.php..."
    sed -Ei 's/wgEnotifUserTalk = false/wgEnotifUserTalk = true/
            s/wgEnotifWatchlist = false/wgEnotifWatchlist = true/
            s/wgEnableUploads = false/wgEnableUploads = true/
            s/#\$wgUseImageMagick/\$wgUseImageMagick/
            s/wgUseInstantCommons = false/wgUseInstantCommons = true/' \
            LocalSettings.php
    
    cat << EOF >> LocalSettings.php
\$wgArticlePath = "/wiki/\$1";
\$wgNamespacesWithSubpages[NS_MAIN] = true;
\$wgRawHtml = true;
\$wgAllowExternalImages = true;
\$wgAllowDisplayTitle = true;
\$wgRestrictDisplayTitle = false;
\$wgFileExtensions = array_merge(
    \$wgFileExtensions, array(
        'pdf', 'svg', 'webp', 'doc','docx', 'ppt', 'xls', 'xlsx'
        )
);
define("NS_AUTHORITY", 3000);
define("NS_AUTHORITY_TALK", 3001);
\$wgExtraNamespaces[NS_AUTHORITY] = "Autoridade";
\$wgExtraNamespaces[NS_AUTHORITY_TALK] = "Autoridade_Discussão";
\$wgNamespaceAliases['Authority'] = NS_AUTHORITY;
\$wgNamespaceAliases['Authority_Talk'] = NS_AUTHORITY_TALK; 

\$wgFavicon = "../static-only/cropped-favicon-32x32.png";
\$wgLogos = [
    '1x' => "../static-only/logo-bu-ufsc-135-135.png",
    '1.5x' => "../static-only/logo-bu-ufsc-202-202.png",
    '2x' => "../static-only/logo-bu-ufsc-270-270.png",
    'icon' => "../static-only/logo-bu-ufsc-50-50.png",
    'wordmark' => [
        'src' => "../static-only/logo-bu-ufsc-wordmark.png",
        'width' => 135,
        'height' => 20
    ]
];


# Básicas:
wfLoadExtension( 'VisualEditor' );
wfLoadExtension( 'WikiEditor' );
\$wgHiddenPrefs[] = 'usebetatoolbar';

wfLoadExtension( 'CategoryTree' );
wfLoadExtension( 'Cite' );
wfLoadExtension( 'CiteThisPage' );
wfLoadExtension( 'CodeEditor' );
wfLoadExtension( 'InputBox' );
wfLoadExtension( 'Interwiki' );
# To grant sysops permissions to edit interwiki data
\$wgGroupPermissions['sysop']['interwiki'] = true;
wfLoadExtension( 'MultimediaViewer' );
wfLoadExtension( 'Nuke' );
wfLoadExtension( 'PageImages' );
wfLoadExtension( 'ParserFunctions' );
\$wgPFEnableStringFunctions = true;
\$wgPFStringLengthLimit = 10000;
wfLoadExtension( 'PdfHandler' );
wfLoadExtension( 'ReplaceText' );
wfLoadExtension( 'Poem' );
wfLoadExtension( 'Scribunto' );
\$wgScribuntoDefaultEngine = 'luasandbox';
wfLoadExtension( 'SecureLinkFixer' );
wfLoadExtension( 'SpamBlacklist' );
wfLoadExtension( 'SyntaxHighlight_GeSHi' );
wfLoadExtension( 'TemplateData' );
# Skin (MinervaNeue será usado com MobileFrontend)
wfLoadSkin( 'MinervaNeue' );


wfLoadExtension( 'AdminLinks' );
wfLoadExtension( 'cldr' );
wfLoadExtension( 'CodeMirror' );
\$wgDefaultUserOptions['usecodemirror'] = 1;
wfLoadExtension( 'DataTransfer' );
wfLoadExtension( 'DeleteBatch' );
wfLoadExtension( 'Description2' );
\$wgEnableMetaDescriptionFunctions = true;
wfLoadExtension( 'DisplayTitle' );
\$wgDisplayTitleHideSubtitle = true;
wfLoadExtension( 'DynamicSidebar' );
\$wgDynamicSidebarUseGroups = true;
wfLoadExtension( 'ExternalData' );
wfLoadExtension( 'MobileFrontend' );
\$wgDefaultMobileSkin = 'minerva';
wfLoadExtension( 'MyVariables' );
wfLoadExtension( 'PageForms' );
\$wgPageFormsAutoCreateUser = "Automatic";
\$wgPageFormsMaxLocalAutocompleteValues = 1;
\$wgPageFormsAutocompleteOnAllChars = true;
wfLoadExtension( 'RegexFunctions' );
\$wgTemplateSandboxEditNamespaces[] = 'NS_MODULE';
wfLoadExtension( 'TemplateStyles' );
wfLoadExtension( 'UrlGetParameters' );
wfLoadExtension( 'UserFunctions' );
\$wgUFAllowedNamespaces = array(
    NS_MAIN => true,
    NS_USER => true,
    NS_TEMPLATE => true,
    NS_PROJECT => true
);
EOF

    composer update --no-dev --prefer-source
    php maintenance/update.php

    cat << EOF >> LocalSettings.php
wfLoadExtension( 'IdGenerator' );
wfLoadExtension( 'SemanticMediaWiki' );
enableSemantics( 'bu.wiki.ufsc.br' );
\$wgDefaultUserOptions['smw-prefs-general-options-show-entity-issue-panel'] = false;
\$smwgNamespacesWithSemanticLinks[NS_AUTHORITY] = true;
\$smwgNamespacesWithSemanticLinks[NS_AUTHORITY_TALK] = false;
\$smwgPDefaultType = '_txt';
\$smwgPageSpecialProperties = [];
\$smwgPageSpecialProperties[] = '_MDAT';
\$smwgPageSpecialProperties[] = '_CDAT';
\$smwgPageSpecialProperties[] = '_DTITLE';
\$smwgFieldTypeFeatures = SMW_FIELDT_CHAR_LONG;
\$smwgExperimentalFeatures = \$smwgExperimentalFeatures & ~SMW_QUERYRESULT_PREFETCH;
\$smwgEntityCollation = 'uppercase';
\$smwgEnabledQueryDependencyLinksStore = true;
\$smwgEnabledFulltextSearch = true;
\$smwgFulltextSearchIndexableDataTypes = SMW_FT_BLOB | SMW_FT_URI | SMW_FT_WIKIPAGE;
\$smwgQMaxSize = 55;
\$smwgEnabledEditPageHelp = false;
\$smwgEnabledSpecialPage['RunQuery'] = true;
\$wgSearchType = 'SMWSearch';
\$GLOBALS['smwgJobQueueWatchlist'] = [
	'smw.update',
	'smw.parserCachePurge',
    'smw.fulltextSearchTableUpdate',
    'smw.changePropagationUpdate',
    'smw.changePropagationClassUpdate',
    'smw.changePropagationDispatch'
];
wfLoadExtension( 'SemanticResultFormats' );
wfLoadExtension( 'SemanticExtraSpecialProperties' );
\$sespgEnabledPropertyList = array(
	'_CUSER',
	'_SUBP'
);
wfLoadExtension( 'SemanticScribunto' );

# HeaderTabs precisa ficar em baixo por causa do registro de namespaces de outras extensões
wfLoadExtension( 'HeaderTabs' );
\$wgHeaderTabsEditTabLink = false;
\$wgHeaderTabsRenderSingleTab = true;
\$wgHeaderTabsAutomaticNamespaces[] = NS_MAIN;
\$wgHeaderTabsAutomaticNamespaces[] = NS_USER;
\$wgHeaderTabsAutomaticNamespaces[] = NS_AUTHORITY;

# SemanticDependencyUpdater precisa ficar em baixo por causa do registro do SMW
wfLoadExtension( 'SemanticDependencyUpdater' );
\$wgSDUUseJobQueue = false;
EOF
    printf "* %s\n" "Updating database tables..."
    php maintenance/update.php
    php extensions/SemanticMediaWiki/maintenance/updateEntityCollation.php
    printf "* %s\n" "Done! You can use MediaWiki now."
else
    printf "* %s\n" "MediaWiki já presente, saindo do script de instalação."
fi
