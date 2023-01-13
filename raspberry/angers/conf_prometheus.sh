#!/bin/bash

LOG_FILE_GRAFANA="/var/log/datacenter/conf_prometheus.log"


echo "----------------------------"
echo "START - Configure Prometheus"

echo "=> [1]: Add user prometheus"
useradd --no-create-home --shell /bin/false prometheus

echo "=> [2]: Initialize folders"
mkdir /etc/prometheus
mkdir /var/lib/prometheus

echo "=> [3]: Extract files of Prometheus"
tar -xvf $(pwd)/data/prometheus.tar.gz
mv $(pwd)/prometheus-2.40.1.linux-armv7 $(pwd)/data/
cp $(pwd)/data/prometheus-2.40.1.linux-armv7/prometheus /usr/local/bin
cp $(pwd)/data/prometheus-2.40.1.linux-armv7/promtool /usr/local/bin
cp -r $(pwd)/data/prometheus-2.40.1.linux-armv7/consoles /etc/prometheus
cp -r $(pwd)/data/prometheus-2.40.1.linux-armv7/console_libraries /etc/prometheus
cp $(pwd)/data/prometheus.yml /etc/prometheus/
cp $(pwd)/data/prometheus.service /etc/systemd/system/

echo "=> [4]: Change rights"
chown -R prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool

echo "=> [5]: Start Prometheus"
systemctl daemon-reload
systemctl start prometheus
systemctl enable prometheus


echo
echo "END - Configure Prometheus"
echo "--------------------------"