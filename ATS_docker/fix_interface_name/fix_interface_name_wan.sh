#!/bin/bash

source /workspace/tests/config.sh

IFACE1=$(ip -o link show | grep "${env_wan_back_mac}" | awk -F': ' '{print $2}' | cut -d '@' -f1)
IFACE2=$(ip -o link show | grep "${env_wan_wan_mac}" | awk -F': ' '{print $2}' | cut -d '@' -f1)

echo $IFACE1
ip link set $IFACE1 down
ip link set $IFACE1 name eth-back
ip link set eth-back up

echo $IFACE2
ip link set $IFACE2 down
ip link set $IFACE2 name eth-wan
ip link set eth-wan up

exec "$@"
