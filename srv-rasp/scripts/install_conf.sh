#!/bin/bash

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