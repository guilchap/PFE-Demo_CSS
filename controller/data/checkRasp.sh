#!/bin/bash
ping 192.168.25.2 -c 4 >> /vagrant/logs/output_ping_angers.log && ping 192.168.25.3 -c 4 >> /vagrant/logs/output_ping_dijon.log && whoami