#!/bin/bash

## install grafana

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_grafana.log"

echo "-----------------------"
echo "START - Install Grafana"

echo "=> [1]: Installing required packages..."
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add - 
echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list

apt-get update $APT_OPT \
    >> $LOG_FILE 2>&1

apt-get install $APT_OPT \
    wget \
    curl \
    gnupg2 \
    apt-transport-https \
    software-properties-common \
    grafana \
    >> $LOG_FILE 2>&1

echo "=> [2]: Remove all default files"
rm /etc/grafana/grafana.ini
rm /usr/share/grafana/conf/provisioning/datasources/sample.yaml
rm /usr/share/grafana/conf/provisioning/dashboards/sample.yaml

echo "=> [3]: Add personnalized files"
mkdir /var/lib/grafana/dashboards

cp /vagrant/data/grafana.ini /etc/grafana
cp /vagrant/data/datasources/default.yaml /usr/share/grafana/conf/provisioning/datasources
cp /vagrant/data/dashboard/default.yaml /usr/share/grafana/conf/provisioning/dashboards
cp /vagrant/data/dashboard/cluster.json /var/lib/grafana/dashboards

echo "=> [4]: Start Grafana service"
systemctl start grafana-server
systemctl enable grafana-server

echo "END - Install Grafana"
echo