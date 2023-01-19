#!/bin/bash

## install web server with php

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_web.log"
# DEBIAN_FRONTEND="noninteractive"

echo "--------------------------"
echo "START - install web Server"

echo "=> [1]: Installing required packages..."
apt-get install $APT_OPT \
  apache2 \
  php \
  libapache2-mod-php \
  php-mysql \
  php-intl \
  php-curl \
  php-xmlrpc \
  php-soap \
  php-gd \
  php-json \
  php-cli \
  php-pear \
  php-xsl \
  php-zip \
  php-mbstring \
  >> $LOG_FILE 2>&1

echo "=> [2]: Active modules"
a2enmod proxy_ajp
a2enmod proxy_http

echo "=> [3]: Configuration du proxy"
cat <<EOF >> /etc/apache2/apache2.conf
ProxyPass / http://127.0.0.1:8080/
ProxyPassReverse / http://127.0.0.1:8080/
ProxyPass /admin/ http://127.0.0.1:8080/admin/
ProxyPassReverse /admin/ http://127.0.0.1:8080/admin/

EOF

echo "=> [4]: Redémarrage du service"
service apache2 reload

echo "END - install web Server"
echo

