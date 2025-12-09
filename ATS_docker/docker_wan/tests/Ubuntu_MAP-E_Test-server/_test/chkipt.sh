#!/bin/bash


while :
do
	echo ============================================================
	#iptables -L -vnx -t mangle | grep -e 65535 -e 65530
	#iptables -L -vnx -t mangle
	iptables -L -vnx -t nat
	iptables -L -vnx -t filter
	sleep 1
done



