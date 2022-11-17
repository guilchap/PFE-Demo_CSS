#!/bin/bash

LOG_FILE_GRAFANA="/var/log/datacenter/conf_prometheus.log"


echo "----------------------------"
echo "START - Configure Prometheus"

echo "=> [1]: Add user prometheus"
useradd -r prometheus

echo "=> [2]: Folder and rights"
mkdir /opt/prometheus
chown prometheus:prometheus /opt/prometheus

echo "=> [3]: Install Prometheus"
tar -xvf /tmp/prometheus.tar.gz -C /opt/prometheus --strip=1

echo "=> [4]: Add new config file"
rm /opt/prometheus/prometheus.yml
cp /tmp/PFE-Demo_CSS/raspberry/data/prometheus.yml /opt/prometheus/

echo "=> [5]: Start Prometheus"
systemctl start prometheus
systemctl enable prometheus


echo
echo "END - Configure Prometheus"
echo "--------------------------"