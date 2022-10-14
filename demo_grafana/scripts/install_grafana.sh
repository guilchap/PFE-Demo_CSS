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

echo "start grafana service"
systemctl start grafana-server
systemctl enable grafana-server

#systemctl status grafana-server