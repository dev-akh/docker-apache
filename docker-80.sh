#!/bin/bash
# sh docker-80.sh <<env_mode>> <<ssl_option>> <<apache_conf_name>> <<domain>> <<volume>>
# sh docker-80.sh dev no site test.judgify.me yes
# Examples :
# sh docker-80.sh local no site localhost.jud.api yes
read -p "Enter env_mode (eg.local,dev,prod) : " MODE
read -p "Enter ssl_option (no,yes) : " SSL
read -p "Enter apache_conf_name  : " CONF
read -p "Enter domain  : " DOMAIN
read -p "Enter volume (eg. yes,no)  : " VOLUME


# echo $1;
# echo $2;
# echo $3;
# echo $4;
# echo $5;

# MODE=$1;
# SSL=$2;
# CONF=$3;
# DOMAIN=$4;
# VOLUME=$5;


image=$(docker images -q judgify-php74-apache-docker-app )
container=$(docker ps -aqf "name=judgify-php74-api")

if [[ -n "$image" ]]; then
  echo "Removing existed container ......";
  docker stop $container
  docker rm  $container
  echo "Successfully removed"
  echo "Creating ....."
else
  docker build -t judgify-php74-apache-docker-app:latest .
fi

echo "Creating docker container....."

if [ "$VOLUME" == "yes" ]; then
	docker run -p 80:80 --name judgify-php74-api -v  $PWD:/var/www/html/ -e "ENV_MODE=$MODE" -e "SSL_OPTION=$SSL" -e "ENV_CONF=$CONF" -e "ENV_DOMAIN=$DOMAIN" judgify-php74-apache-docker-app
	# was removed for OS detection
else
	docker run -p 80:80 --name judgify-php74-api -e "ENV_MODE=$MODE" -e "SSL_OPTION=$SSL" -e "ENV_CONF=$CONF" -e "ENV_DOMAIN=$DOMAIN" judgify-php74-apache-docker-app
fi
