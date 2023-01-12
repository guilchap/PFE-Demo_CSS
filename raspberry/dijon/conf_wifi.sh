#!/bin/bash

LOG_FILE_WIFI="/var/log/datacenter/conf_wifi.log"

CITY="Dijon"

INT_NAME_WLAN="wlan0"
IP_ADDRESS_WLAN="192.168.25.3"
IP_ROUTER_WLAN="192.168.25.1"


echo "----------------------"
echo "START - Configure WiFi"
echo "Datacenter: "$CITY

echo "=> [1]: Configure interface wlan"
echo "# interface $INT_NAME_WLAN" >> /etc/dhcpcd.conf
echo "interface $INT_NAME_WLAN" >> /etc/dhcpcd.conf
echo "  static ip_address=$IP_ADDRESS_WLAN/24" >> /etc/dhcpcd.conf
echo "  static routers=$IP_ROUTER_WLAN" >> /etc/dhcpcd.conf

service dhcpcd restart


echo "=> [2]: Configure Wi-Fi"
echo "Ouvrir le raspi-config"
echo "Aller dans l'onglet de configuration WiFi"
echo "Entrer les identifiants du WiFi auquel se connecter"
echo


echo "Un redémarrage est recommandé"
echo
echo "END - Configure WiFi"
echo "--------------------"
