#!/bin/bash

APT_OPT='-o Dpkg::Progress-Fancy="0" -q -y'
LOG_FILE_WIFI="/var/log/conf_wifi.log"

INT_NAME="wlan0"
INT_NAME_INT="eth0"
WIFI_NAME="CSS-HOTSPOT"
IP_ADDRESS="192.168.25.1/24"
DHCP_START="192.168.25.10"
DHCP_END="192.168.25.254"
DHCP_MASK="255.255.255.0"
DHCP_LENGTH="24h"

echo "-------------------------------------------"
echo "START - Configure WiFi with internet shared"

echo "=> [1]: Installing required packages..."
apt-get install -y \
    dnsmasq \
    hostapd \
    >> $LOG_FILE_WIFI 2>&1

echo "=> [2]: Configure DHCP"
echo "interface=$INT_NAME" >> /etc/dnsmasq.conf 
echo "dhcp-range=$DHCP_START,$DHCP_END,$DHCP_MASK,$DHCP_LENGTH" >> /etc/dnsmasq.conf

echo "=> [3]: Configure Hotspot"
cat << EOF > /etc/hostapd/hostapd.conf
interface=$INT_NAME
driver=nl80211
ssid=$WIFI_NAME
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=Cl0udC0mputin9PF3
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
EOF

sed -i 's/^#DAEMON_CONF=.*/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/' /etc/default/hostapd

echo "=> [4]: Configure IP forwarding"
sudo sed -i '/net.ipv4.ip_forward=1/s/^#//g' /etc/sysctl.conf
sysctl -p

sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

echo "=> [5]: Configure traffic rules"
iptables -t nat -A POSTROUTING -o $INT_NAME_INT -j MASQUERADE
iptables -A FORWARD -i $INT_NAME_INT -o $INT_NAME -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $INT_NAME -o $INT_NAME_INT -j ACCEPT

sh -c "iptables-save > /etc/iptables.ipv4.nat"

echo "=> [6]: Start services"
service hostapd start
systemctl enable dnsmasq
service dnsmasq start
systemctl enable hostapd


echo "Un redémarrage est recommandé"
echo
echo "END - Configure WiFi with internet shared"
echo "-----------------------------------------"
