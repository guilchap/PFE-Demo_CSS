#!/bin/bash

LOG_FILE_CLUSTER="/var/log/datacenter/conf_cluster.log"

CITY="Angers"

INT_NAME_ETH0="eth0"
IP_ADDRESS_PRIV="192.168.26.2"


echo "-------------------------"
echo "START - Configure Cluster"
echo "Datacenter: "$CITY

echo "=> [1]: Enable packages"
systemctl enable pacemaker
systemctl start pacemaker
systemctl enable corosync
systemctl start corosync
systemctl enable pcsd.service
systemctl start pcsd.service
systemctl stop haproxy


echo "=> [2]: Configure interfaces"
echo '192.168.25.2 datacenter-angers'>> /etc/hosts
echo '192.168.26.2 cluster-angers'>> /etc/hosts
echo '192.168.25.3 datacenter-dijon'>> /etc/hosts
echo '192.168.26.3 cluster-dijon'>> /etc/hosts

echo -e "\n# interface $INT_NAME_ETH0" >> /etc/dhcpcd.conf
echo "interface $INT_NAME_ETH0" >> /etc/dhcpcd.conf
echo "  static ip_address=$IP_ADDRESS_PRIV/24" >> /etc/dhcpcd.conf
service dhcpcd restart


echo "=> [3]: Configure cluster"
echo -e "password\npassword" | passwd hacluster


echo
echo "END - Configure Cluster"
echo "-----------------------"
