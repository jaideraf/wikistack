# Ambiente de MediaWiki (Wikistack)

O ambiente inclui Apache 2.4, PHP-FPM 8.0, MariaDB 11.1 e MediaWiki 1.39.4.

### Baixar os arquivos e entre no diretório docker:
```
git clone https://github.com/jaideraf/wikistack && cd wikistack/docker
```

### Faça primeiramente o build da imagem do PHP
```
docker compose -f "docker-compose.yml" up -d --build php_img --no-deps
```
O processo de build pela primeira vez é demorado. Faça outra coisa e **volte depois de 10min**.

### Dê permissões de execução nos scripts, caso não tenham
```
chmod +x build.sh && chmod +x destroy.sh
```

### Instalar o MediaWiki
```
./destroy.sh && ./build.sh
```

A instalação do MediaWiki e suas extensões é demorada. Faça outra coisa e **volte depois de 10min**.

* Se nesse ponto acontecer um erro referente ao Docker não encontrar a imagem "wikistack-php_img", significa que você está usando uma versão antiga do compose. Ver https://stackoverflow.com/questions/69464001.

A instalação é feita pelo container "wikistack_mw-setup_con". Para ver o processo de instalação em andamento:

```
docker logs --tail 1000 -f wikistack_mw-setup_con
```

**ATENÇÃO: espere esse container parar de executar** (ficar inativo) e depois acesse:

http://localhost:9000/

Veja que o ambiente e as extenções foram instaladas corretamente em: 

http://localhost:9000/wiki/Especial:Versão

### Detalhes

Extensões do PHP incluídas:
```
apcu
calendar
Core
ctype
curl
date
dom
exif
fileinfo
filter
ftp
gd
hash
iconv
imagick
intl
json
ldap
libxml
luasandbox
mbstring
mysqli
mysqlnd
openssl
pcre
PDO
pdo_sqlite
Phar
posix
readline
Reflection
session
SimpleXML
sockets
sodium
SPL
sqlite3
standard
tokenizer
wikidiff2
xml
xmlreader
xmlwriter
Zend OPcache
zlib
```
Extensões do MediaWiki incluídas:
```
AdminLinks
CategoryTree
Cite
CiteThisPage
cldr
CodeEditor
CodeMirror
DataTransfer
DeleteBatch
Description2
DisplayTitle
DynamicSidebar
ExternalData
HeaderTabs
HeadScript
IdGenerator
InputBox
Interwiki
MobileFrontend
MultimediaViewer
MyVariables
Nuke
PageForms
PageImages
ParserFunctions
PdfHandler
Poem
RegexFunctions
ReplaceText
Scribunto
SecureLinkFixer
SemanticDependencyUpdater
SemanticExtraSpecialProperties
SemanticMediaWiki
SemanticResultFormats
SemanticScribunto
SpamBlacklist
SyntaxHighlight
TemplateData
TemplateStyles
UrlGetParameters
UserFunctions
VisualEditor
WikiEditor
```
