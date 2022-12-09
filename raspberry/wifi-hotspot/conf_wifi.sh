#!/bin/bash

APT_OPT='-o Dpkg::Progress-Fancy="0" -q -y'
LOG_FILE_WIFI="/var/log/conf_wifi.log"

INT_NAME="wlan0"
WIFI_NAME="CSS-HOTSPOT"
IP_ADDRESS="192.168.25.1/24"
DHCP_START="192.168.25.10"
DHCP_END="192.168.25.15"
DHCP_MASK="255.255.255.0"
DHCP_LENGTH="24h"

echo "----------------------"
echo "START - Configure WiFi"

echo "=> [1]: Installing required packages..."
# apt-get update $APT_OPT \
#     >> $LOG_FILE_WIFI 2>&1
# apt-get upgrade $APT_OPT \
#     >> $LOG_FILE_WIFI 2>&1    

apt-get install \
    network-manager \
    >> $LOG_FILE_WIFI 2>&1
systemctl start NetworkManager.service 
systemctl enable NetworkManager.service


# echo "=> [2]: Configure interface wlan"
# echo "# interface $INT_NAME" >> /etc/dhcpcd.conf
# echo "interface $INT_NAME" >> /etc/dhcpcd.conf
# echo "  static ip_address=$IP_ADDRESS" >> /etc/dhcpcd.conf
# service dhcpcd restart


echo "=> [3]: Configure DHCP"
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.old
echo "interface=$INT_NAME" >> /etc/dnsmasq.conf
echo "dhcp-range=$DHCP_START,$DHCP_END,$DHCP_MASK,$DHCP_LENGTH" >> /etc/dnsmasq.conf


echo "=> [4]: Configure Hotspot"
nmcli con add type wifi ifname $INT_NAME con-name $WIFI_NAME autoconnect yes ssid $WIFI_NAME
nmcli con modify $WIFI_NAME ipv4.addresses 192.168.25.1/24 
nmcli con modify $WIFI_NAME 802-11-wireless.mode ap 802-11-wireless.band bg ipv4.method shared
nmcli con modify $WIFI_NAME wifi-sec.key-mgmt wpa-psk
nmcli con modify $WIFI_NAME wifi-sec.psk "Cl0udC0mputin9PF3"
nmcli con up $WIFI_NAME


echo "Un redémarrage est recommandé"
echo
echo "END - Configure WiFi"
echo "--------------------"
