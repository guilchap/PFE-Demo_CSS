#!/bin/bash

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_tomcat.log"

echo "----------------------"
echo "START - install Tomcat"

echo "=> [2]: Add new user"
useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
usermod -aG docker tomcat

echo "=> [3]: Download and extract Tomcat"
wget -O /tmp/tomcat.tar.gz -c https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.tar.gz \
    >> $LOG_FILE 2>&1
tar xf /tmp/tomcat.tar.gz -C /opt/tomcat

echo "=> [4]: Folders management"
ln -s /opt/tomcat/apache-tomcat-9.0.71 /opt/tomcat/updated

chown -R tomcat: /opt/tomcat/*

sh -c 'chmod +x /opt/tomcat/updated/bin/*.sh'

echo "=> [5]: Add new files"
cp /vagrant/data/tomcat.service /etc/systemd/system/tomcat.service
cp /vagrant/data/pfe-demo-css.war /opt/tomcat/apache-tomcat-9.0.71/webapps/
cp /vagrant/data/etudiant.war /opt/tomcat/apache-tomcat-9.0.71/webapps/

echo "=> [6]: Add path to access"
sed -i '159i\	<Context path="" docBase="/opt/tomcat/apache-tomcat-9.0.71/webapps/etudiant" reloadable="true"/>' /opt/tomcat/apache-tomcat-9.0.71/conf/server.xml
sed -i '160i\	<Context path="/admin" docBase="/opt/tomcat/apache-tomcat-9.0.71/webapps/pfe-demo-css" />' /opt/tomcat/apache-tomcat-9.0.71/conf/server.xml

echo "=> [7]: Network management"
ufw allow 8080/tcp
echo '192.168.25.5 demo.css.eseo'>> /etc/hosts

echo "=> [8]: Start Tomcat service"
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat


echo "END - Install Tomcat"
echo