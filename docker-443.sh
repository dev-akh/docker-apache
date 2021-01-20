#!/bin/bash
# sh docker-443.sh <<env_mode>> <<ssl_option>> <<apache_conf_name>> <<domain>> <<volume>>
# sh docker-443.sh dev yes site-ssl test.judgify.me no

echo $1;
echo $2;
echo $3;
echo $4;
echo $5;

MODE=$1;
SSL=$2;
CONF=$3;
DOMAIN=$4;
VOLUME=$5;

docker build -t judgify-php74-apache-docker-app:latest .

if [ "$VOLUME" == "yes" ]; then
	#For Window
	#docker run -d -p 443:443 -v  D:/docker/Judgify_API:/var/www/html/ -e "ENV_MODE=$MODE" -e "SSL_OPTION=$SSL" -e "ENV_CONF=$CONF" -e "ENV_DOMAIN=$DOMAIN" judgify-php74-apache-docker-app
	#For Linux
	docker run -d -p 443:443 -v "$PWD":/var/www/html/ -e "ENV_MODE=$MODE" -e "SSL_OPTION=$SSL" -e "ENV_CONF=$CONF" -e "ENV_DOMAIN=$DOMAIN" judgify-php74-apache-docker-app
else
	docker run -d -p 443:443 -e "ENV_MODE=$MODE" -e "SSL_OPTION=$SSL" -e "ENV_CONF=$CONF" -e "ENV_DOMAIN=$DOMAIN" judgify-php74-apache-docker-app
fi
