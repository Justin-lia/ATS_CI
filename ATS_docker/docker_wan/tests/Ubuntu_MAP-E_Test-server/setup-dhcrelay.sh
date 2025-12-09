#!/bin/bash

IPv4_DHCPv4_RelayAgent=11.0.0.200
IPv4_DHCPv4_CE_NetAddr=11.0.2.0/24
LOWER_DEV=enp0s8

ip route add $IPv4_DHCPv4_CE_NetAddr scope global \
	via $IPv4_DHCPv4_RelayAgent dev $LOWER_DEV

