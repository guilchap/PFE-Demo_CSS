#!/bin/bash

LOG_FILE_WEB="/var/log/datacenter/conf_web.log"

CITY="Angers"

echo "---------------------"
echo "START - Configure Web"

echo "=> [1]: Delete default site"
a2dissite 000-default

echo "=> [2]: Add new site"
echo '192.168.25.4 web.css.eseo'>> /etc/hosts
mkdir /var/www/web.css.eseo/
cp -R $(pwd)/data/site-html/$CITY/* /var/www/web.css.eseo
cp $(pwd)/data/site-html/web.css.eseo.conf /etc/apache2/sites-available/

echo "=> [3]: Activate new site"
a2ensite web.css.eseo.conf

echo "=> [3]: Restart service"
systemctl reload apache2


echo
echo "END - Configure Web"
echo "-------------------"