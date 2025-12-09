#!/bin/bash

__CTL_NET_IFACE=enp0s3
__CTL_NET_PREFIX=192.168.56
__CTL_NET=$(ip -4 addr show dev $__CTL_NET_IFACE | grep $__CTL_NET_PREFIX | awk '{print $2}')

#
# Include files
#

. "./sub_routine.sh"


#
# Main
#

echo ====================
echo "Check Arguments."
echo ====================

checkArgs "$@"


echo ====================
echo "Check Config."
echo ====================

checkConfig


echo ====================
echo "Stop current daemons."
echo ====================

stopDaemons


echo ====================
echo "Setup interfaces."
echo ====================

setupInterfaces


echo ====================
echo "Setup NAT."
echo ====================

setupNat


echo ====================
echo "Setup DNS."
echo ====================

setupDns


echo ====================
echo "Setup DHCP/RA(IPv6) server."
echo ====================

setupDhcpd6


echo ====================
echo "Setup HTTP server."
echo ====================

setupHttps


echo ====================
echo "Setup PPPoE server."
echo ====================

setupPppoes


echo ====================
echo "Setup DHCPv4 server."
echo ====================

setupDhcpd4


echo ====================
echo "Setup finished."
echo ====================

setupFinMsg

ip link set dev $__CTL_NET_IFACE down

#ip route add $__CTL_NET dev $__CTL_NET_IFACE
ip addr add $__CTL_NET dev $__CTL_NET_IFACE

ip link set dev $__CTL_NET_IFACE up
