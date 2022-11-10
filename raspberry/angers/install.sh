#!/bin/bash

APT_OPT='-o Dpkg::Progress-Fancy="0" -q -y'
LOG_FILE_INSTALL="/var/log/datacenter/install.log"

CITY="Angers"

echo "------------------------"
echo "START - Install Packages"
echo "Datacenter: "$CITY

echo "=> [1]: Log folder"
mkdir /var/log/datacenter

echo "=> [1]: Installing required packages..."
apt-get update $APT_OPT \
    >> $LOG_FILE_INSTALL 2>&1
apt-get upgrade $APT_OPT \
    >> $LOG_FILE_INSTALL 2>&1    

wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list

apt install -y \
    pacemaker \
    corosync \
    pcs \
    fence-agents \
    haproxy \
    wget \
    curl \
    gnupg2 \
    apt-transport-https \
    software-properties-common \
    grafana \
    git \
    >> $LOG_FILE_INSTALL 2>&1


echo
echo "END - Install Packages"
echo "----------------------"
