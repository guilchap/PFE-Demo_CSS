#!/bin/bash
cd /opt/tomcat/apache-tomcat-9.0.69/webapps/
echo "Vous êtes bien dans le webapps de tomcat"
rm pfe-demo-css.war
echo "Le point war du site a bien été remove"
rm -r pfe-demo-css/
echo "Le site a bien été remove"
cp /vagrant/data/pfe-demo-css.war .
echo "Le nouveau site est en place"
