#!/bin/bash
echo "OS Detecting ...$OSTYPE"
echo "current directory: $PWD";
read -p "Enter env_mode (eg.local,dev,prod) : " MODE
read -p "Enter ssl_option (no,yes) : " SSL
read -p "Enter apache_conf_name  : " CONF
read -p "Enter domain  : " DOMAIN
read -p "Enter volume (eg. yes,no)  : " VOLUME

echo "Your config : env_mode:$MODE ssl_option:$SSL apache_conf_name:$CONF domain:$DOMAIN volume:$VOLUME"
case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)  echo "OSX" ;; 
  linux*)   echo "LINUX" ;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "WINDOWS" ;
            echo "$cd";;
  *)        echo "unknown: $OSTYPE" ;;
esac

result=$(docker images -q judgify-php74-apache-docker-app )

if [[ -n "$result" ]]; then
  echo "Images exists"
else
  echo "No such Images"
fi