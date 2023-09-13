# Ambiente de MediaWiki (Wikistack)

## Baixar os arquivos
```
git clone https://github.com/jaideraf/wikistack
cd wikistack/docker
```

## Build
```
docker compose -f "docker-compose.yml" up -d --build apache_img mariadb_img php_img
```
O processo de build pela primeira vez é demorado. Faça outra coisa e **volte depois de 10min**.

## Instalar o MediaWiki
```
chmod +x build.sh
chmod +x destroy.sh
./destroy.sh
./build.sh
```

A instalação do MediaWiki e suas extensões é demorada. Faça outra coisa e **volte depois de 5min**.

A instalação é feita pelo container "wikistack-mw-setup_con". 

**Espere esse container parar de executar** (ficar inativo) e depois acesse:

http://localhost:9000/

Veja que o ambiente e as extenções foram instaladas corretamente em: 

http://localhost:9000/wiki/Especial:Versão
