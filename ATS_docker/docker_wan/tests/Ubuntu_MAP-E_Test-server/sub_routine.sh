#
# Global Parameters.
#

if [ ! -f ./conf.sh ]; then
	echo "Error: couldn't ./conf.sh"
	exit 1
fi

. "./conf.sh"

SetParams


#
# Sub routine.
#

checkMkdir ()
{
	if [ ! -e $1 ]; then
		mkdir -p $1
	fi
}


dispUsage()
{
	echo "Usage: $CMDNAME [-p] [[-P [-l<num>]]/-a] [-D] [-B/J/O/T/N/X/U/A/C] [-c/s] [-h] [-e] [-d] [-u] [-Fxxx] [-x/n] [-t] [--NoPrefixAvail] [--rapid-commit] [--native-and-passthrough] [--iana-address]"
	echo "p --- For testing \"Passthrough mode\". Works as \"Native mode (DHCPv6)\" when it's not set."
	echo "l --- Preferred lifetime for \"Passthrough mode\" only."
	echo "B --- For testing \"Biglobe IPv6Option\"."
	echo "J --- For testing \"JPNE v6Plus\"."
	echo "O --- For testing \"OCN VirtualConnect\"."
	echo "T --- For testing \"IIJ transix\"."
	echo "N --- For testing \"NGN Closed Network\"."
	echo "X --- For testing \"ARTERIA xpass\"."
	echo "U --- For testing \"Unique Local prefix\"."
	echo "A \"<opts>[,ttl=<ttl>]\" --- For testing \"Asahi-net v6Connect\"."
	echo "      opts: ipip and/or dslite, or NONE. If IPIP and DS-Lite then \"ipip,dslite\""
	echo "R \"<opts>[,ttl=<ttl>]\" --- For testing \"Rakuten-mobile\"."
	echo "      opts: dslite or NONE."
	echo "C --- For testing \"CATV Network\"."
	echo "  **NOTE** B/J/O/T/N/X/U/A/R options are cannot set concurrently. Works as NoIPv6 mode when it's not set."
	echo "c --- For testing Inter-CE communication (Different CE Addr). Works as Single CE mode when it's not set."
	echo "s --- For testing Inter-CE communication (Same CE Addr). Works as Single CE mode when it's not set."
	echo "P --- For testing PPPoE coexistence environment. Disabled when it's not set."
	echo "a --- For testing PPPoE->PPPoE+VNE environment switching."
	echo "D --- For testing DHCPv4 coexistence environment. Disabled when it's not set."
	echo "h --- For testing HGW mode which disables MAP-E connectivity in J/B mode. Disabled when it's not set."
	echo "e --- For enabling routing to External Network. Disabled when it's not set."
	echo "d --- For disabling IPv6 prefix noticed to DUT already."
	echo "u --- For updating alternative IPv6 prefix."
	echo "F --- For testing Fail case 403/404/500/200/307/0/9 (200:200ok address range invalid, 200-logic-invalid:200ok logic invalid, 0:empty_rule 9:no_response, 307:redirect_v6mig_prov_server)."
	echo "f --- For forcing generating new server certificate (enable this when A option is specified)."
	echo "x --- For testing Flet's Cross mode which disables RA packet sending (AdvSendAdvert is set to off). Disabled when it's not set."
	echo "n --- For testing Flet's Next mode which enables RA packet sending with prefix-info and other-flag option. Disabled when it's not set."
	echo "t --- For enabling routing to External Network and changing interface addresses. Disabled when it's not set."
	echo "r --- For enabling handover a DHCPv6 relases file."
	echo "--with-invalid-old-prefix --- For testing RA advertise of notification of new prefix validation and old prefix invalidation by RA."
	echo "--NoPrefixAvail           --- For testing DHCPv6 reply NoPrefixAvaild status code."
	echo "--rapid-commit            --- For testing DHCPv6 reply with rapid-commit."
	echo "--native-and-passthrough  --- For testing RA(PIO) and DHCPv6-PD envioroment."
	echo "--iana-address            --- For testing IA_NA adderss envioroment."
	echo "--no-reset-ip6tables      --- No reset ip6tables."
	echo "--help                    --- Show help."
}

checkConfig ()
{
	echo "DUT interface id1: $DutLocal_1"
	echo "DUT interface id2: $DutLocal_2"
	echo "DUT internet side's link local: $DutLinkLocal"
	#echo "Start server?(Y/n): "
	#echo -n "> "
	#read input
	#if [[ "$input" =~ [nN] ]]; then
	#	echo "please check \"conf.sh\"."
	#	exit 1
	#fi
}

checkArgs ()
{
	local CMDNAME=`basename $0`

	local cntc=0
	local cnta=0
	local cntx=0
	local cntn=0
	FLG_MAPE="FALSE"

	while getopts pl:tecsfrxnduDPaA:R:CUXNTJBOhF:v-: OPT
	do
		if [[ $OPT == - ]]; then
			OPT="${OPTARG%%=*}"
			OPTARG="${OPTARG/${OPT}/}"
			OPTARG="${OPTARG#=}"
		fi
		case $OPT in
			"p" )	local FLG_p="TRUE"; let ++cntx; let ++cntn;;
			"l" )	local FLG_l="TRUE"; local FLG_l_ARG="$OPTARG";;
			"t" )	local FLG_t="TRUE";;
			"e" )	local FLG_e="TRUE";;
			"c" )	local FLG_c="TRUE";;
			"s" )	local FLG_s="TRUE";;
			"f" )	local FLG_f="TRUE";;
			"r" )	local FLG_r="TRUE";;
			"d" )	local FLG_d="TRUE";;
			"u" )	local FLG_u="TRUE";;
			"x" )	local FLG_x="TRUE"; let ++cntx; let ++cntn;;
			"n" )	local FLG_n="TRUE"; let ++cntx; let ++cntn;;
			"D" )	local FLG_D="TRUE"; let ++cntc;;
			"P" )	local FLG_P="TRUE"; let ++cntc;;
			"a" )	local FLG_a="TRUE"; let ++cntc;;
			"A" )	local FLG_A="TRUE"; let ++cntc; let ++cnta; local FLG_A_ARG="$OPTARG";;
			"R" )	local FLG_R="TRUE"; let ++cntc; let ++cnta; local FLG_R_ARG="$OPTARG";;
  			"C" )	local FLG_C="TRUE"; let ++cntc; let ++cnta;;
			"U" )	local FLG_U="TRUE"; let ++cntc; let ++cnta;;
			"X" )	local FLG_X="TRUE"; let ++cntc; let ++cnta;;
  			"N" )	local FLG_N="TRUE"; let ++cntc; let ++cnta;;
			"T" )	local FLG_T="TRUE"; let ++cntc; let ++cnta;;
			"J" )	local FLG_J="TRUE"; let ++cntc; let ++cnta; FLG_MAPE="TRUE";;
			"B" )	local FLG_B="TRUE"; let ++cntc; let ++cnta; FLG_MAPE="TRUE";;
			"O" )	local FLG_O="TRUE"; let ++cntc; let ++cnta; FLG_MAPE="TRUE";;
			"h" )	local FLG_h="TRUE";;
			"F" )	local FLG_F="TRUE"; T_ERR_NO=$OPTARG;;
			"with-invalid-old-prefix" ) local FLG_WithInvalidOldPrefix="TRUE";;
			"NoPrefixAvail" )	local FLG_NoPrefixAvail="TRUE";;
			"rapid-commit" )	local FLG_rapid_commit="TRUE";;
			"native-and-passthrough" )	local FLG_nap="TRUE";;
			"iana-adderss" )	local FLG_iana_address="TRUE";;
			"no-reset-ip6tables" )	local FLG_no_reset_ip6tables="TRUE";;
			"help" )	dispUsage; exit 0;;
			* )	dispUsage; exit 1;;
		esac
	done

	#if [ $cntc -eq 0 ]; then
	#	echo "ERROR: At lease one Network Type ([-P] [-D] [-B/J/O/T/N]) should be selected."
	#	dispUsage; exit 1
	#fi


	## Select ServiceType.
	if [ $cnta -eq 0 ]; then
		ServiceType="NoIPv6"
		ServerDhcpv6DuidType="NoIPv6"
	elif [ $cnta -eq 1 ]; then
		ServerDhcpv6DuidType="LL"

		if [ "$FLG_B" = "TRUE" ]; then
			ServiceType="IPv6Option"
		elif [ "$FLG_J" = "TRUE" ]; then
			ServiceType="v6Plus"
		elif [ "$FLG_O" = "TRUE" ]; then
			ServiceType="OCN-VC"
		elif [ "$FLG_T" = "TRUE" ]; then
			ServiceType="transix"
		elif [ "$FLG_N" = "TRUE" ]; then
			ServiceType="NGN"
		elif [ "$FLG_X" = "TRUE" ]; then
			ServiceType="xpass"
		elif [ "$FLG_U" = "TRUE" ]; then
			ServiceType="NGN"
			SrvPrefix_NGN=$ULPrefix64
			DutPrefix_NGN=$ULPrefix64
		elif [ "$FLG_A" = "TRUE" ]; then
			ServiceType="v6Connect"
			ServiceOptions=($(echo "$FLG_A_ARG"|tr -s ',' ' '))
			if [[ ! "${ServiceOptions[@]}" =~ "ipip" ]] \
			&& [[ ! "${ServiceOptions[@]}" =~ "dslite" ]] \
			&& [[ ! "${ServiceOptions[@]}" =~ "NONE" ]]; then
				echo "ERROR: You must select opts: ipip and/or dslite, or NONE."
				exit 1
			fi
			if [[ "${ServiceOptions[@]}" =~ "NONE" ]]; then
				if [[ "${ServiceOptions[@]}" =~ "ipip" ]] \
				|| [[ "${ServiceOptions[@]}" =~ "dslite" ]]; then
					echo "ERROR: If you select NONE, then doesn't set other flags, exclude ttl."
					exit 1
				fi
			fi
			if [[ "${ServiceOptions[@]}" =~ ttl=([0-9]+) ]] \
			&& [ "${BASH_REMATCH[1]}" -gt 604800 ]; then
				echo "ERROR: Ttl is must equal less than 604800."
				exit 1
			fi
		elif [ "$FLG_R" = "TRUE" ]; then
			ServiceType="rakutenMobile"
			ServiceOptions=($(echo "$FLG_R_ARG"|tr -s ',' ' '))
			if [[ ! "${ServiceOptions[@]}" =~ "dslite" ]] \
			&& [[ ! "${ServiceOptions[@]}" =~ "NONE" ]]; then
				echo "ERROR: You must select opts: dslite or NONE."
				exit 1
			fi
			if [[ "${ServiceOptions[@]}" =~ "NONE" ]]; then
				if [[ "${ServiceOptions[@]}" =~ "dslite" ]]; then
					echo "ERROR: If you select NONE, then doesn't set other flags, exclude ttl."
					exit 1
				fi
			fi
			if [[ "${ServiceOptions[@]}" =~ ttl=([0-9]+) ]] \
			&& [ "${BASH_REMATCH[1]}" -gt 604800 ]; then
				echo "ERROR: Ttl is must equal less than 604800."
				exit 1
			fi
		elif [ "$FLG_C" = "TRUE" ]; then
			ServiceType="CATV"
			ServerDhcpv6DuidType="LLT"
		fi

		ServerRadvdInvalidOldPrefix="FALSE"
		if [ "$FLG_WithInvalidOldPrefix" = "TRUE" ]; then
			ServerRadvdInvalidOldPrefix="TRUE"
		fi
		ServerDhcpv6NoPrefixAvail="FALSE"
		if [ "$FLG_NoPrefixAvail" = "TRUE" ]; then
			ServerDhcpv6NoPrefixAvail="TRUE"
		fi
		ServerDhcpv6RapidCommit="FALSE"
		if [ "$FLG_rapid_commit" = "TRUE" ]; then
			ServerDhcpv6RapidCommit="TRUE"
		fi

		NativeAndPassthrough="FALSE"
		if [ "$FLG_nap" = "TRUE" ]; then
			NativeAndPassthrough="TRUE"
		fi

		Dhcpv6IA_NAAddress="Disabled"
		if [ "$FLG_iana_address" = "TRUE" ]; then
			Dhcpv6IA_NAAddress="Enabled"
		fi

		NoResetIp6tables="FALSE"
		if [ "$FLG_no_reset_ip6tables" = "TRUE" ]; then
			NoResetIp6tables="TRUE"
		fi
	else
		echo "ERROR: IPv6 services cannot be selected multipully."
		dispUsage; exit 1
	fi
	echo "--- Service Type: $ServiceType"
	if [ ! -z "$ServiceOptions" ]; then
		echo "--- Service Options: $(IFS=',';echo "${ServiceOptions[*]}")"
	fi
	echo "--- Server Radvd with invalid old prefix: $ServerRadvdInvalidOldPrefix"
	echo "--- Server DHCPv6 DUID Type: $ServerDhcpv6DuidType"
	echo "--- Server DHCPv6 NoPrefixAvail: $ServerDhcpv6NoPrefixAvail"
	echo "--- Server DHCPv6 Rapid Commit: $ServerDhcpv6RapidCommit"


	## Select HGW Mode.
	if [ "$FLG_h" = "TRUE" ]; then
		if [ "$ServiceType" = "v6Plus" ] || [ "$ServiceType" = "IPv6Option" ] \
		|| [[ "$ServiceType" = "v6Connect" && "${ServiceOptions[0]}" = "dslite" ]] \
		|| [[ "$ServiceType" = "rakutenMobile" && "${ServiceOptions[0]}" = "dslite" ]]; then
			HGWMode="Enabled"
		else
			echo "ERROR: HGW mode cannot be selected without v6Plus or IPv6Option or v6Connect."
			dispUsage; exit 1
		fi
	else
		HGWMode="Disabled"
	fi
	echo "--- HGW Mode: $HGWMode"

	echo "--- NativeAndPassthrough Mode: $NativeAndPassthrough"

	## Select IPv6 Prefix Mode.
	if [ $cntx -ge 2 ]; then
		echo "ERROR: FletsCrossMode mode cannot be selected with PassThrough or FletsNext mode."
		dispUsage; exit 1
	elif [ $cntn -ge 2 ]; then
		echo "ERROR: FletsNextMode mode cannot be selected with PassThrough or FletsCross mode."
		dispUsage; exit 1
	elif [ $ServiceType != "NoIPv6" ]; then
		if [ "$FLG_p" = "TRUE" ]; then
			IPv6PrefixMode="PassThrough"
		else
			IPv6PrefixMode="Native"
			## Select Flets-Cross Mode.
			if [ "$FLG_x" = "TRUE" ]; then
				FletsCrossMode="Enabled"
			else
				FletsCrossMode="Disabled"
			fi
			if [ "$FLG_n" = "TRUE" ]; then
				FletsNextMode="Enabled"
			else
				FletsNextMode="Disabled"
			fi
		fi
		if [ "$FLG_p" = "TRUE" ]; then
			AdvPreferredLifetime="$FLG_l_ARG"
		fi
	fi
	echo "--- IPv6 Prefix Mode: $IPv6PrefixMode"
	echo "--- Flets-Next  Mode: $FletsNextMode"
	echo "--- Flets-Cross Mode: $FletsCrossMode"


	## Set Number of CE.
	if [ "$FLG_MAPE" = "TRUE" ]; then
		if [ "$FLG_c" = "TRUE" ] && [ "$FLG_s" = "TRUE" ]; then
			echo "ERROR: \"-c\" and \"-s\" option cannot be selected at the same time."
			dispUsage; exit 1
		elif [ "$FLG_c" = "TRUE" ]; then
			NumberOfCE=2
			CEMode="Different"
		elif [ "$FLG_s" = "TRUE" ]; then
			NumberOfCE=2
			CEMode="Same"
		fi
	fi
	echo "--- Number of CE: $NumberOfCE"
	echo "--- CEMode: $CEMode"

	PrefixDisabling=FALSE
	if [ "$FLG_d" = "TRUE" ]; then
		PrefixDisabling=TRUE
	fi
	PrefixUpdating=FALSE
	if [ "$FLG_u" = "TRUE" ]; then
		if [ "$FLG_MAPE" != "TRUE" ] && [ "$ServiceType" != "v6Connect" ]; then
			echo "ERROR: \"-B/J/O\" or \"-A\" option must be selected at the same time."
			dispUsage; exit 1
		fi
		PrefixUpdating=TRUE
	fi
	echo "--- PrefixDisabling: $PrefixDisabling"
	echo "--- PrefixUpdating: $PrefixUpdating"

	## Select DHCPv4 Coexistence Mode.
	if [ "$FLG_D" = "TRUE" ]; then
		DHCPv4ServerMode="Enabled"
	else
		DHCPv4ServerMode="Disabled"
	fi
	echo "--- DHCPv4-server: $DHCPv4ServerMode"


	## Select PPPoE Coexistence Mode.
	PPPoEServerNotRestart="FALSE"
	if [ "$FLG_P" = "TRUE" ] || [ "$FLG_a" = "TRUE" ]; then
		PPPoEServerMode="Enabled"
		if [ "$FLG_a" = "TRUE" ]; then
			if [ "" = "$(ps aux|grep [p]ppoe-server)" ]; then
				echo "'-a' option, need to pppoe-server running."
				exit 1
			fi
			PPPoEServerNotRestart="TRUE"
		fi
	else
		PPPoEServerMode="Disabled"
	fi
	echo "--- PPPoE-server: $PPPoEServerMode"

	## Select External Mode.
	if [ "$FLG_e" = "TRUE" ] || [ "$FLG_t" = "TRUE" ] ; then
		ExternalMode="Enabled"
		if [ $NtpDomains = "Enabled" ]; then
			echo "Warning: Running NTPD in external network."
		fi
	else
		ExternalMode="Disabled"
	fi
	echo "--- External Network: $ExternalMode"

	## Select Throughput Measure Mode.
	if [ "$FLG_t" = "TRUE" ] ; then
		MeasureMode="Enabled"
		#DefaultGW_v4=$DefaultGW_v4_2
		DefaultGW_v4=$DefaultGW_v4
		DefaultRoute_v4=$DefaultRoute_v4
		#Resolved_v4=$Resolved_v4_2
		Resolved_v4=$Resolved_v4
	else
		MeasureMode="Disabled"
	fi
	echo "--- Throughput Measure: $MeasureMode"

	## Select Server Certificate Generating Mode.
	if [ "$FLG_f" = "TRUE" ] ; then
		ServCertGenMode="Force"
	else
		ServCertGenMode="Once"
	fi
	echo "--- Server Certificate Genarating: $ServCertGenMode"

	## Select DHCPv6 Leases File Handover Mode.
	if [ "$FLG_r" = "TRUE" ] ; then
		Dhcpv6LeasesHandoverMode="Enabled"
	else
		Dhcpv6LeasesHandoverMode="Disabled"
	fi
	echo "--- DHCPv6 Leases File Handover: $Dhcpv6LeasesHandoverMode"

	## ERR code
	ERR_NO="-1"
	if [ "$FLG_F" = "TRUE" ]; then
		if [ "" != "$T_ERR_NO" ] && [[ "307 403 404 500 200 200-logic-invalid 0 9" =~ "$T_ERR_NO" ]]; then
			ERR_NO=$T_ERR_NO
		else
			echo "ERROR: Error Code is unkown."
			dispUsage; exit 1
		fi
		echo "--Error Code: $ERR_NO"
	fi
}


stopDaemons()
{
	killall NetworkManager 2> /dev/null
	killall networkd 2> /dev/null
	killall systemd-networkd 2> /dev/null
	killall dhclient 2> /dev/null
	killall dnsmasq 2> /dev/null

	killall radvd 2> /dev/null
	killall dhcpd 2> /dev/null
	killall lighttpd 2> /dev/null
	killall named 2> /dev/null
	if [ "FALSE" = "$PPPoEServerNotRestart" ]; then
		killall pppoe-server 2> /dev/null
	fi

	ip -6 tunnel del $IpipIf_1 2> /dev/null
	ip -6 tunnel del $DslIf_1 2> /dev/null
	ip -6 tunnel del $MapIf_1 2> /dev/null
	ip -6 tunnel del $MapIf_2 2> /dev/null
	ip addr flush dev $Interface_1 2> /dev/null
	ip addr flush dev $Interface_2 2> /dev/null
	#ip addr flush dev $Interface_LAN 2> /dev/null
	ip addr flush dev $Interface_DGW 2> /dev/null

	iptables -t filter -F
	iptables -t nat -F
	iptables -t mangle -F

	if [ "$NoResetIp6tables" != "TRUE" ]; then
		ip6tables -t filter -F
		ip6tables -t nat -F
		ip6tables -t mangle -F
	fi

	ip rule flush
	ip rule del from all lookup local
	ip rule restore < ./ip.rule.def.bin

	PPP_ROUTE_CACHE=$(ip route|grep ppp) #backup ppp routing

	ip route flush table 1 2> /dev/null
	ip route flush table 2 2> /dev/null
	ip route flush cache
	ip route flush table main
	ip -6 route flush table 1 2> /dev/null
	ip -6 route flush table 2 2> /dev/null
	ip -6 route flush cache
	ip -6 route flush table main

	if [ "TRUE" = $PPPoEServerNotRestart ]; then
		if [ "$PPP_ROUTE_CACHE" != "" ]; then
			#recover ppp routing
			eval "ip route add $PPP_ROUTE_CACHE"
		fi
	fi

	rm -rf /var/www/*
	if [ "/" != `realpath -m "$DnsDir/"` ]; then
		rm -rf $DnsDir/*
	else
		echo "warning! avoid removing '/*'"
	fi

	cp -f ./dns/resolv_init.conf /run/resolvconf
}


linkUpInterfaces_sub()
{
	local Intf=$1
	ip link set $Intf down
	ip link set $Intf up
}


linkUpInterfaces()
{
	linkUpInterfaces_sub $Interface_1
	if [ $NumberOfCE -eq 2 ]; then
		linkUpInterfaces_sub $Interface_2
	fi
	if [ $ExternalMode = "Enabled" ]; then
		linkUpInterfaces_sub $Interface_DGW
	fi
}


extractServerLocal_sub()
{
	if [ $# -eq 2 ]; then
		local Intf=$1
		local SrvSuf=$2
	else
		echo "ERROR: Incorrect usage at "${FUNCNAME[0]}
		exit 1
	fi

	local cnt=0
	local flg=0
	while [ $cnt -lt 5 ]
	do
		echo "$cnt sec"
		cnt=$(expr $cnt + 1)
		sleep 1
		ip -6 addr show dev $Intf | grep "fe80::" > /dev/null
		if [ $? = "0" ]; then
			flg=1
			break
		fi
	done

	if [ $flg -eq 1 ]; then
		local LLA=$(ip -6 addr show dev $Intf | sed -e "s/^.*inet6 \([^ ]*\)\/.*$/\1/;t;d" | grep "fe80")
		echo LLA---$LLA
		local SUF=$(echo $LLA | sed -e "s/^.*fe80:://")
		echo SUF---$SUF
		eval $SrvSuf=$SUF
		eval echo $SrvSuf---'$'$SrvSuf
		echo "--- IPv6 LinkLocal is existing in $Intf."
	else
		eval ip addr add fe80::'$'$SrvSuf/64 dev $Intf
		echo "--- IPv6 LinkLocal is not existing in $Intf."
		eval echo --- Added fe80::'$'$SrvSuf
	fi
}


extractServerLocal()
{
	extractServerLocal_sub $Interface_1 "SrvLocal_1"
	if [ $NumberOfCE -eq 2 ]; then
		extractServerLocal_sub $Interface_2 "SrvLocal_2"
	fi
	if [ $ExternalMode = "Enabled" ]; then
		extractServerLocal_sub $Interface_DGW "SrvLocal_DGW"
	fi
}


setupInterfaces_vlan_sub()
{
	ip link add link $Interface_LAN name $Interface_1 type vlan id 1
	ip link add link $Interface_LAN name $Interface_2 type vlan id 2
}


setupInterfaces_sub()
{
	if [ $1 = "1" ] || [ "$1" = "transix" ] || [ "$1" = "NGN" ] || [ "$1" = "CATV" ] || [ "$1" = "xpass" ] || [ "$1" = "v6Connect" ]; then
		echo "Settings for Interface_1"
		local Interface=$Interface_1
		local SrvLocal=$SrvLocal_1
		local SrvPrefix=$SrvPrefix_1
		local DutLocal=$DutLocal_1
		local DutPrefix=$DutPrefix_1
		local Dutv6=$DutMapEv6_1

		if [ "$1" = "transix" ]; then
			local Dutv4=(${DutTransixv4_1[@]})
			local TunnelIf=$DslIf_1
		elif [ "$1" = "xpass" ]; then
			local Dutv4=(${DutXpassv4_1[@]})
			local TunnelIf=$DslIf_1
		elif [ "$1" = "v6Connect" ]; then
			if [ "${ServiceOptions[0]}" = "ipip" ]; then
				local Dutv4=(${DutV6Connect_Ipip_v4_1[@]})
				local TunnelIf=$IpipIf_1
			elif [ "${ServiceOptions[0]}" = "dslite" ]; then
				local Dutv4=(${DutV6Connect_Dslite_v4_1[@]})
				local TunnelIf=$DslIf_1
			fi
		else
			local Dutv4=$DutMapEv4_1
			local TunnelIf=$MapIf_1
		fi

	elif [ $1 = "2" ]; then
		echo "Settings for Interface_2"
		local Interface=$Interface_2
		local SrvLocal=$SrvLocal_2
		local SrvPrefix=$SrvPrefix_2
		local DutLocal=$DutLocal_2
		local DutPrefix=$DutPrefix_2
		local Dutv4=$DutMapEv4_2
		local Dutv6=$DutMapEv6_2
		local TunnelIf=$MapIf_2
	else
		echo "ERROR: Invalid parameter:$1"
		exit -1
	fi

	ip addr add $SrvPrefix:$SrvLocal/64 dev $Interface

	if [ "$DutLinkLocal" = "" ]; then
		local DutLinkLocal="$DutLocal"
	fi

	ip -6 route add $SrvPrefix::/64 via fe80::$DutLinkLocal dev $Interface
	#ip -6 route add $DutPrefix::/56 via fe80::$DutLinkLocal dev $Interface
	ip -6 route add $DutPrefix:$DutLocal via fe80::$DutLinkLocal dev $Interface #debug utm
	ip -6 route add $DutPrefix:28ce:30ff:fea5:9cb3 dev $Interface #debug utm
	#ip -6 route add $DutPrefix::/64 dev $Interface #debug utm
	ip -6 route add $DutPrefix::/56 via fe80::$DutLinkLocal dev $Interface #debug 6000
	#ip -6 route add $DutPrefix::/64 via fe80::$DutLinkLocal dev $Interface #debug 6000
	#ip -6 route add $DutPrefix::/48 via fe80::$DutLinkLocal dev $Interface

	for tif in "${TunnelIf[@]}"; do
	if [ "$1" != "NGN" ] && [ "$1" != "CATV" ]; then
		if [ "$1" = "transix" ] || [ "$1" = "xpass" ] || [ "$1" = "v6Connect" ]; then
			echo ip -6 tunnel add $tif mode ipip6 local $Srvv6 remote $Dutv6 dev $Interface encaplimit none
			ip -6 tunnel add $tif mode ipip6 local $Srvv6 remote $Dutv6 dev $Interface encaplimit none
			ip link set $tif up
			for var in ${Dutv4[@]}
			do
				echo $var
				ip route add $var dev $tif
			done
			#AOSS2中は172.x.x.xのアドレスがWANに転送されることを考慮
			ip route add 172.0.0.0/8 dev $tif
		else
			echo ip -6 tunnel add $tif mode ipip6 local $Srvv6 remote $Dutv6 dev $Interface encaplimit none
			ip -6 tunnel add $tif mode ipip6 local $Srvv6 remote $Dutv6 dev $Interface encaplimit none
			ip link set $tif up
			ip route add $Dutv4/32 dev $tif
		fi
	fi
	done
}


setupInterfaces_MapE_sub()
{
	if [ $# -eq 2 ]; then
		local Srvc=$1
		local CeNum=$2
	else
		echo "ERROR: Incorrect usage at "${FUNCNAME[0]}
		exit 1
	fi

	if [ $IPv6PrefixMode = "Native" ]; then
		local PfMode="NT"
		if [ $FletsNextMode = "Enabled" ]; then
			local PfMode="ND"
		fi
	elif [ $IPv6PrefixMode = "PassThrough" ]; then
		local PfMode="ND"
	fi

	eval Srvv6='$'GlobalMapEv6_$Srvc
	eval SrvPrefix_1='$'SrvPrefix_$Srvc"_1"
	#eval DutPrefix_1='$'DutPrefix_$Srvc"_1"
	if [ $PfMode = "NT" ]; then
		eval DutPrefix_1='$'DutPrefix_$Srvc"_1"
	elif [ $PfMode = "ND" ]; then
		eval DutPrefix_1='$'SrvPrefix_$Srvc"_1"
	fi
	eval DutMapEv6_1='$'DutMapEv6_$Srvc"_"$PfMode"_1"
	eval DutMapEv4_1='$'DutMapEv4_$Srvc"_1"
	if [ $CeNum = "2" ]; then
		eval SrvPrefix_2='$'SrvPrefix_$Srvc"_2"
		#eval DutPrefix_2='$'DutPrefix_$Srvc"_2"
		if [ $PfMode = "NT" ]; then
			eval DutPrefix_2='$'DutPrefix_$Srvc"_2"
		elif [ $PfMode = "ND" ]; then
			eval DutPrefix_2='$'SrvPrefix_$Srvc"_2"
		fi
		eval DutMapEv6_2='$'DutMapEv6_$Srvc"_"$PfMode"_2"
		eval DutMapEv4_2='$'DutMapEv4_$Srvc"_2"
	fi
	if [ "$PrefixUpdating" = "TRUE" ]; then
		echo "updating prefix (mape dut1), not (mape dut2)"
		eval SrvPrefix_1='$'SrvPrefix_$Srvc"_1_alt"
		#eval DutPrefix_1='$'DutPrefix_$Srvc"_1_alt"
		if [ $PfMode = "NT" ]; then
			eval DutPrefix_1='$'DutPrefix_$Srvc"_1_alt"
		elif [ $PfMode = "ND" ]; then
			eval DutPrefix_1='$'SrvPrefix_$Srvc"_1_alt"
		fi
		eval DutMapEv6_1='$'DutMapEv6_$Srvc"_"$PfMode"_1_alt"
	fi
}


setupInterfaces()
{
	linkUpInterfaces
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
	elif [ $ServiceType = "CATV" ]; then
		Srvv6=$GlobalMapEv6_CATV
		SrvPrefix_1=$SrvPrefix_CATV
		DutPrefix_1=$DutPrefix_CATV
		DutPrefixEnd_1=$DutPrefixEnd_CATV
	elif [ $ServiceType = "xpass" ]; then
		Srvv6=$GlobalMapEv6_xpass
		SrvPrefix_1=$SrvPrefix_xpass
		DutPrefix_1=$DutPrefix_xpass
		if [ $IPv6PrefixMode = "Native" ]; then
			DutMapEv6_1=$DutMapEv6_xpass_NT
		elif [ $IPv6PrefixMode = "PassThrough" ]; then
			DutMapEv6_1=$DutMapEv6_xpass_ND
		fi
	elif [ $ServiceType = "v6Connect" ] || [ $ServiceType = "rakutenMobile" ]; then
		Srvv6=$GlobalMapEv6_v6Connect
		SrvPrefix_1=$SrvPrefix_v6Connect
		if [ $IPv6PrefixMode = "Native" ] && [ $FletsNextMode = "Enabled" ]; then
			DutPrefix_1=$DutPrefix_v6Connect_NT
			DutMapEv6_1=$(DutMapEv6_v6Connect_ND ${ServiceOptions[0]})
		elif [ $IPv6PrefixMode = "Native" ]; then
			DutPrefix_1=$DutPrefix_v6Connect_NT
			DutMapEv6_1=$(DutMapEv6_v6Connect_NT ${ServiceOptions[0]})
		elif [ $IPv6PrefixMode = "PassThrough" ]; then
			DutPrefix_1=$DutPrefix_v6Connect_ND
			DutMapEv6_1=$(DutMapEv6_v6Connect_ND ${ServiceOptions[0]})
		fi
		if [ "$PrefixUpdating" = "TRUE" ]; then
			echo "updating prefix"
			SrvPrefix_1=$SrvPrefix_v6Connect_alt
			if [ $IPv6PrefixMode = "Native" ] && [ $FletsNextMode = "Enabled" ]; then
				DutPrefix_1=$DutPrefix_v6Connect_NT_alt
				DutMapEv6_1=$(DutMapEv6_v6Connect_ND_alt ${ServiceOptions[0]})
			elif [ $IPv6PrefixMode = "Native" ]; then
				DutPrefix_1=$DutPrefix_v6Connect_NT_alt
				DutMapEv6_1=$(DutMapEv6_v6Connect_NT_alt ${ServiceOptions[0]})
			elif [ $IPv6PrefixMode = "PassThrough" ]; then
				DutPrefix_1=$DutPrefix_v6Connect_ND_alt
				DutMapEv6_1=$(DutMapEv6_v6Connect_ND_alt ${ServiceOptions[0]})
			fi
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
	elif [ $ServiceType = "NGN" ]; then
		setupInterfaces_sub NGN
	elif [ $ServiceType = "v6Connect" ] || [ $ServiceType = "rakutenMobile" ]; then
		setupInterfaces_sub v6Connect "${ServiceOptions[@]}"
	elif [ $ServiceType = "CATV" ]; then
		setupInterfaces_sub CATV
	fi

	if [ $ServiceType = "NoIPv6" ]; then
		echo "--- No IPv6 Service selected."
	elif [ $ServiceType = "transix" ] || [ $ServiceType = "xpass" ] || [ $ServiceType = "v6Connect" ]; then
		ip addr add $Srvv6/64 dev $Interface_1
		#ip addr add $Srvv6/64 dev $Interface_LO
	else
		ip addr add $Srvv6/64 dev $Interface_1
		#ip addr add $Srvv6/64 dev $Interface_LO
	fi

	if [ $ExternalMode = "Enabled" ]; then
		ip addr add ${DefaultRoute_v4}/24 dev $Interface_DGW
		ip route add default via ${DefaultGW_v4} dev $Interface_DGW
	else
		ip addr add ${DefaultGW_v4}/24 dev $Interface_1
	fi

	## For local DNS.
	if [ "$FLG_MAPE" = "TRUE" ]; then
		#ip addr add ${Resolved_v4}/32 dev $MapIf_1
		ip addr add ${Resolved_v4}/24 dev $MapIf_1
		#to change ICMP reply error cord -> TTL Exceeded  editing udp packet
		iptables -t mangle -A PREROUTING -p udp -m ttl --ttl-lt 10 -j TTL --ttl-set 0
		iptables -t nat -A PREROUTING -p udp -i $MapIf_1 -j DNAT --to-destination ${Resolved_v4%.*}.75
	elif [ $ServiceType = "transix" ] || [ $ServiceType = "xpass" ] \
		|| [[ "$ServiceType" = "v6Connect" && "${ServiceOptions[0]}" = "dslite" ]] \
		|| [[ "$ServiceType" = "rakutenMobile" && "${ServiceOptions[0]}" = "dslite" ]]; then
		#ip addr add ${Resolved_v4}/32 dev $DslIf_1
		ip addr add ${Resolved_v4}/24 dev $DslIf_1
		#ip addr add 157.7.164.100/24 dev $DslIf_1
		#to change ICMP reply error cord -> TTL Exceeded  editing udp packet
		iptables -t mangle -A PREROUTING -p udp -m ttl --ttl-lt 10 -j TTL --ttl-set 0
		iptables -t nat -A PREROUTING -p udp -i $DslIf_1 -j DNAT --to-destination ${Resolved_v4%.*}.75
	elif [[ "$ServiceType" = "v6Connect" && "${ServiceOptions[0]}" = "ipip" ]]; then
		#ip addr add ${Resolved_v4}/32 dev $IpipIf_1
		ip addr add ${Resolved_v4}/24 dev $IpipIf_1
		#ip addr add 157.7.164.100/24 dev $IpipIf_1
		#to change ICMP reply error cord -> TTL Exceeded  editing udp packet
		iptables -t mangle -A PREROUTING -p udp -m ttl --ttl-lt 10 -j TTL --ttl-set 0
		iptables -t nat -A PREROUTING -p udp -i $IpipIf_1 -j DNAT --to-destination ${Resolved_v4%.*}.75
	else
		ip addr add ${Resolved_v4}/32 dev $Interface_1
	fi
}


setupNat()
{
	echo 1 > /proc/sys/net/ipv4/ip_forward
	echo 1 > /proc/sys/net/ipv4/tcp_fwmark_accept
	echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
	echo 0 > /proc/sys/net/ipv6/auto_flowlabels

	ip6tables -t mangle -A POSTROUTING -p icmpv6 -j TOS --set-tos 0xb8
	ip6tables -t mangle -A POSTROUTING -p udp --sport 547 --dport 546 -j TOS --set-tos 0xb8

	for i in /proc/sys/net/ipv4/conf/*/rp_filter; do
		echo 0 > "$i"
	done

	if [ $ExternalMode = "Enabled" ]; then
		iptables -t nat -A POSTROUTING -o $Interface_DGW -j MASQUERADE
	else
		echo "Internal" 2> /dev/null
		#iptables -t mangle -A PREROUTING -p udp -m ttl --ttl-lt 10 -j TTL --ttl-set 0
	fi

	if [ $HGWMode = "Enabled" ]; then
		iptables -t filter -A INPUT -s $DutMapEv4_1 -j DROP
		iptables -t filter -A FORWARD -s $DutMapEv4_1 -j DROP
	fi

	if [ "$CEMode" = "Same" ]; then
		echo "Emulate Same Addr CE."

		iptables -t nat -A PREROUTING -i $MapIf_1 -d $DutMapEv4_1 -p tcp -j DNAT --to-destination $DutMapEv4_2
		iptables -t nat -A PREROUTING -i $MapIf_1 -d $DutMapEv4_1 -p udp -j DNAT --to-destination $DutMapEv4_2
		iptables -t nat -A PREROUTING -i $MapIf_2 -d $DutMapEv4_2 -p tcp -j DNAT --to-destination $DutMapEv4_1
		iptables -t nat -A PREROUTING -i $MapIf_2 -d $DutMapEv4_2 -p udp -j DNAT --to-destination $DutMapEv4_1
	fi
}


setupDns()
{
	cd ./dns

	## original link is...: /etc/resolv.conf -> ../run/resolvconf/resolv.conf
	chmod -R 777 ./*
	cp -f resolv.conf /run/resolvconf

	## Common files
	cp named.conf /etc/bind
	chown root.root /etc/bind/named.conf
	cp named.conf.options /etc/bind
	chown root.root /etc/bind/named.conf.options

	local v4addr=$Resolved_v4

	if [ "$FLG_MAPE" = "TRUE" ]; then
		cp named.conf.mape-zones /etc/bind
		if [ $ServiceType = "v6Plus" ] || [ $ServiceType = "IPv6Option" ]; then
			sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" api.enabler.ne.jp.hosts > $DnsDir/api.enabler.ne.jp.hosts
			sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" sv03.jpne.co.jp.hosts > $DnsDir/sv03.jpne.co.jp.hosts
		elif [ $ServiceType = "OCN-VC" ]; then
			sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" rule.map.ocn.ad.jp.hosts > $DnsDir/rule.map.ocn.ad.jp.hosts
		fi
	else
		cp named.conf.empty-zones /etc/bind/named.conf.mape-zones
	fi
	chown root.root /etc/bind/named.conf.mape-zones

	if [ $HGWMode = "Enabled" ]; then
		cp named.conf.ntt-zones /etc/bind
		sed -e "s/<SrvIPv6>/$Dummyv6/g" -e "s/<SrvIPv4>/$DutDHCPv4_GW_1/g" ntt.setup.hosts > $DnsDir/ntt.setup.hosts
	else
		cp named.conf.empty-zones /etc/bind/named.conf.ntt-zones
	fi
	chown root.root /etc/bind/named.conf.ntt-zones

	if [ $ServiceType = "transix" ]; then
		cp named.conf.transix-zones /etc/bind
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" gw.transix.jp.hosts > $DnsDir/gw.transix.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" setup.transix.jp.hosts > $DnsDir/setup.transix.jp.hosts
	else
		cp named.conf.empty-zones /etc/bind/named.conf.transix-zones
	fi
	chown root.root /etc/bind/named.conf.transix-zones
	if [ $ServiceType = "xpass" ]; then
		cp named.conf.xpass-zones /etc/bind
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" dgw.xpass.jp.hosts > $DnsDir/dgw.xpass.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" setup.xpass.jp.hosts > $DnsDir/setup.xpass.jp.hosts
	else
		cp named.conf.empty-zones /etc/bind/named.conf.xpass-zones
	fi
	chown root.root /etc/bind/named.conf.xpass-zones
	if [ $ServiceType = "v6Connect" ]; then
		cp named.conf.v6Connect-zones /etc/bind
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" v6connect.net.hosts > $DnsDir/v6connect.net.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" \
			-e "s^<4over6info>^$V6MIG_4over6info_v6Connect^g" 4over6.info.hosts > $DnsDir/4over6.info.hosts
	else
		cp named.conf.empty-zones /etc/bind/named.conf.v6Connect-zones
	fi
	chown root.root /etc/bind/named.conf.v6Connect-zones
	if [ $ServiceType = "rakutenMobile" ]; then
		cp named.conf.rakutenMobile-zones /etc/bind
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" rakuten.jp.hosts > $DnsDir/rakuten.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" \
			-e "s^<4over6info>^$V6MIG_4over6info_rakutenMobile^g" 4over6.info.hosts > $DnsDir/4over6.info.hosts
	else
		cp named.conf.empty-zones /etc/bind/named.conf.rakutenMobile-zones
	fi
	chown root.root /etc/bind/named.conf.rakutenMobile-zones

	## for Buffalo AP
	#if [ $ExternalMode = "Disabled" ] then
	if [ $ExternalMode = "Disabled" ] || [ $MeasureMode = "Enabled" ]; then
		cp named.conf.buffalo-zones /etc/bind
		sed -e "s/<SrvIPv6>/$Dummyv6/g" -e "s/<SrvIPv4>/$v4addr/g" product.buffalo.jp.hosts  > $DnsDir/product.buffalo.jp.hosts 
		sed -e "s/<SrvIPv6>/$Dummyv6/g" -e "s/<SrvIPv4>/$v4addr/g" p.buffalo.jp.hosts > $DnsDir/p.buffalo.jp.hosts
		sed -e "s/<SrvIPv6>/$Dummyv6/g" -e "s/<SrvIPv4>/$v4addr/g" d.buffalo.jp.hosts > $DnsDir/d.buffalo.jp.hosts
		sed -e "s/<SrvIPv6>/$Dummyv6/g" -e "s/<SrvIPv4>/$v4addr/g" buffalo.jp.hosts > $DnsDir/buffalo.jp.hosts
		sed -e "s/<SrvIPv6>/$Dummyv6/g" -e "s/<SrvIPv4>/$v4addr/g" driver.buffalo.jp.hosts > $DnsDir/driver.buffalo.jp.hosts
	else
		cp named.conf.empty-zones /etc/bind/named.conf.buffalo-zones
	fi
	chown root.root /etc/bind/named.conf.buffalo-zones

	## for Others
	if [ $OtherDomains = "Enabled" ]; then
		cp named.conf.other-zones /etc/bind
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" firmwarev6.aterm.jp.hosts > $DnsDir/firmwarev6.aterm.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" aimremotev6.aterm.jp.hosts > $DnsDir/aimremotev6.aterm.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" aimremote2.aterm.jp.hosts > $DnsDir/aimremote2.aterm.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" www.aterm.jp.hosts > $DnsDir/www.aterm.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" www.elecom.co.jp.hosts > $DnsDir/www.elecom.co.jp.hosts
		sed -e "s/<SrvIPv6>/$Dummyv6/g" -e "s/<SrvIPv4>/$v4addr/g" www.msftconnecttest.com.hosts > $DnsDir/www.msftconnecttest.com.hosts
		sed -e "s/<SrvIPv6>/$Dummyv6/g" -e "s/<SrvIPv4>/$v4addr/g" dns.msftncsi.com.hosts > $DnsDir/dns.msftncsi.com.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" ipv6.msftconnecttest.com.hosts > $DnsDir/ipv6.msftconnecttest.com.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" iosupdate1.iodata.jp.hosts > $DnsDir/iosupdate1.iodata.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" iosupdate61.iodata.jp.hosts > $DnsDir/iosupdate61.iodata.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" tepco.co.jp.hosts > $DnsDir/tepco.co.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" route-info.flets-west.jp.hosts > $DnsDir/route-info.flets-west.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" ipv4.happy-wifi-life.com.hosts > $DnsDir/ipv4.happy-wifi-life.com.hosts
	else
		cp named.conf.empty-zones /etc/bind/named.conf.other-zones
	fi
	chown root.root /etc/bind/named.conf.other-zones

	## for NTP
	if [ $NtpDomains = "Enabled" ]; then
		cp named.conf.ntp-zones /etc/bind
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" ntp.jst.mfeed.ad.jp.hosts > $DnsDir/ntp.jst.mfeed.ad.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" ntp1.v6.mfeed.ad.jp.hosts > $DnsDir/ntp1.v6.mfeed.ad.jp.hosts
		sed -e "s/<SrvIPv6>/$Srvv6/g" -e "s/<SrvIPv4>/$v4addr/g" ntp.nict.jp.hosts > $DnsDir/ntp.nict.jp.hosts
	else
		cp named.conf.empty-zones /etc/bind/named.conf.ntp-zones
	fi
	chown root.root /etc/bind/named.conf.ntp-zones

	## Dummy
	sed -e "s/<SrvIPv6>/$Dummyv6/g" -e "s/<SrvIPv4>/$Dummyv4/g" $DummyDomain.hosts > $DnsDir/$DummyDomain.hosts

	chmod -R 777 /etc/bind/*

	checkMkdir /var/log/named/
	chmod 777 /var/log/named/

	echo -n "wait prepareting IPv6 addresses "
	while [ "" != "$(ip -6 a|grep tentative)" ]
	do
		sleep 1
		echo -n "."
	done
	echo "[done]"

	eval $NAMED

	cd ..
}


setupDhcpd6_sub()
{
	cd ./dhcpd

	local AdvValidLifetime=2592000;
	if [ "$AdvPreferredLifetime" = "" ]; then
		AdvPreferredLifetime=604800;
	fi

	if [ "$PrefixDisabling" = "TRUE" ]; then
		AdvValidLifetime=0;
		AdvPreferredLifetime=0;
	fi

	if [ $Dhcpv6LeasesHandoverMode = "Disabled" ]; then
		rm /var/lib/dhcp/dhcpd6.leases
		touch /var/lib/dhcp/dhcpd6.leases
	fi

	local TMP='./tmp.dat'

	## Change the config file to be used according to an argument "-p", which designetes using "Native mode" or "Passthrough mode".
	local RadvdCore='radvd_core.conf'
	if [ $IPv6PrefixMode = "Native" ]; then
		local PDPrefixSetting="	prefix6 <DutPrefix>:: <DutPrefix>:: /56;"
		local IANARangeSetting=""
		if [ "$Dhcpv6IA_NAAddress" = "Enabled" ]; then
			local IANARangeSetting="	range6 <SrvPrefix>::1000 <SrvPrefix>::1fff;"
		fi
		if [ "$ServiceType" = "CATV" ]; then
			local PDPrefixSetting="	prefix6 <DutPrefix>:: <DutPrefixEnd>:: /64;"
			local IANARangeSetting="	range6 <SrvPrefix>::1000 <SrvPrefix>::1fff;"
		fi
		if [ $FletsNextMode = "Enabled" ]; then
			local MFLAG=off
			local RadvdPtCore="$(cat radvd_pt_core.conf \
				| sed -e "s/<AdvValidLifetime>/$AdvValidLifetime/g" \
				| sed -e "s/<AdvPreferredLifetime>/$AdvPreferredLifetime/g")"
		else
			local MFLAG=on
			local RadvdPtCore=""
		fi
		if [ "$ServerDhcpv6NoPrefixAvail" = "TRUE" ]; then
			PDPrefixSetting=""
		fi

		if [ $NativeAndPassthrough = "TRUE" ]; then
			local RadvdPtCore="$(cat radvd_pt_core.conf \
				| sed -e "s/<AdvValidLifetime>/$AdvValidLifetime/g" \
				| sed -e "s/<AdvPreferredLifetime>/$AdvPreferredLifetime/g")"
		fi
	elif [ $IPv6PrefixMode = "PassThrough" ]; then
		if [ "$ServiceType" = "CATV" ]; then
			echo -e "\e[31mfaital: CATV mode does not support pass through!\e[m"
			exit 1
		fi
		local PDPrefixSetting=""
		local IANARangeSetting=""
		local MFLAG=off
		local RadvdPtCore="$(cat radvd_pt_core.conf \
			| sed -e "s/<AdvValidLifetime>/$AdvValidLifetime/g" \
			| sed -e "s/<AdvPreferredLifetime>/$AdvPreferredLifetime/g")"
	fi
	#if [ "$FLG_U" = "TRUE" ] ; then
	#	local PDPrefixSetting="	prefix6 <DutPrefix>:: <DutPrefix>:: /64;"
	#	local MFLAG=on
	#	echo '' > $TMP
	#fi

	if [ $FletsCrossMode = "Enabled" ]; then
		local SENDRA=off
	else
		local SENDRA=on
	fi

	#TODO "is needed by v6Connect?"
	if [ "$ServiceType" = "transix" ] || [ "$ServiceType" = "xpass" ]; then
		local OptionVendorOptsTmp=$OPTION_VENDOR_OPTS
	elif [ "$ServiceType" = "CATV" ]; then
		local OptionVendorOptsTmp=''
	else
		#local OptionVendorOptsTmp=''
		local OptionVendorOptsTmp=$OPTION_VENDOR_OPTS
	fi

	local Dhcpd6CoreTmp0=$(echo $PDPrefixSetting | sed -e "/<PDPrefixSetting>/r /dev/stdin" dhcpd6_core.conf | sed -e "/<PDPrefixSetting>/d")

	echo -n "$Dhcpd6CoreTmp0" > $TMP
	local Dhcpd6CoreTmp0=$(echo $IANARangeSetting | sed -e "/<IANARangeSetting>/r /dev/stdin" $TMP | sed -e "/<IANARangeSetting>/d")

	local Dhcpd6CoreTmp1=$(echo "$Dhcpd6CoreTmp0" | sed -e "s/<SrvPrefix>/$SrvPrefix_1/g" -e "s/<DutPrefix>/$DutPrefix_1/g" -e "s/<DutPrefixEnd>/$DutPrefixEnd_1/g" -e "s/<SrvLocal>/$SrvLocal_1/g")
	local PioCachePath="/tmp/test_server_pio_prefix.cache"

	local RadvdOldPrefix=''
	if [ "$ServerRadvdInvalidOldPrefix" = "TRUE" ]; then	
		local PioCache="$(cat $PioCachePath)"

		if [ "$PioCache" == "$SrvPrefix_1" ]; then
			echo "warning: no difference between just before and now."
		else
			if [ "$PioCache" != "" ]; then
				local RadvdOldPrefix=$(cat radvd_pt_core.conf \
					| sed -e "s/<AdvValidLifetime>/0/g" \
					| sed -e "s/<AdvPreferredLifetime>/0/g" \
					| sed -e "s/<SrvPrefix>/${PioCache}/g")
			else
				echo "warning: could not find $PioCachePath"
			fi
		fi
	fi

	echo "$SrvPrefix_1" > $PioCachePath

	local RAPrefixSetting="${RadvdPtCore}$(echo '\n')${RadvdOldPrefix}"
	local RadvdCoreTmp0=$(echo "$RAPrefixSetting" | sed -e "/<RAPrefixSetting>/r /dev/stdin" radvd_core.conf | sed -e "/<RAPrefixSetting>/d")
	local RadvdCoreTmp1=$(echo "$RadvdCoreTmp0" \
		| sed -e "s/<SrvPrefix>/$SrvPrefix_1/g" -e "s/<Interface>/$Interface_1/g" -e "s/<MFLAG>/$MFLAG/g" -e "s/<SENDRA>/$SENDRA/g")

	if [ $NumberOfCE -eq 2 ]; then
		local RadvdCoreTmp2=$(echo "$RadvdCoreTmp0" | sed -e "s/<SrvPrefix>/$SrvPrefix_2/g" -e "s/<Interface>/$Interface_2/g" -e "s/<MFLAG>/$MFLAG/g" -e "s/<SENDRA>/$SENDRA/g")
		local Dhcpd6CoreTmp2=$(echo "$Dhcpd6CoreTmp0" | sed -e "s/<SrvPrefix>/$SrvPrefix_2/g" -e "s/<DutPrefix>/$DutPrefix_2/g" -e "s/<SrvLocal>/$SrvLocal_2/g")
		local DHCPD6_OPTIONS="$Interface_1 $Interface_2"
	else
		local RadvdCoreTmp2=''
		local Dhcpd6CoreTmp2=''
		local DHCPD6_OPTIONS="$Interface_1"
	fi

	local RadvdTmp=$(cat radvd_base.conf)
	local RadvdTmp=$(echo "$RadvdTmp" | perl -pe "s/<RadvdCoreTmp1>/${RadvdCoreTmp1//\//\\/}/g")
	local RadvdTmp=$(echo "$RadvdTmp" | perl -pe "s/<RadvdCoreTmp2>/${RadvdCoreTmp2//\//\\/}/g")
	echo "$RadvdTmp" > /etc/radvd.conf
	#echo "DISP::/etc/radvd.conf"; cat /etc/radvd.conf

	local RapidCommitTmp=
	if [[ "$ServerDhcpv6RapidCommit" == "TRUE" ]]; then
		local RapidCommitTmp="option dhcp6.rapid-commit;"
	fi

	echo "$Dhcpd6CoreTmp1" | sed -e '/<Dhcpd6CoreTmp1>/r /dev/stdin' dhcpd6_base.conf | sed -e '/<Dhcpd6CoreTmp1>/d' > $TMP
	local Dhcpd6CoreTmp3=$(echo "$Dhcpd6CoreTmp2" \
		| sed '/<Dhcpd6CoreTmp2>/r /dev/stdin' $TMP \
		| sed -e '/<Dhcpd6CoreTmp2>/d' \
		| sed -e "s/<OPTION_VENDOR_OPTS>/$OptionVendorOptsTmp/g" \
	       	| sed -e "s/<ServerDhcpv6DuidType>/$ServerDhcpv6DuidType/g" \
		| sed -e "s/<ServerDhcpv6RapidCommit>/$RapidCommitTmp/g")
	echo "$Dhcpd6CoreTmp3" > /etc/dhcp/dhcpd6.conf
	#echo "DISP::/etc/dhcp/dhcpd6.conf"; cat /etc/dhcp/dhcpd6.conf


	radvd -C /etc/radvd.conf
	$DHCPDv6 -cf /etc/dhcp/dhcpd6.conf $DHCPD6_OPTIONS

	rm $TMP
	cd ..
}


setupDhcpd6()
{
	if [ $ServiceType != "NoIPv6" ]; then
		setupDhcpd6_sub
	else
		echo "--- Skipped."
	fi
}


setupDhcpd4_sub()
{
	cd ./dhcpd

	rm /var/lib/dhcp/dhcpd.leases
	touch /var/lib/dhcp/dhcpd.leases

	ip neighbor flush all
	ip addr add $DutDHCPv4_GW_1/24 dev $Interface_1

	sed -e "s/<DutDHCPv4_NA>/$DutDHCPv4_NA/g" -e "s/<DutDHCPv4_1>/$DutDHCPv4_1/g" -e "s/<DutDHCPv4_1_LAST>/$DutDHCPv4_1_LAST/g" -e "s/<DutDHCPv4_GW_1>/$DutDHCPv4_GW_1/g" -e "s/<DummyDomain>/$DummyDomain/g" ./dhcpd.conf > /etc/dhcp/dhcpd.conf

	$DHCPDv4 -cf /etc/dhcp/dhcpd.conf $Interface_1

	#if [ $ServiceType != "NoIPv6" ] && [ $HGWMode != "Enabled" ]; then
	if [ $ServiceType != "NoIPv6" ] && [ $ServiceType != "CATV" ] && [ $ServiceType != "NGN" ] && [ $HGWMode != "Enabled" ]; then
		#sudo iptables -t filter -A INPUT -s $DutDHCPv4_1 -d $Resolved_v4 -j DROP
		sudo iptables -t filter -A INPUT -s $DutDHCPv4_1 -j DROP
		sudo iptables -t filter -A FORWARD -s $DutDHCPv4_1 -j DROP
		echo "--- DHCPv4 doesn't have Internet Connectivity."
	else
		echo "--- DHCPv4 has Internet Connectivity."
	fi

	cd ..
}


setupDhcpd4()
{
	if [ $DHCPv4ServerMode = "Enabled" ]; then
		setupDhcpd4_sub
	else
		echo "--- Skipped."
	fi
}

delete_empty_lines()
{
	local file_path="$1"
	cat "$file_path" \
		| sed -e '/^\s*$/d' \
		> "${file_path}.tmp"

	mv "${file_path}.tmp" "${file_path}"
}

compact_json()
{
	local file_path="$1"
	cat "$file_path" \
		| jq -c \
		> "${file_path}.tmp"

	mv "${file_path}.tmp" "${file_path}"
}

setupHttps_v6plus_sub()
{
	## MAP-E files for v6-Plus
	local SslDir="/var/www/lighttpd/"
	checkMkdir $SslDir
	
	sed -e "s/<GlobalMapEv6_v6plus>/$GlobalMapEv6_v6plus/g" get_rules_normal.json > $SslDir/get_rules_normal.json

	#always return "get_rules.php", but it selected by ErrorCode.
	if [ "$ERR_NO" = "-1" ]; then
		cp -a get_rules_normal.php $SslDir/get_rules.php
	elif [ "$ERR_NO" = "403" ]; then
		cp -a get_rules_403.php $SslDir/get_rules.php
	elif [ "$ERR_NO" = "500" ]; then
		cp -a get_rules_500.php $SslDir/get_rules.php
	elif [ "$ERR_NO" = "200" ]; then
		cp -a get_rules_invalid.php $SslDir/get_rules.php
	elif [ "$ERR_NO" = "200-logic-invalid" ]; then
		cp -a get_rules_invalid2.php $SslDir/get_rules.php
	elif [ "$ERR_NO" = "0" ]; then
		cp -a get_rules_empty.php $SslDir/get_rules.php
	fi

	cp -a get_rules_core.php $SslDir
	cp -a get_rules_invalid.json $SslDir
	cp -a get_rules_invalid2.json $SslDir
	cp -a get_rules_empty.json $SslDir
	cp -a acct_report.json $SslDir
	cp -a acct_report.php $SslDir

	if [ "$PROD_E_SUPPORT" = "TRUE" ]; then
		compact_json ${SslDir}get_rules_normal.json
		delete_empty_lines ${SslDir}get_rules_core.php
	fi
}


setupHttps_ocn_sub()
{
	## MAP-E files for OCN-VC
	local SslDir="/var/www/lighttpd/"
	checkMkdir $SslDir

	sed -e "s/<GlobalMapEv6_ocnvc>/$GlobalMapEv6_ocnvc/g" get_rules_ocn_normal.json > $SslDir/get_rules_ocn_normal.json

	#always return "get_rules_ocn.php", but it selected by ErrorCode.
	if [ "$ERR_NO" = "-1" ]; then
		cp -a get_rules_ocn_normal.php $SslDir/get_rules_ocn.php
	elif [ "$ERR_NO" = "403" ]; then
		cp -a get_rules_403.php $SslDir/get_rules_ocn.php
	elif [ "$ERR_NO" = "500" ]; then
		cp -a get_rules_500.php $SslDir/get_rules_ocn.php
	elif [ "$ERR_NO" = "200" ]; then
		cp -a get_rules_ocn_invalid.php $SslDir/get_rules_ocn.php
	elif [ "$ERR_NO" = "0" ]; then
		cp -a get_rules_ocn_empty.php $SslDir/get_rules_ocn.php
	fi

	cp -a get_rules_core.php $SslDir
	cp -a get_rules_ocn_invalid.json $SslDir
	cp -a get_rules_ocn_empty.json $SslDir

	# update timestamp
	find $SslDir | xargs touch

	if [ "$PROD_E_SUPPORT" = "TRUE" ]; then
		compact_json ${SslDir}get_rules_ocn_normal.json
		delete_empty_lines ${SslDir}get_rules_core.php
	fi
}


setupHttps_v6mig_sub()
{
	## v6mig-provisioning files for v6-Connect
	local SslDir="/var/www/lighttpd/"
	local GenPem="FALSE"
	checkMkdir $SslDir
	
	# generate provisioning data
	# ttl
	eval local ttl='${'V6MIG_ttl_${ServiceType}'}'
	if [[ "${ServiceOptions[@]}" =~ ttl=([0-9]+) ]]; then
		ttl=${BASH_REMATCH[1]}
		ServiceOptions=("${ServiceOptions[@]/ttl=$ttl}")
	fi
	# order
	ServiceOptions=("${ServiceOptions[@]/NONE}")
	local order=$(printf ",\"%s\"" ${ServiceOptions[@]}); order=${order:1}
	eval local enabler_name='$'V6MIG_enabler_name_${ServiceType}
	eval local service_name='$'V6MIG_service_name_${ServiceType}

	cat get_v6mig_prov_config_base.php \
		| sed -e "s^<enabler_name>^$enabler_name^g" \
		| sed -e "s^<service_name>^$service_name^g" \
		| sed -e "s/<order>/$order/g" \
		| sed -e "s/<ttl>/$ttl/g" \
		> $SslDir/get_v6mig_prov_config.php

	# insert ipip parameter to after <param> mark
	if [[ "${ServiceOptions[@]}" =~ "ipip" ]]; then
		if [ $ServiceType = "rakutenMobile" ]; then
			echo "ERROR! rakutenMobile has not supported ipip!"
		fi
		if [ $IPv6PrefixMode = "Native" ]; then
			local ipv6_local="$DutPrefix_1:$V6ConnectLocal_1"
			if [ $FletsNextMode = "Enabled" ]; then
				local ipv6_local="$SrvPrefix_1:$V6ConnectLocal_1"
			fi
		elif [ $IPv6PrefixMode = "PassThrough" ]; then
			local ipv6_local="$SrvPrefix_1:$V6ConnectLocal_1"
		fi
		local ipv6_remote=$Srvv6
		local ipv4="${DutV6Connect_Ipip_v4_1[0]}"
		local rewrite=$(cat $SslDir/get_v6mig_prov_config.php \
			| sed -e "/<param>/r get_v6mig_prov_config_ipip.json" \
			| sed -e "s/<ipv6_local>/$ipv6_local/g" \
			| sed -e "s/<ipv6_remote>/$ipv6_remote/g" \
			| sed -e "s#<ipv4>#$ipv4#g" )
		echo "$rewrite" > $SslDir/get_v6mig_prov_config.php
	fi

	# insert dslite parameter to after <param> mark
	if [[ "${ServiceOptions[@]}" =~ "dslite" ]]; then
		eval local aftr='$'V6MIG_dslite_aftr_${ServiceType}
		local rewrite=$(cat $SslDir/get_v6mig_prov_config.php \
			| sed -e "/<param>/r get_v6mig_prov_config_dslite.json" \
			| sed -e "s/<aftr>/$aftr/g" )
		echo "$rewrite" > $SslDir/get_v6mig_prov_config.php
	fi

	# delete <param> mark
	local rewrite=$(cat $SslDir/get_v6mig_prov_config.php \
		| sed -e "/<param>/d" )
	echo "$rewrite" > $SslDir/get_v6mig_prov_config.php
	# delete last ','
	local rewrite=$(tac $SslDir/get_v6mig_prov_config.php \
		| awk '!matched {matched=sub(/,/,"")} 1' \
		| tac )
	echo "$rewrite" > $SslDir/get_v6mig_prov_config.php

	# generate server.pem
	if [ "$ServCertGenMode" = "Once" ] && [ ! -e ./gen-pem/server.pem ]; then
		GenPem="TRUE"
	else
		if [ "$ServCertGenMode" = "Force" ]; then
			GenPem="TRUE"
		fi
	fi
	if [ "$GenPem" = "TRUE" ]; then
		bash ./gen-pem/gen-self-ca.sh
	fi
	ServerPem=./gen-pem/server.pem

	if [ "$ERR_NO" = "-1" ]; then
		REWRITE_CONF=`cat lighttpd_v6mig_rewrite_normal.conf`
	elif [ "$ERR_NO" = "307" ]; then
		REWRITE_CONF=`cat lighttpd_v6mig_rewrite_redirect.conf`
		echo "Redirect path is relative by default."
		echo "Your want to redirect path to be absolutive,"
		echo "Change , and Restart this server"
	elif [ "$ERR_NO" = "404" ]; then
		REWRITE_CONF=`cat lighttpd_v6mig_rewrite_404.conf`
		cat get_v6mig_prov_config_404.php \
			| sed -e "s/<ttl>/$ttl/g" \
			> $SslDir/get_rules_404.php
	elif [ "$ERR_NO" = "0" ]; then
		REWRITE_CONF=`cat lighttpd_v6mig_rewrite_empty.conf`
		cat get_v6mig_prov_config_empty.php \
			> $SslDir/get_rules_empty.php
	elif [ "$ERR_NO" = "9" ]; then
		: #httpd not start
	else
		if [ $ServiceType = "v6Connect" ]\
		|| [ $ServiceType = "rakutenMobile" ]; then
			echo "ERROR! ERR_NO: $ERR_NO is not supported!"
		fi
	fi
}


setupHttps_hgw_sub()
{
	if [ -n "$1" ]; then
		local HGW_Check="$1"
	else
		echo "--- ERROR: Invalid parameter."
		exit -1
	fi

	local HgwChkDir="/var/www/lighttpd/$HGW_Check/"
	checkMkdir $HgwChkDir
	cp -a get_rules_core.php $HgwChkDir

	if [ $HGWMode = "Enabled" ]; then
		cp -a check_on.json $HgwChkDir
		cp -a check_on.php $HgwChkDir/check.php
	else
		cp -a check_off.json $HgwChkDir
		cp -a check_off.php $HgwChkDir/check.php
	fi

	if [ "$PROD_E_SUPPORT" = "TRUE" ]; then
		delete_empty_lines ${HgwChkDir}get_rules_core.php
	fi
}


setupHttps_index_sub()
{
	local IndexChkDir="/var/www/lighttpd/"
	checkMkdir $IndexChkDir
	#cp -a index.html $IndexChkDir
	cp -a setup.transix.json $IndexChkDir/index.html
	#cp -a test.php $IndexChkDir
	cp -a connecttest.txt $IndexChkDir/connecttest.txt
	cp -a ncsi.txt $IndexChkDir/ncsi.txt
	cp -a route-info.php $IndexChkDir/route-info.php
}


setupHttps_Buffalo_sub()
{
	local BufChkDir="/var/www/lighttpd/setting/"
	checkMkdir $BufChkDir
	cp -a airstation-ok.html $BufChkDir
	checkMkdir $BufChkDir/images
	cp -a setting-jp-ok.png $BufChkDir/images
	cp -a setting-jp-ok.png $BufChkDir/setting-ok.png
	cp -a setting-jp-Nietzsche.png $BufChkDir/images
}


setupHttps_NEC_sub()
{
	#local NecChkDir="/var/www/ssl/"
	local NecChkDir="/var/www/lighttpd/"
	checkMkdir $NecChkDir
	cp -a aim.txt $NecChkDir
}


setupHttps_IOdata_sub()
{
	local IoDataChkDir="/var/www/lighttpd/"
	checkMkdir $IoDataChkDir
	cp -a inetchk1.xml $IoDataChkDir
}


setupHttps()
{
	cd ./https

	ServerPem=server.pem

	## Test index file
	setupHttps_index_sub


	if [ $ServiceType = "NoIPv6" ]; then
		echo "--- No IPv6 Service selected." > /dev/null
	else
		setupHttps_v6plus_sub
		setupHttps_ocn_sub
		setupHttps_v6mig_sub #updating ServerPem
	fi

	## HGW connection check files
	## Check files for v6-Plus
	setupHttps_hgw_sub "enabler.ipv4"
	## Check files for IPv6Option
	setupHttps_hgw_sub "biglobe.ipv4"


	## Buffalo connection check files
	setupHttps_Buffalo_sub


	## NEC Unknown files
	setupHttps_NEC_sub

	## IOdata Unknown files
	setupHttps_IOdata_sub


	## Change permission for all /var/www files
	chmod -R 777 /var/www/*


	## SSL server secret key
	echo "--- use the server.pem: $ServerPem" #> /dev/null
	checkMkdir /etc/lighttpd/ssl
	cp -a "$ServerPem" /etc/lighttpd/ssl/server.pem

	## web-server log files
	checkMkdir /var/log/lighttpd
	chmod 777 /var/log/lighttpd
	echo > /var/log/lighttpd/error.log
	chmod 777 /var/log/lighttpd/error.log

	## web-server conf files
	echo "$REWRITE_CONF" \
		| sed -e "/<v6mig_rewrite_conf>/r /dev/stdin" ./lighttpd.conf \
		| sed -e '/<v6mig_rewrite_conf>/d' \
		> /etc/lighttpd/lighttpd.conf

	## Start web-server
	if [ "$ERR_NO" != "9" ]; then #9:No_response = not need to start httpd
		lighttpd -f /etc/lighttpd/lighttpd.conf
		#service lighttpd start
	fi
	cd ..
}


setupAutoupdates_sub()
{
	if [ -n "$AutoUpTxt" ]; then
		local AutoUpTxtDir="/var/www/lighttpd/download/driver/lan/autoup/"
		checkMkdir $AutoUpTxtDir
		cp -a $AutoUpTxt $AutoUpTxtDir
	else
		echo "--- ERROR: Cannot find $AutoUpTxt."
		exit -1
	fi
	
	if [ -n "$AutoUpHtml" ]; then
		local AutoUpHtmlDir="/var/www/lighttpd/download/driver/lan/txt/"
		checkMkdir $AutoUpHtmlDir
		cp -a $AutoUpHtml $AutoUpHtmlDir
	else
		echo "--- ERROR: Cannot find $AutoUpHtml"
		exit -1
	fi

	local AutoUpBinDir="/var/www/lighttpd/buf-drv/lan/"
	for var in ${AutoUpBin[@]}
	do
		echo $var
		if [ -n "$var" ]; then
			checkMkdir $AutoUpBinDir
			cp -a $var $AutoUpBinDir
		else
			echo "--- ERROR: Cannot find $var"
			exit -1
		fi
	done
}


setupAutoupdates()
{
	cd ./autoupdates

	setupAutoupdates_sub
	chmod -R 777 /var/www/*

	cd ..
}


setupHtDocs_sub()
{
	local HtdChkDir="/var/www/lighttpd/htdocs/"
	checkMkdir $HtdChkDir
	cp -r ./* $HtdChkDir
}


setupHtDocs()
{
	cd ./htdocs

	setupHtDocs_sub
	chmod -R 777 /var/www/*

	cd ..
}


setupPppoes_sub()
{
	cd ./pppoe-srv

	sed -e "s/<DutPPPoEv4_GW_1>/$DutPPPoEv4_GW_1/g" ./options > /etc/ppp/options
	sed -e "s/<DutPPPoEv4_1>/$DutPPPoEv4_1/g" ./pap-secrets > /etc/ppp/pap-secrets
	sed -e "s/<DutPPPoEv4_1>/$DutPPPoEv4_1/g" ./chap-secrets > /etc/ppp/chap-secrets
	cat ./ip-up.local > /etc/ppp/ip-up.local

	#pppoe-server -I $Interface_1 -L $DutPPPoEv4_GW_1 -O /etc/ppp/options
	#pppoe-server -I $Interface_1 -O /etc/ppp/options
	pppoe-server -I $Interface_1 -L $DutPPPoEv4_GW_1 -R $DutPPPoEv4_1 -O /etc/ppp/options
	echo "" > /etc/ppp/ip-up.local

	cd ..
}


setupPppoes()
{
	if [ $PPPoEServerMode = "Enabled" ] && [ $PPPoEServerNotRestart = "FALSE" ]; then
		setupPppoes_sub
	else
		echo "--- Skipped."
	fi
}

setupFinMsg()
{
	if [ "$ServiceType" = "v6Connect" ]; then
		echo "please install ./https/gen-pem/ca-crt.pem to a router,"
		echo "and rename the ca-crt.pem to \"v6migration_cert.pem\"."
		echo "(this is needed for test for verifing server certificate.)"
	fi
}
