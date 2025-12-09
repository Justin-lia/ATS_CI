#!/bin/bash

#
# Include files
#

. "./sub_routine.sh"

MysetupIF()
{
	extractServerLocal
	#setupInterfaces_vlan_sub


	if [ $ServiceType = "v6Plus" ]; then
		setupInterfaces_MapE_sub "v6plus" "$NumberOfCE"
	elif [ $ServiceType = "IPv6Option" ]; then
		setupInterfaces_MapE_sub "ipv6opt" "$NumberOfCE"
	elif [ $ServiceType = "OCN-VC" ]; then
		setupInterfaces_MapE_sub "ocnvc" "$NumberOfCE"
	elif [ $ServiceType = "transix" ]; then
		Srvv6=$GlobalMapEv6_transix
		SrvPrefix_1=$SrvPrefix_transix
		DutPrefix_1=$DutPrefix_transix
		if [ $IPv6PrefixMode = "Native" ]; then
			DutMapEv6_1=$DutMapEv6_transix_NT
		elif [ $IPv6PrefixMode = "PassThrough" ]; then
			DutMapEv6_1=$DutMapEv6_transix_ND
		fi
	elif [ $ServiceType = "NGN" ]; then
		Srvv6=$GlobalMapEv6_NGN
		SrvPrefix_1=$SrvPrefix_NGN
		DutPrefix_1=$DutPrefix_NGN
	elif [ $ServiceType = "xpass" ]; then
		Srvv6=$GlobalMapEv6_xpass
		SrvPrefix_1=$SrvPrefix_xpass
		DutPrefix_1=$DutPrefix_xpass
		if [ $IPv6PrefixMode = "Native" ]; then
			DutMapEv6_1=$DutMapEv6_xpass_NT
		elif [ $IPv6PrefixMode = "PassThrough" ]; then
			DutMapEv6_1=$DutMapEv6_xpass_ND
		fi
	elif [ $ServiceType = "v6Connect" ]; then
		Srvv6=$GlobalMapEv6_v6Connect
		SrvPrefix_1=$SrvPrefix_v6Connect
		DutPrefix_1=$DutPrefix_v6Connect
		if [ $IPv6PrefixMode = "Native" ]; then
			DutMapEv6_1=$DutMapEv6_v6Connect_NT
		elif [ $IPv6PrefixMode = "PassThrough" ]; then
			DutMapEv6_1=$DutMapEv6_v6Connect_ND
		fi
	elif [ $ServiceType = "NoIPv6" ]; then
		Srvv6=$Dummyv6
	else
		echo "ERROR: Unknown ServiceType:$ServiceType"
		exit -1
	fi


	if [ "$FLG_MAPE" = "TRUE" ]; then
		setupInterfaces_sub 1
		if [ $NumberOfCE -eq 2 ]; then
			setupInterfaces_sub 2
		fi
	elif [ $ServiceType = "transix" ]; then
		setupInterfaces_sub transix
	elif [ $ServiceType = "xpass" ]; then
		setupInterfaces_sub xpass
	elif [ $ServiceType = "v6Connect" ]; then
		setupInterfaces_sub v6Connect
	elif [ $ServiceType = "NGN" ]; then
		setupInterfaces_sub NGN
	fi

}

#
# Main
#

echo ====================
echo "Check Arguments."
echo ====================

checkArgs "$@"

echo ====================
echo "Setup interfaces."
echo ====================

#setupInterfaces
MysetupIF

#killall radvd 2> /dev/null
#killall dhcpd 2> /dev/null

echo ====================
echo "Setup DHCP/RA(IPv6) server."
echo ====================

setupDhcpd6

echo ====================
echo "Setup finished."
echo ====================


