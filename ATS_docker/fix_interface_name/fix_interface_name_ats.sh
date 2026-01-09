#!/bin/bash

source /workspace/tests/config.sh

IFACE1=$(ip -o link show | grep "${env_ats_back_mac}" | awk -F': ' '{print $2}' | cut -d '@' -f1)
IFACE2=$(ip -o link show | grep "${env_ats_lan_mac}" | awk -F': ' '{print $2}' | cut -d '@' -f1)
IFACE3=$(ip -o link show | grep "${env_ats_inet_mac}" | awk -F': ' '{print $2}' | cut -d '@' -f1)

echo $IFACE1
ip link set $IFACE1 down
ip link set $IFACE1 name eth-back
ip link set eth-back up

echo $IFACE2
ip link set $IFACE2 down
ip link set $IFACE2 name eth-lan
ip link set eth-lan up

echo $IFACE3
ip link set $IFACE3 down
ip link set $IFACE3 name eth-inet
ip link set eth-inet up


ip add flush eth-inet
dhclient eth-inet

exec "$@"
