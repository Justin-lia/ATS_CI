#!/bin/bash

cd `dirname $0`/../
. "./conf.sh"
SetParams


dispUsage()
{
	echo "Usage: $CMDNAME [-L/F/T/I]" 1>&2
	echo "-L --- Display keepalive_drop_rule." 1>&2
	echo "-F --- Flash all keepalive_drop_rule." 1>&2
	echo "-T --- Add keepalive_drop_rule for TCP." 1>&2
	echo "-I --- Add keepalive_drop_rule for ICMP." 1>&2
}


dispRule()
{
	echo "==========IPv4==========" 1>&2
	iptables -t mangle -L -vnx
	echo "" 1>&2
	echo "==========IPv6==========" 1>&2
	ip6tables -t mangle -L -vnx
}


while getopts LFTI OPT
do
	case $OPT in
		"L" )	FLG_L="TRUE";;
		"F" )	FLG_F="TRUE";;
		"T" )	FLG_T="TRUE";;
		"I" )	FLG_I="TRUE";;
		* )	echo "ERROR: Invalid Argument."; dispUsage; exit 1;;
	esac
done


if [ $# -eq 0 ]; then
	echo "ERROR: No Argument."
	dispUsage
	exit 1
fi

if [ "$FLG_F" = "TRUE" ]; then
	iptables -t mangle -F
	ip6tables -t mangle -F
	exit 0
fi

if [ "$FLG_L" = "TRUE" ]; then
	dispRule
	exit 0
fi

if [ "$FLG_T" = "TRUE" ]; then
	iptables -t mangle -A POSTROUTING -o $MapIf_1 -p tcp -j DROP
	ip6tables -t mangle -A POSTROUTING -o $Interface_1 -p tcp -j DROP
fi

if [ "$FLG_I" = "TRUE" ]; then
	iptables -t mangle -A POSTROUTING -o $MapIf_1 -p icmp -j DROP
	ip6tables -t mangle -A POSTROUTING -o $Interface_1 -p icmp -j DROP
fi


