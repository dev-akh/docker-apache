FROM judgify/judgify-php74-apache-docker-baseimage:2021_01_15_001
# ##################################################################################################
# Copy the source code into /var/www/html/ inside the image
COPY . /var/www/html/

# Set default working directory
WORKDIR "/var/www/html/"

RUN mkdir -p /var/www/html/app/tmp \
	&& chown -R www-data:www-data /var/www/html/app/tmp \
	&& chmod -R 770 /var/www/html/app/tmp
	
# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer -q
# Install vendor files accourding to composer.json
# ##################################################################################################
# install-prod.sh
# RUN chmod 777 app/Console/cake
# RUN chmod -R 777 app/tmp
# RUN chmod -R 777 app/webroot/temp
# RUN chmod -R 777 app/webroot/upload
# RUN chmod -R 777 app/Vendor/htmlpurifier/library/HTMLPurifier/DefinitionCache/Serializer

# public voting webroot
# Comment out because I don't know how the following 2 lines work
# RUN ln -sf ../../app/Plugin/PublicVoting/webroot/ app/webroot/public_voting
# RUN chown -h webapp:webapp app/webroot/public_voting
# ##################################################################################################
# Restart Apache
#RUN service apache2 restart
#CMD ["apachectl", "-D", "FOREGROUND"]

# Environment variables and run start.sh

ADD ./scripts/start.sh /start.sh
RUN chmod 755 /start.sh
# ##################################################################################################
CMD ["/start.sh","apache2-foreground"]