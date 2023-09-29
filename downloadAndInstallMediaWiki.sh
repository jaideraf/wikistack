#!/usr/bin/env bash

MEDIAWIKI_DIR="w"              # see: https://www.mediawiki.org/wiki/Manual:Short_URL
MEDIAWIKI_MAJOR_VERSION="1.39" # current LTS
MEDIAWIKI_VERSION="1.39.5"
MEDIAWIKI_BRANCH="REL1_39"
WIKI_NAME="BU"
ADMINPASSWORD="Adminpassword"                  # change later
SERVER="http://localhost:$APACHE_EXPOSED_PORT" # change later (https://bu.wiki.ufsc.br)

if [ -d "$MEDIAWIKI_DIR" ]; then

    printf "*** %s\n" "You already have a MediaWiki directory. This script will delete it and create a new one now."
    rm -rf "$MEDIAWIKI_DIR"

fi

printf "*** %s\n" "Downloading MediaWiki..."
curl -O "https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz" \
    --silent
tar -xf mediawiki-${MEDIAWIKI_VERSION}.tar.gz
mv mediawiki-${MEDIAWIKI_VERSION} w
rm mediawiki-${MEDIAWIKI_VERSION}.tar.gz

printf "*** %s\n" "Downloading common extensions..."
cd ${MEDIAWIKI_DIR}/extensions || exit

for extension in AdminLinks CodeMirror DataTransfer DeleteBatch Description2 DisplayTitle DynamicSidebar ExternalData HeaderTabs HeadScript MobileFrontend MyVariables RegexFunctions UrlGetParameters UserFunctions; do
    if [ ! -d "$extension" ]; then
        git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/$extension.git --branch ${MEDIAWIKI_BRANCH}
    fi
done
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/PageForms
cd PageForms && git checkout 5.6.1 && cd ..
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateStyles --branch ${MEDIAWIKI_BRANCH}
cd TemplateStyles && composer install --no-dev && cd ..
# git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/SyntaxHighlight_GeSHi --branch ${MEDIAWIKI_BRANCH} # already there
cd SyntaxHighlight_GeSHi && composer install --no-dev && chmod a+x pygments/pygmentize && cd ..
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
cd cldr && git fetch --tags && git checkout 2023.07 && cd ..
git clone https://github.com/gesinn-it-pub/SemanticDependencyUpdater.git
cd ..

printf "*** %s\n" "Instaling MediaWiki..."

cp ../composer.local.json ./composer.local.json

php maintenance/install.php \
    --dbname=bu_wiki \
    --dbserver="$MARIADB_IP" \
    --installdbuser="$MARIADB_ROOT_USER" \
    --installdbpass="$MARIADB_ROOT_PASSWORD" \
    --dbuser="$MARIADB_ROOT_USER" \
    --dbpass="$MARIADB_ROOT_PASSWORD" \
    --server="$SERVER" \
    --scriptpath=/"$MEDIAWIKI_DIR" \
    --lang=pt-br \
    --pass=${ADMINPASSWORD} \
    "${WIKI_NAME}" \
    "Admin" || exit

sleep 3

printf "*** %s\n" "Configuring LocalSettings.php..."
sed -Ei "s/wgEnotifUserTalk = false/wgEnotifUserTalk = true/
         s/wgEnotifWatchlist = false/wgEnotifWatchlist = true/
         s/wgEnableUploads = false/wgEnableUploads = true/
         s/#\$wgUseImageMagick/\$wgUseImageMagick/
         s/wgUseInstantCommons = false/wgUseInstantCommons = true/" \
    LocalSettings.php

cat <<EOF >> LocalSettings.php
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

############### Incluir aqui configurações de SMTP da UFSC ###############

\$wgSMTP = [
    'host'      => 'tls://smtp.ufsc.br', // Where the SMTP server is located. If using SSL or TLS, add the prefix "ssl://" or "tls://".
    'IDHost'    => 'bu.wiki.ufsc.br', // Generally this will be the domain name of your website (aka mywiki.org)
    'localhost' => 'bu.wiki.ufsc.br', // Same as IDHost above; required by some mail servers
    'port'      => 587,               // Port to use when connecting to the SMTP server
    'auth'      => true,              // Should we use SMTP authentication (true or false)
    'username'  => 'my_user_name',    // Username to use for SMTP authentication (if being used)
    'password'  => 'my_password'      // Password to use for SMTP authentication (if being used)
];

##########################################################################


# Loading das extensões básicas:
wfLoadExtension( 'VisualEditor' );
\$wgVisualEditorAvailableNamespaces = [
    'Project' => true
];
wfLoadExtension( 'WikiEditor' );
\$wgHiddenPrefs[] = 'usebetatoolbar';

# Loading das extensões complementares (padrões):
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

# Loading das extensões complementares (adicionais):
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

printf "*** %s\n" "Downloading composer based extensions..."
composer update --no-dev --prefer-source

printf "*** %s\n" "Configuring LocalSettings.php..."
php maintenance/update.php

cat <<EOF >> LocalSettings.php
# Loading das extensões complementares (composer based):
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

printf "*** %s\n" "Updating database tables..."

php maintenance/update.php
php extensions/SemanticMediaWiki/maintenance/updateEntityCollation.php

printf "*** %s\n" "Importing pages..."

php maintenance/importDump.php < ../Wikincat-20230919175926.xml

printf "*** %s\n" "Finalizing setup..."

php maintenance/rebuildrecentchanges.php
php maintenance/initSiteStats.php --update
php maintenance/runJobs.php --maxjobs 1000

printf "*** %s\n" "Done! You can use MediaWiki now."
exit 0