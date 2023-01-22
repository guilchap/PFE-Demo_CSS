#!/bin/bash

LOG_FILE_INSTALL="/var/log/datacenter/install.log"

CITY="Dijon"

echo "------------------------"
echo "START - Install Packages"
echo "Datacenter: "$CITY

echo "=> [1]: Log folder"
mkdir /var/log/datacenter

echo "=> [1]: Installing required packages..."
apt install -y \
    pacemaker \
    pacemaker-cli-utils \
    corosync \
    pcs \
    fence-agents \
    haproxy \
    apache2 \
    >> $LOG_FILE_INSTALL 2>&1

wget -q -O /home/pi$CITY/PFE-Demo_CSS/raspberry/data/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.40.1/prometheus-2.40.1.linux-armv7.tar.gz
wget -q -O /home/pi$CITY/PFE-Demo_CSS/raspberry/data/netdata-kickstart.sh https://my-netdata.io/kickstart.sh 


echo
echo "END - Install Packages"
echo "----------------------"
