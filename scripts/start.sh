#!/bin/bash
echo 'running Apache Conf'
CONFIG=${ENV_CONF}.conf;
DOMAIN_KEYWORD='###Domain###';

chown -R www-data:www-data /var/www/html
chmod 755 /var/www/html
chmod -R 755 /var/www/html/storage

composer install -q

rm /etc/apache2/sites-available/000-default.conf
rm /etc/apache2/sites-available/default.conf
rm /etc/apache2/sites-available/default-ssl.conf


if [ -f /var/www/html/docker/apache_configs/$CONFIG ]; then
    cp /var/www/html/docker/apache_configs/$CONFIG /etc/apache2/sites-available/$CONFIG		
    ln -s /etc/apache2/sites-available/$CONFIG /etc/apache2/sites-enabled/$CONFIG
fi

echo 'running PORT'
if [ "${SSL_OPTION}" == "yes" ]; then
    echo 'making CERT files';
	sed -i "s/$DOMAIN_KEYWORD/${ENV_DOMAIN}/g" /etc/apache2/sites-available/$CONFIG
	ln -s /etc/apache2/sites-available/$CONFIG /etc/apache2/sites-enabled/$CONFIG
	mkdir /etc/ssl/certs/${ENV_DOMAIN}
	if [ -f /var/www/html/certs/${ENV_DOMAIN}/fullchain.pem ]; then
        cp /var/www/html/certs/${ENV_DOMAIN}/fullchain.pem /etc/ssl/certs/${ENV_DOMAIN}/fullchain.pem
	fi
    if [ -f /var/www/html/certs/${ENV_DOMAIN}/privkey.pem ]; then	
	   cp /var/www/html/certs/${ENV_DOMAIN}/privkey.pem /etc/ssl/certs/${ENV_DOMAIN}/privkey.pem
	fi
fi

echo 'running 01_rename env'
FILE=.env.${ENV_MODE}
if [ -f /var/www/html/$FILE ]; then
    echo 'making env file';
    cp /var/www/html/$FILE /var/www/html/.env

    php artisan key:generate
    php artisan config:clear
    php artisan route:clear
    php artisan config:cache
fi

exec "$@"