#!/bin/bash

echo "Vous êtes bien dans le webapps de tomcat"
rm /opt/tomcat/apache-tomcat-9.0.70/webapps/pfe-demo-css.war
echo "Le point war du site a bien été remove"
rm -r /opt/tomcat/apache-tomcat-9.0.70/webapps/pfe-demo-css/
echo "Le site a bien été remove"
cp /vagrant/data/pfe-demo-css.war /opt/tomcat/apache-tomcat-9.0.70/webapps/
echo "Le nouveau site est en place"
