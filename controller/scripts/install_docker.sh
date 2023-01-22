#!/bin/bash

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_docker.log"

echo "----------------------"
echo "START - Install Docker"

echo "[1] => Remove old Docker"

apt-get remove \
  docker \
  docker.io \
  containerd runc

echo "[2] => Install Docker"

apt-get update $APT_OPT \
  >> $LOG_FILE 2>&1
apt-get install $APT_OPT \
  ca-certificates \
  lsb-release \
  >> $LOG_FILE 2>&1

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

chmod a+r /etc/apt/keyrings/docker.gpg

apt-get update $APT_OPT \
  >> $LOG_FILE 2>&1

apt-get install $APT_OPT \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin \
  >> $LOG_FILE 2>&1

echo "[3] => Construction de l'image"
docker build --no-cache -q -t infra /vagrant/data/

echo "END - Install Docker"
echo