#!/bin/bash

LOG_FILE_WEB="/var/log/datacenter/conf_web.log"


echo "---------------------"
echo "START - Configure Web"

echo "=> [1]: Delete default file"
rm /var/www/html/index.html

echo "=> [2]: Copy new files"
cp -R /tmp/pfe-demo/data/site-html/* /var/www/html/

echo "=> [3]: Restart service"
service apache2 reload


echo
echo "END - Configure Web"
echo "-------------------"