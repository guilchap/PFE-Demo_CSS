#!/bin/bash

#remove les anciennes versions peut être présente

echo "-----------------------"
echo "[1] => Remove old Docker"

apt-get remove docker docker-engine docker.io containerd runc

#installation de docker sur la machine, avec ses dépendances

echo "[2] => Install Docker"

apt-get update
apt-get install -y \
    ca-certificates \
    lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

chmod a+r /etc/apt/keyrings/docker.gpg
apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin