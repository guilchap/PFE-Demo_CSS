#!/bin/bash

LOG_FILE_GRAFANA="/var/log/datacenter/conf_grafana.log"


echo "-------------------------"
echo "START - Configure Grafana"

echo "=> [1]: Delete default files"
rm /etc/grafana/grafana.ini
rm /usr/share/grafana/conf/provisioning/datasources/sample.yaml
rm /usr/share/grafana/conf/provisioning/dashboards/sample.yaml

echo "=> [2]: Copy new files"
cp /tmp/pfe-demo/raspberry/data/grafana.ini /etc/grafana
cp /tmp/pfe-demo/raspberry/data/datasources/default.yaml /usr/share/grafana/conf/provisioning/datasources
cp /tmp/pfe-demo/raspberry/data/dashboard/default.yaml /usr/share/grafana/conf/provisioning/dashboards

echo "=> [3]: Add dashboards"
mkdir /var/lib/grafana/dashboards
cp /tmp/pfe-demo/raspberry/data/dashboard/cluster.json /var/lib/grafana/dashboards

echo "=> [4]: Restart Grafana"
systemctl start grafana-server
systemctl enable grafana-server


echo
echo "END - Configure Grafana"
echo "-----------------------"