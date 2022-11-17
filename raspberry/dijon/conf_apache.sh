#!/bin/bash

LOG_FILE_WEB="/var/log/datacenter/conf_web.log"

CITY="Dijon"

echo "---------------------"
echo "START - Configure Web"

echo "=> [1]: Delete default file"
rm /var/www/html/index.html

echo "=> [2]: Copy new files"
cp -R /tmp/PFE-Demo_CSS/raspberry/data/site-html/$CITY/* /var/www/html/

echo "=> [3]: Restart service"
service apache2 reload


echo
echo "END - Configure Web"
echo "-------------------"