#!/bin/bash

CITY="Dijon"

echo "-------------------------"
echo "START - Configure Netdata"

sh /home/pi$CITY/PFE-Demo_CSS/raspberry/data/netdata-kickstart.sh

echo
echo "END - Configure Netdata"
echo "-----------------------"