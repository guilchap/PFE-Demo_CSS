#!/bin/bash

#script_hosts
echo "=> START script_hosts"

echo '192.168.56.11 serveur1-cluster'>> /etc/hosts
echo '192.168.56.12 serveur2-cluster'>> /etc/hosts

#Install_Sys
echo "=> START Install_Sys"

IP=$(hostname -I | awk '{print $2}')
#Utilisateur a créer (si vide pas de création)
NOM=""
MDP=""
HDIR=""

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE_SYS="/vagrant/logs/install_sys.log"

echo "---------------------------"
echo "START - Install Base System"

echo "=> [1]: Installing required packages..."
apt-get update $APT_OPT \
  >> $LOG_FILE_SYS 2>&1

apt-get install $APT_OPT \
  wget \
  gnupg \
  unzip \
  curl \
  >> $LOG_FILE_SYS 2>&1
  
echo "=> [2]: Server configuration"
# Ajout de contrib et non-free pour les depots
sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list

echo "=> [3]: Ajout utilisateur"
# ajout utilisateur et autres
if [ -n "$NOM" ] ;then
  mkdir -p $HDIR
  adduser --home $HDIR --disabled-password --no-create-home $NOM
  echo $NOM:$MDP | chpasswd
  chown $NOM $HDIR
  chmod 755 $HDIR
fi

echo "END - Install Base System"
echo

#Install_Web
echo "=> START Install_Web"

LOG_FILE_WEB="/vagrant/logs/install_web.log"
# DEBIAN_FRONTEND="noninteractive"

echo "--------------------------"
echo "START - install web Server"

echo "=> [1]: Installing required packages..."
apt-get install $APT_OPT \
  apache2 \
  php \
  libapache2-mod-php \
  php-mysql \
  php-intl \
  php-curl \
  php-xmlrpc \
  php-soap \
  php-gd \
  php-json \
  php-cli \
  php-pear \
  php-xsl \
  php-zip \
  php-mbstring \
  >> $LOG_FILE_WEB 2>&1

echo "=> [2]: Apache2 configuration"
	# Add configuration of /etc/apache2

echo "=> [3]: Redémarrage du service"
service apache2 reload

echo "END - install web Server"
echo

#Install_Conf
echo "=> START Install_Conf"

echo "START: configuration VM pour cluster"

echo "=> [1]: installer pacemaker abd corosync"

apt install -y pacemaker corosync pcs fence-agents

systemctl enable pacemaker
systemctl start pacemaker
systemctl enable corosync
systemctl start corosync
systemctl enable pcsd.service
systemctl start pcsd.service

echo "=> [2]: créer l'utilisateur hacluster"

# adduser --disabled-password --no-create-home hacluster
# echo hacluster:password | chpasswd

echo -e "password\npassword" | passwd hacluster

echo "=> [3]: installer haproxy"

apt install haproxy

systemctl stop haproxy

#stats_haproxy
echo "=> START stats_haproxy"

echo 'listen stats'>>/etc/haproxy/haproxy.cfg
echo '  bind :9999'>>/etc/haproxy/haproxy.cfg
echo '  mode http'>>/etc/haproxy/haproxy.cfg
echo '  stats enable'>>/etc/haproxy/haproxy.cfg
echo '  stats hide-version'>>/etc/haproxy/haproxy.cfg
echo '  stats uri /stats'>>/etc/haproxy/haproxy.cfg

#Install_Cluster
echo "=> START Install_Cluster"

echo "START: configuration d'un cluster"

echo "=> [1]: détruire l'ancien cluster"

pcs cluster destroy

echo "=> [2]: créer et configurer le cluster"

echo -e "hacluster\npassword" | pcs host auth serveur1-cluster serveur2-cluster

pcs cluster setup rasp --start serveur1-cluster serveur2-cluster --force

pcs cluster enable --all

echo "=> [3]: désactiver stonith"

pcs property set stonith-enabled=false

echo "=> [4]: configuration haproxy"

pcs resource create VirtualIP IPaddr2 ip=192.168.56.30 cidr_netmask=24

pcs resource create HAProxy systemd:haproxy

echo "=> [5]: colocation des ressources"

pcs constraint colocation add VirtualIP with HAProxy score=INFINITY

systemctl restart haproxy