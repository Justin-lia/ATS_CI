# ---------------------------------------------------------
# Parameters for IPv6 Option
# ---------------------------------------------------------

Get_SrvPrefix48_ipv6opt()
{
	if [ "$1" != "18" ] && [ "$1" != "19" ] && [ "$1" != "20" ] && [ "$1" != "21" ] && [ "$1" != "22" ] && [ "$1" != "24" ]; then
		echo "ERROR: Invalid EA-length for IPv6-Option:$1"
		exit -1
	fi

	local SrvPrefix48_ipv6opt_ea18=2404:7a82:800
	local SrvPrefix48_ipv6opt_ea19=2404:7a82:0
	local SrvPrefix48_ipv6opt_ea20=2404:7a82:a000
	local SrvPrefix48_ipv6opt_ea21=2404:7a82:2000
	local SrvPrefix48_ipv6opt_ea22=2404:7a86:0

	local SrvPrefix48_ipv6opt_ea24=2404:7a80:0
	
	local str="SrvPrefix48_ipv6opt_ea$1"
	eval echo '$'$str
}


Get_DutMapEv4_ipv6opt()
{
	if [ "$1" != "18" ] && [ "$1" != "19" ] && [ "$1" != "20" ] && [ "$1" != "21" ] && [ "$1" != "22" ] && [ "$1" != "24" ]; then
		echo "ERROR: Invalid EA-length for IPv6-Option:$1"
		exit -1
	fi

	local DutMapEv4_ipv6opt_ea18=125.198.140.0	#7d.c6.8c.00
	local DutMapEv4_ipv6opt_ea19=125.196.208.0	#7d.c4.d0.00
	local DutMapEv4_ipv6opt_ea20=125.194.192.0	#7d.c2.c0.00
	local DutMapEv4_ipv6opt_ea21=133.203.160.0	#85.cb.a0.00
	local DutMapEv4_ipv6opt_ea22=133.204.128.0	#85.cc.80.00

	local DutMapEv4_ipv6opt_ea24=133.200.0.0	#85.c8.00.00
	
	local str="DutMapEv4_ipv6opt_ea$1"
	eval echo '$'$str
}


Get_DutMapEv6_SN_ipv6opt()
{
	if [ "$1" != "18" ] && [ "$1" != "19" ] && [ "$1" != "20" ] && [ "$1" != "21" ] && [ "$1" != "22" ] && [ "$1" != "24" ]; then
		echo "ERROR: Invalid EA-length for IPv6-Option:$1"
		exit -1
	fi

	local DutMapEv6_SN_ipv6opt_ea18=7d:c68c:0
	local DutMapEv6_SN_ipv6opt_ea19=7d:c4d0:0
	local DutMapEv6_SN_ipv6opt_ea20=7d:c2c0:0
	local DutMapEv6_SN_ipv6opt_ea21=85:cba0:0
	local DutMapEv6_SN_ipv6opt_ea22=85:cc80:0

	local DutMapEv6_SN_ipv6opt_ea24=85:c800:0
	
	local str="DutMapEv6_SN_ipv6opt_ea$1"
	eval echo '$'$str
}


