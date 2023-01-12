#!/bin/bash

LOG_FILE_CLUSTER="/var/log/datacenter/conf_cluster.log"

CITY="Dijon"

INT_NAME_ETH0="eth0"
IP_ADDRESS_PRIV="192.168.26.3"

IP_ADDRESS_VIRT="192.168.25.4"


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


echo "=> [2]: Configure hostnames"
echo '192.168.25.2 datacenter.angers'>> /etc/hosts
echo '192.168.26.2 cluster.angers'>> /etc/hosts
echo '192.168.25.3 datacenter.dijon'>> /etc/hosts
echo '192.168.26.3 cluster.dijon'>> /etc/hosts


echo "=> [3]: Configure interface"
echo "# interface $INT_NAME_ETH0" >> /etc/dhcpcd.conf
echo "interface $INT_NAME_ETH0" >> /etc/dhcpcd.conf
echo "  static ip_address=$IP_ADDRESS_PRIV/24" >> /etc/dhcpcd.conf
service dhcpcd restart


echo "=> [4]: Configure cluster"
echo -e "password\npassword" | passwd hacluster
pcs cluster destroy
echo -e "hacluster\npassword" | pcs host auth cluster.angers cluster.dijon
pcs cluster setup rasp --start cluster.angers cluster.dijon --force
pcs cluster enable --all

pcs property set stonith-enabled=false

pcs resource create VirtualIP IPaddr2 ip=$IP_ADDRESS_VIRT cidr_netmask=24
pcs resource create HAProxy systemd:haproxy

pcs constraint colocation add VirtualIP with HAProxy score=INFINITY

systemctl restart haproxy

echo "=> [5]: Configure system"
sed -i 's/exit 0/sleep 30\nsystemctl start corosync\nsleep 30\nsystemctl start pacemaker\nexit 0/g' /etc/rc.local

echo
echo "END - Configure Cluster"
echo "-----------------------"
