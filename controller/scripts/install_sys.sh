#!/bin/bash
## install base system

IP=$(hostname -I | awk '{print $2}')

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_sys.log"

echo "---------------------------"
echo "START - Install Base System"

echo "=> [1]: Installing required packages..."
apt-get update $APT_OPT \
  >> $LOG_FILE 2>&1

apt-get install $APT_OPT \
  wget \
  gnupg \
  gnupg2 \
  unzip \
  curl \
  apt-transport-https \
  software-properties-common \
  default-jdk \
  ufw \
  >> $LOG_FILE 2>&1
  
echo "=> [2]: Server configuration"
# Ajout de contrib et non-free pour les depots
sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list


echo "END - Install Base System"
echo
