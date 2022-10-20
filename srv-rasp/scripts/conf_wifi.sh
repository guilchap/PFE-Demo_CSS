#!/bin/bash

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE_WIFI="/vagrant/logs/conf_wifi.log"

INT_NAME="wlan0"
WIFI_NAME="CSS-HOTSPOT"

echo "----------------------"
echo "START - Configure WiFi"

echo "=> [1]: Installing required packages..."
apt-get update $APT_OPT \
    >> $LOG_FILE_WIFI 2>&1
apt-get upgrade $APT_OPT \
    >> $LOG_FILE_WIFI 2>&1    

apt-get install \
    network-manager \
    >> $LOG_FILE_WIFI 2>&1
systemctl start NetworkManager.service 
systemctl enable NetworkManager.service


echo "=> [2]: Configure interface wlan"
echo "# interface wlan0" >> /etc/dhcpd.conf
echo "interface wlan0" >> /etc/dhcpd.conf
echo -e "  static ip_address=192.168.25.1/24\n" >> /etc/dhcpd.conf
service dhcpcd restart

echo "=> [3]: Configure DNS"
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.old
echo "interface=wlan0" >> /etc/dnsmasq.conf
echo "dhcp-range=192.168.25.10,192.168.25.20,255.255.255.0,24h" >> /etc/dnsmasq.conf

echo "=> [4]: Configure Hotspot"
nmcli con add type wifi ifname $INT_NAME con-name $WIFI_NAME autoconnect yes ssid $WIFI_NAME
nmcli con modify $WIFI_NAME 802-11-wireless.mode ap 802-11-wireless.band bg ipv4.method shared
nmcli con modify $WIFI_NAME wifi-sec.key-mgmt wpa-psk
mcli con modify $WIFI_NAME wifi-sec.psk "Cl0udC0mputin9PF3"
mcli con up $WIFI_NAME

echo -e "Un redémarrage est recommandé\n"
echo "END - Configure WiFi"
echo "--------------------"
