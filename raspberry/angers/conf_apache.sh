#!/bin/bash

LOG_FILE_WEB="/var/log/datacenter/conf_web.log"

CITY="Angers"

echo "---------------------"
echo "START - Configure Web"

echo "=> [1]: Delete access of default site"
sed -i '/DocumentRoot/ s/^/#/' /etc/apache2/sites-available/000-default.conf

echo "=> [2]: Add new site"
echo '192.168.25.4 web.css.eseo'>> /etc/hosts
mkdir /var/www/html/web.css.eseo/
cp -R PFE-Demo_CSS/raspberry/data/site-html/$CITY/* /var/www/html/web.css.eseo
cp PFE-Demo_CSS/raspberry/data/site-html/web.css.eseo.conf /etc/apache2/sites-available/

echo "=> [3]: Activate new site"
a2ensite web.css.eseo.conf

echo "=> [3]: Restart service"
service apache2 restart


echo
echo "END - Configure Web"
echo "-------------------"