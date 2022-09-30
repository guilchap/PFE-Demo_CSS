#!/bin/bash

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

# echo "=> [6]: activer les ressources"

# pcs resource enable HAProxy --wait=1

# pcs resource enable VirtualIP --wait=1

# echo "=> [7]: activer les services"

# systemctl enable corosync.service

# systemctl enable pacemaker.service
