Olá, antes de continuarmos com as extensões, aqui vão algumas configurações que gostaria que fossem definidas:

== No Dockerfile ==
No MediaWiki é muito importante que a data e a hora estejam corretas, inclusive com o fuso horário, caso não esteja configurado, então:

ENV TZ=America/Sao_Paulo
RUN set -eux; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Precisaremos do composer para instalar algumas extensões, caso não tenha instalado:
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Use Wikidiff2: https://www.mediawiki.org/wiki/Wikidiff2
apt-get install php-wikidiff2

== No LocalSettings.php ==
De preferência, antes da invocação de todas as extensões:

$wgEnableEmail = true;
$wgEnableUserEmail = true;
$wgEnotifUserTalk = true;
$wgEnotifWatchlist = true;
$wgEnableUploads = true;
$wgUseImageMagick = true;
$wgUseInstantCommons = true;
$wgNamespacesWithSubpages[NS_MAIN] = true;
$wgRawHtml = true;
$wgAllowExternalImages = true;
$wgAllowDisplayTitle = true;
$wgRestrictDisplayTitle = false;
$wgFileExtensions = array_merge(
    $wgFileExtensions, array(
        'pdf', 'svg', 'webp', 'doc','docx', 'ppt', 'xls', 'xlsx'
        )
);
define("NS_AUTHORITY", 3000);
define("NS_AUTHORITY_TALK", 3001);
$wgExtraNamespaces[NS_AUTHORITY] = "Autoridade";
$wgExtraNamespaces[NS_AUTHORITY_TALK] = "Autoridade_Discussão";
$wgNamespaceAliases['Authority'] = NS_AUTHORITY;
$wgNamespaceAliases['Authority_Talk'] = NS_AUTHORITY_TALK;

# Os caminhos a seguir precisam ser ajustados para o local exato 
$wgFavicon = "../static-only/cropped-favicon-32x32.png";
$wgLogos = [
'1x' => "../static-only/logo-bu-ufsc-135-135.png",
'1.5x' => "../static-only/logo-bu-ufsc-202-202.png",
'2x' => "../static-only/logo-bu-ufsc-270-270.png",
'icon' => "../static-only/logo-bu-ufsc-50-50.png",
'wordmark' => [
'1x' => "../logo-bu-ufsc-wordmark",
'width' => 135,
'height' => 20
]
];

Agora as que precisam ser baixadas na pasta extensions:



cd extensions

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/AdminLinks --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CodeMirror --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/DataTransfer --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/DeleteBatch --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Description2 --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/DisplayTitle --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/DynamicSidebar --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/ExternalData --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/HeaderTabs --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/MobileFrontend --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/MyVariables --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/RegexFunctions --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateSandbox --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateStyles --branch REL1_39
cd TemplateStyles ; composer install --no-dev ; cd ..
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/RegexFunctions --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/SyntaxHighlight_GeSHi --branch REL1_39
cd SyntaxHighlight_GeSHi ; composer install --no-dev ; chmod a+x pygments/pygmentize ; cd ..
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UrlGetParameters --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UserFunctions --branch REL1_39
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
cd cldr; git fetch --tags ; git checkout 2023.07 ; cd ..
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/PageForms
git clone https://github.com/gesinn-it-pub/SemanticDependencyUpdater.git

Inclua no LocalSettings.php:

wfLoadExtension( 'AdminLinks' );
wfLoadExtension( 'cldr' );
wfLoadExtension( 'CodeMirror' );
$wgDefaultUserOptions['usecodemirror'] = 1;
wfLoadExtension( 'DataTransfer' );
wfLoadExtension( 'DeleteBatch' );
wfLoadExtension( 'Description2' );
$wgEnableMetaDescriptionFunctions = true;
wfLoadExtension( 'DisplayTitle' );
$wgDisplayTitleHideSubtitle = true;
wfLoadExtension( 'DynamicSidebar' );
$wgDynamicSidebarUseGroups = true;
wfLoadExtension( 'ExternalData' );
wfLoadExtension( 'MobileFrontend' );
$wgDefaultMobileSkin = 'minerva';
wfLoadExtension( 'MyVariables' );
wfLoadExtension( 'PageForms' );
$wgPageFormsAutoCreateUser = "Automatic";
$wgPageFormsMaxLocalAutocompleteValues = 1;
$wgPageFormsAutocompleteOnAllChars = true;
wfLoadExtension( 'RegexFunctions' );
wfLoadExtension( 'TemplateSandbox' );
$wgTemplateSandboxEditNamespaces[] = 'NS_MODULE';
wfLoadExtension( 'TemplateStyles' );
wfLoadExtension( 'UrlGetParameters' );
wfLoadExtension( 'UserFunctions' );
$wgUFAllowedNamespaces = array(
    NS_MAIN => true,
    NS_USER => true,
    NS_TEMPLATE => true,
    NS_PROJECT => true
);

### Extensões semânticas ou instaladas prioritariamente pelo composer:

Inclua o arquivo composer.local.json (ver anexo) no diretório raiz do MediaWiki, e então:

composer update --no-dev --prefer-source

php maintenance/update.php
php extensions/SemanticMediaWiki/maintenance/updateEntityCollation.php

Inclua no LocalSettings.php:

wfLoadExtension( 'IdGenerator' );
wfLoadExtension( 'SemanticMediaWiki' );
enableSemantics( 'bu.wiki.ufsc.br' );
$wgDefaultUserOptions['smw-prefs-general-options-show-entity-issue-panel'] = false;
$smwgNamespacesWithSemanticLinks[NS_AUTHORITY] = true;
$smwgNamespacesWithSemanticLinks[NS_AUTHORITY_TALK] = false;
$smwgPDefaultType = '_txt';
$smwgPageSpecialProperties = [];
$smwgPageSpecialProperties[] = '_MDAT';
$smwgPageSpecialProperties[] = '_CDAT';
$smwgPageSpecialProperties[] = '_DTITLE';
$smwgFieldTypeFeatures = SMW_FIELDT_CHAR_LONG;
$smwgExperimentalFeatures = $smwgExperimentalFeatures & ~SMW_QUERYRESULT_PREFETCH;
$smwgEntityCollation = 'uppercase';
$smwgEnabledQueryDependencyLinksStore = true;
$smwgEnabledFulltextSearch = true;
$smwgFulltextSearchIndexableDataTypes = SMW_FT_BLOB | SMW_FT_URI | SMW_FT_WIKIPAGE;
$smwgQMaxSize = 55;
$smwgEnabledEditPageHelp = false;
$smwgEnabledSpecialPage['RunQuery'] = true;
$wgSearchType = 'SMWSearch';
$GLOBALS['smwgJobQueueWatchlist'] = [
	'smw.update',
	'smw.parserCachePurge',
    'smw.fulltextSearchTableUpdate',
    'smw.changePropagationUpdate',
    'smw.changePropagationClassUpdate',
    'smw.changePropagationDispatch'
];
wfLoadExtension( 'SemanticResultFormats' );
wfLoadExtension( 'SemanticExtraSpecialProperties' );
$sespgEnabledPropertyList = array(
	'_CUSER',
	'_SUBP'
);
wfLoadExtension( 'SemanticScribunto' );

# HeaderTabs precisa ficar em baixo por causa do registro de namespaces de outras extensões
wfLoadExtension( 'HeaderTabs' );
$wgHeaderTabsEditTabLink = false;
$wgHeaderTabsRenderSingleTab = true;
$wgHeaderTabsAutomaticNamespaces[] = NS_MAIN;
$wgHeaderTabsAutomaticNamespaces[] = NS_USER;
$wgHeaderTabsAutomaticNamespaces[] = NS_AUTHORITY;

# SemanticDependencyUpdater precisa ficar em baixo por causa do registro do SMW
wfLoadExtension( 'SemanticDependencyUpdater' );
$wgSDUUseJobQueue = false;

É provável que tenha que executar esses scripts novamente:

php maintenance/update.php
php extensions/SemanticMediaWiki/maintenance/updateEntityCollation.php


Agendar no cron:

SHELL="/bin/bash"
*/2 * * * * /caminho/ate/o/php /var/www/html/maintenance/runJobs.php --maxjobs 1000 --quiet
55 22 * * * /caminho/ate/o/php /var/www/html/extensions/SemanticMediaWiki/maintenance/rebuildData.php --quiet --shallow-update
55 23 * * * /caminho/ate/o/php /var/www/html/extensions/SemanticMediaWiki/maintenance/disposeOutdatedEntities.php --quiet
55 01 * * * /caminho/ate/o/php /var/www/html/extensions/SemanticMediaWiki/maintenance/rebuildPropertyStatistics.php --quiet
55 02 * * * /caminho/ate/o/php /var/www/html/extensions/SemanticMediaWiki/maintenance/rebuildConceptCache.php --quiet --update --create
55 03 * * * /caminho/ate/o/php /var/www/html/extensions/SemanticMediaWiki/maintenance/removeDuplicateEntities.php --quiet
55 04 * * * /caminho/ate/o/php /var/www/html/extensions/SemanticMediaWiki/maintenance/rebuildFulltextSearchTable.php --optimize
55 05 * * * /caminho/ate/o/php /var/www/html/extensions/SemanticMediaWiki/maintenance/updateEntityCollation.php
@weekly /caminho/ate/o/php /var/www/html/extensions/SemanticMediaWiki/maintenance/setupStore.php --quiet --skip-import
# don't forget the newline!