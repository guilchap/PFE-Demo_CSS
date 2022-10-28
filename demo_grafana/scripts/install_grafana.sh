#!/bin/bash

## install grafana

echo "update APT"
apt-get update -y

echo "install required dependencies"
apt-get install wget curl gnupg2 apt-transport-https software-properties-common -y

echo "downmoad the grafana GPG key"
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -

echo "add grafana repo to APT" 
echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list

echo "update APT"
apt-get update -y

echo "install grafana"
apt-get install grafana -y

grafana-server -v

echo "remplacement fichier ini"
rm /etc/grafana/grafana.ini
cp /vagrant/data/grafana.ini /etc/grafana

echo "installation datasource"
cp /vagrant/data/datasources/default.yaml /usr/share/grafana/conf/provisioning/datasources
rm /usr/share/grafana/conf/provisioning/datasources/sample.yaml

echo "installation dashboard"
cp /vagrant/data/dashboard/default.yaml /usr/share/grafana/conf/provisioning/dashboards
rm /usr/share/grafana/conf/provisioning/dashboards/sample.yaml

echo "installation des graphs"
mkdir /var/lib/grafana/dashboards
cp /vagrant/data/dashboard/cluster.json /var/lib/grafana/dashboards

echo "start grafana service"
systemctl start grafana-server
systemctl enable grafana-server

#systemctl status grafana-server