# ---------------------------------------------------------
# Parameters
# ---------------------------------------------------------

. "./conf_ipv6opt.sh"

SetParams()
{
	DHCPDv4="dhcpd -4"
	DHCPDv6="dhcpd -6"
	#DHCPDv4="/home/test-server/bin/dhcpd -4"
	#DHCPDv6="/home/test-server/bin/dhcpd -6"

	#NAMED="service bind9 restart"
	NAMED="/usr/sbin/named -c /etc/bind/named.conf"
	#NAMED="killall named; /home/test-server/bind9/bind-9.16.23/bin/named/named -c /etc/bind/named.conf -u bind"
	#NAMED="killall named; /home/test-server/bind9/bind-9.16.27/bin/named/named -c /etc/bind/named.conf -u bind"

##
## DUT Local-addr excluding prefix.
##
	## Buffalo
	## WXR-1900DHP2
	#DutLocal_1=8a57:eeff:fe23:af3e
	## WXR-1900DHP3
	#DutLocal_1=8a57:eeff:fe7e:ee6e
	## WSR-1166DHP4
	#DutLocal_1=1ac2:bfff:fe2a:fc00
	#DutLocal_1=1ac2:bfff:fe34:9700
	#DutLocal_1=1ac2:bfff:fe2a:fc00

	## WSR-1166DHPL2
	#DutLocal_1=52c4:ddff:fe72:288
	#DutLocal_1=52c4:ddff:fe72:228
	
	## WSR-1800AX4
	#DutLocal_1=5a27:8cff:fe33:53b0
	#DutLocal_1=5a27:8cff:fe32:760
	#DutLocal_1=5a27:8cff:fe33:38d0
	#DutLocal_1=5827:8cff:fe32:0310

## debug
	#6000
	DutLocal_1=8202:9cff:fe24:bfe0
	#5950
	#DutLocal_1=1abe:92ff:fe11:3a60
	#1166
	#DutLocal_1=52c4:ddff:fe72:3b0
	#5700
	#DutLocal_1=ced4:2eff:feb8:6b00
	#1800
	#DutLocal_1=5a27:8cff:fe32:560
	#DutLocal_1=5a27:8cff:fe32:310
	#3200
	#DutLocal_1=1aec:e7ff:fe2b:f810
	#VR-U300W
	#DutLocal_1=6433:83ff:fe82:ad73

	## WSR-2533DHP2
	#DutLocal_1=52c4:ddff:fe56:db40
	#DutLocal_1=1ac2:bfff:fe58:3c30
	#DutLocal_1=8a57:eeff:fe63:168
	#DutLinkLocal=8a57:eeff:fe63:169
	## WSR-2533DHP3
	#DutLocal_1=52c4:ddff:fe50:ccf0
	#DutLocal_1=52c4:ddff:fe50:cc80
	#DutLocal_1=52c4:ddff:fe50:cf80
	#DutLocal_1=52c4:ddff:fe79:8a40
	#DutLocal_1=52c4:ddff:feda:2728
	

	## WSR-2533DHPL2
	#DutLocal_1=52c4:ddff:feb0:48a8
	#DutLocal_1=52c4:ddff:feb0:48b8
	#DutLocal_1=52c4:ddff:feb0:4888
	#DutLocal_1=52c4:ddff:feb0:4820
	#DutLocal_1=5a27:8cff:fe1e:da70

	## WTR-D2133HP
	#DutLocal_1=6284:bdff:fe93:0f78

	## WTR-M2133HP

	##WXR-5700AX7S
	#DutLocal_1=0e8e:29ff:fe99:20a0
	#DutLocal_1=0e8e:29ff:fe99:2070
	#DutLocal_1=ced4:2eff:feb8:6a90
	
	##WXR-5950AX12
	#DutLocal_1=1abe:92ff:fe11:3d00
	#DutLocal_1=1abe:92ff:fe11:3838
	
	##WSR-5400AX6
	#DutLocal_1=8202:9cff:fe5e:2d20	
	#DutLocal_1=5a27:8cff:fe4f:31d0

	## NEC
	## WG1200HP3
	## WG2600HP3
	#DutLocal_1=6ee4:daff:fe4e:0b2d
	## WG2600HS
	#DutLocal_1=6ee4:daff:fec9:b1d5
	## HGW PR-500MI

	## WX5400HS
	#PROD_E_SUPPORT="TRUE"
	#DutLocal_1=a10:86ff:feaa:6e40
	#DutLinkLocal=a10:86ff:feaa:6e41

	## IODATA
	## WN-DAX1800GR
	#DutLocal_1=5241:b9ff:fe10:1757
	## WN-DAX3600QR
	#PROD_E_SUPPORT="TRUE"
	#DutLocal_1=5241:b9ff:fe3a:9bd3

	## ELECOM
	## WRC-X3200GST3
	#PROD_E_SUPPORT="TRUE"
	#DutLocal_1=6ab:18ff:febe:db7c


	## For CE2
	#DutLocal_2=6ee4:daff:fec9:b1d5
	DutLocal_2=6ee4:daff:fe4e:0b2d
	#DutLocal_2=8a57:eeff:fe7e:ee6e
	#DutLocal_2=52c4:ddff:feb0:48c8



##
## AutoUpdateFiles
##
	## WSR-2533DHP3
	#AutoUpTxt="wsr_2533dhp3_jp.txt"
	#AutoUpHtml="releasenote_wsr_2533dhp3_jp.html"
	#AutoUpBin[0]="wsr-2533dhp3_1.00_0.20_jp_code.enc"
	#AutoUpBin[1]="wsr-2533dhp3_9.99_9.99_jp_code.enc"
	#AutoUpBin[2]="wsr-2533dhp3_9.98_9.98_jp_code.enc"
	#AutoUpBin[3]="wsr-2533dhp3_9.97_9.97_jp_code.enc"
	## WSR-2533DHPL2
	#AutoUpTxt="wsr_2533dhpl2_jp.txt"
	#AutoUpHtml="releasenote_wsr_2533dhpl2_jp.html"
	#AutoUpBin[0]="wsr-2533dhpl2_1.00_0.20_jp_code.enc"
	#AutoUpBin[1]="wsr-2533dhpl2_9.99_9.99_jp_code.enc"
	#AutoUpBin[2]="wsr-2533dhpl2_9.98_9.98_jp_code.enc"
	#AutoUpBin[3]="wsr-2533dhpl2_9.97_9.97_jp_code.enc"
	## WSR-1166DHPL2
	#AutoUpTxt="wsr_1166dhpl2_jp.txt"
	#AutoUpHtml="releasenote_wsr_1166dhpl2_jp.html"
	#AutoUpBin[0]="wsr-1166dhpl2_v100r221_crc_fw_jp.bin"
	#AutoUpBin[1]="wsr-1166dhpl2_v9999r9999_crc_fw_jp.bin"
	#AutoUpBin[2]="wsr-1166dhpl2_v9998r9998_crc_fw_jp.bin"
	#AutoUpBin[3]="wsr-1166dhpl2_v9997r9997_crc_fw_jp.bin"
	## BF-01D
	AutoUpTxt="wsr_5400ax6_jp.txt"
	AutoUpHtml="releasenote_wsr_5400ax6_jp.html"
	AutoUpBin[0]="WSR-5400AX6_v104r1042.bin"
	AutoUpBin[1]="WSR-5400AX6_v104r1043.bin"
	AutoUpBin[2]="WSR-5400AX6_v104r1044.bin"
	#AutoUpBin[3]="wsr-1166dhpl2_v9997r9997_crc_fw_jp.bin"
	

##
## Resolve Other Domains (works in internal mode)
##
	OtherDomains=Enabled
	#OtherDomains=Disabled

##
## Resolve NTP Domains (works in internal mode)
##
	NtpDomains=Enabled
	#NtpDomains=Disabled

##
## Interfaces
##
	## For DGW
	Interface_DGW=enp0s9
	## For LOCAL interface
	Interface_LO=lo

	## For CE1
	#Interface_LAN=enx1
	#Interface_1=${Interface_LAN}.1
	Interface_1=eth0

	## For CE2
	#Interface_2=${Interface_LAN}.2
	Interface_2=enx2

	## MAP-E Interface
	MapIf_1=map0
	MapIf_2=map1

	## DS-Lite Interface
	DslIf_1=dsl0

	## IPIP Interface
	IpipIf_1=ipip0

##
## EA-bit length for IPv6-Option
##
	## Avirable value is 18/19/20/21/22/24
	## EA18 --- CEv4:125.198.140.0, PSID:[10], CEv6:[2404:7a82:0800:1000:007d:c68c:0000:1000]
	## EA19 --- CEv4:125.196.208.0, PSID:[10], CEv6:[2404:7a82:0000:1000:007d:c4d0:0000:1000]
	## EA20 --- CEv4:125.194.192.0, PSID:[10], CEv6:[2404:7a82:a000:1000:007d:c2c0:0000:1000]
	## EA21 --- CEv4:133.203.160.0, PSID:[10], CEv6:[2404:7a82:2000:1000:0085:cba0:0000:1000]
	## EA22 --- CEv4:133.204.128.0, PSID:[10], CEv6:[2404:7a86:0000:1000:0085:cc80:0000:1000]
	## EA24 --- CEv4:133.200.0.0,   PSID:[10], CEv6:[2404:7a80:0000:1000:0085:c800:0000:1000]

	local EAbit_ipv6opt=24





## ---------------------------------------------------------
## NOTE: Basically you don't need to change following parameters.
## ---------------------------------------------------------


##
## Server Local-addr excluding prefix.
##
	local SrvLocalBase=0000:0000:0000:00f
	#local SrvLocalBase=aaaa:bbbb:cccc:fff
	SrvLocal_DGW=${SrvLocalBase}f
	#SrvLocal_LAN=${SrvLocalBase}0
	SrvLocal_1=${SrvLocalBase}1
	SrvLocal_2=${SrvLocalBase}2

##
## Dummy-Addr
##
	Dummyv6="2001::1"
	Dummyv4="11.0.255.1"
	DummyDomain="dummy.domain"

##
## Global variables Definition
##
	NumberOfCE=1
	ServiceType=0
	FLG_MAPE=0
	IPv6PrefixMode="N/A"
	FletsCrossMode="N/A"
	DHCPv4ServerMode=0
	PPPoEServerMode=0
	CEMode="N/A"
	Srvv6=0
	DnsDir="/var/cache/bind"
	ULPrefix64=fd44:ff00:00ff:0e00

##
## Server prefix
##
	##
	## 48bit-Prefix
	##
	local SrvPrefix48_v6plus_1=240b:0251:0220
	local SrvPrefix48_ipv6opt_1=`Get_SrvPrefix48_ipv6opt $EAbit_ipv6opt`
	local SrvPrefix48_ocnvc_1=2400:4050:0220
	#local SrvPrefix48_ocnvc_1=2400:4150:0220
	local SrvPrefix48_NGN=2001:a251:0e00
	#local SrvPrefix48_NGN=2408:03ff:0e00
	local SrvPrefix48_transix=2409:0251:0e00
	local SrvPrefix48_xpass=2001:0f70:0e00
	#local SrvPrefix48_v6Connect=1234:5678:90AB
	#local SrvPrefix48_v6Connect=2504:1234:5678
	local SrvPrefix48_v6Connect=2504:1234:0000
	local SrvPrefix48_CATV=2404:200:ff20

	## For CE2
	local SrvPrefix48_v6plus_2=240b:0010:0220
	local SrvPrefix48_ipv6opt_2=2404:7a84:0220
	local SrvPrefix48_ocnvc_2=2400:4150:0220

	## SrvPrefix48_Suffix
	local SrvPrefix48_Suffix_1=1000
	local SrvPrefix48_Suffix_1_alt=c000
	local SrvPrefix48_Suffix_2=2000
	local SrvPrefix48_Suffix_transix=3000
	local SrvPrefix48_Suffix_xpass=4000
	local SrvPrefix48_Suffix_v6Connect=5000
	local SrvPrefix48_Suffix_v6Connect_alt=d000
	local SrvPrefix48_Suffix_CATV=0

	local DutPrefix48_Suffix_1=1f00
	local DutPrefix48_Suffix_1_alt=cf00
	local DutPrefix48_Suffix_2=2f00
	#local DutPrefix48_Suffix_transix=3f00
	local DutPrefix48_Suffix_transix=3900
	local DutPrefix48_Suffix_xpass=4f00
	local DutPrefix48_Suffix_v6Connect=5f00
	local DutPrefix48_Suffix_v6Connect_alt=df00
	local DutPrefix48_Suffix_CATV=0400
	local DutPrefixEnd48_Suffix_CATV=04ef


	##
	## 64bit-Prefix
	##
	SrvPrefix_v6plus_1=$SrvPrefix48_v6plus_1:$SrvPrefix48_Suffix_1
	SrvPrefix_ipv6opt_1=$SrvPrefix48_ipv6opt_1:$SrvPrefix48_Suffix_1
	SrvPrefix_ocnvc_1=$SrvPrefix48_ocnvc_1:$SrvPrefix48_Suffix_1
	SrvPrefix_NGN=$SrvPrefix48_NGN:$SrvPrefix48_Suffix_1
	SrvPrefix_v6plus_1_alt=$SrvPrefix48_v6plus_1:$SrvPrefix48_Suffix_1_alt
	SrvPrefix_ipv6opt_1_alt=$SrvPrefix48_ipv6opt_1:$SrvPrefix48_Suffix_1_alt
	SrvPrefix_ocnvc_1_alt=$SrvPrefix48_ocnvc_1:$SrvPrefix48_Suffix_1_alt
	SrvPrefix_NGN_alt=$SrvPrefix48_NGN:$SrvPrefix48_Suffix_1_alt
	#SrvPrefix_NGN=fe80:0:0:0
	SrvPrefix_transix=$SrvPrefix48_transix:$SrvPrefix48_Suffix_transix
	SrvPrefix_xpass=$SrvPrefix48_xpass:$SrvPrefix48_Suffix_xpass
	SrvPrefix_v6Connect=$SrvPrefix48_v6Connect:$SrvPrefix48_Suffix_v6Connect
	SrvPrefix_v6Connect_alt=$SrvPrefix48_v6Connect:$SrvPrefix48_Suffix_v6Connect_alt
	SrvPrefix_CATV=$SrvPrefix48_CATV:$SrvPrefix48_Suffix_CATV

	## For CE2
	SrvPrefix_v6plus_2=$SrvPrefix48_v6plus_2:$SrvPrefix48_Suffix_2
	SrvPrefix_ipv6opt_2=$SrvPrefix48_ipv6opt_2:$SrvPrefix48_Suffix_2
	SrvPrefix_ocnvc_2=$SrvPrefix48_ocnvc_2:$SrvPrefix48_Suffix_2


##
## DUT prefix
##
	DutPrefix_v6plus_1=$SrvPrefix48_v6plus_1:$DutPrefix48_Suffix_1
	DutPrefix_ipv6opt_1=$SrvPrefix48_ipv6opt_1:$DutPrefix48_Suffix_1
	DutPrefix_ocnvc_1=$SrvPrefix48_ocnvc_1:$DutPrefix48_Suffix_1
	DutPrefix_NGN=$SrvPrefix48_NGN:$DutPrefix48_Suffix_1
	#DutPrefix_NGN=fe80:0:0:0
	DutPrefix_transix=$SrvPrefix48_transix:$DutPrefix48_Suffix_transix
	DutPrefix_xpass=$SrvPrefix48_xpass:$DutPrefix48_Suffix_xpass
	DutPrefix_v6Connect_ND=$SrvPrefix48_v6Connect:$SrvPrefix48_Suffix_v6Connect
	DutPrefix_v6Connect_NT=$SrvPrefix48_v6Connect:$DutPrefix48_Suffix_v6Connect
	DutPrefix_v6Connect_ND_alt=$SrvPrefix48_v6Connect:$SrvPrefix48_Suffix_v6Connect_alt
	DutPrefix_v6Connect_NT_alt=$SrvPrefix48_v6Connect:$DutPrefix48_Suffix_v6Connect_alt
	DutPrefix_CATV=$SrvPrefix48_CATV:$DutPrefix48_Suffix_CATV
	DutPrefixEnd_CATV=$SrvPrefix48_CATV:$DutPrefixEnd48_Suffix_CATV

	## For CE2
	DutPrefix_v6plus_2=$SrvPrefix48_v6plus_2:$DutPrefix48_Suffix_2
	DutPrefix_ipv6opt_2=$SrvPrefix48_ipv6opt_2:$DutPrefix48_Suffix_2
	DutPrefix_ocnvc_2=$SrvPrefix48_ocnvc_2:$DutPrefix48_Suffix_2


##
## MapE server v6 address
##
	#GlobalMapEv6_v6plus=2001:380:a120::9
	GlobalMapEv6_v6plus=2404:9200:255:100::64
	GlobalMapEv6_ipv6opt=$GlobalMapEv6_v6plus
	GlobalMapEv6_ocnvc=$GlobalMapEv6_v6plus
	GlobalMapEv6_NGN=2001:a7ff:5f01::a
	GlobalMapEv6_CATV=2404:200:ff20::a
	#GlobalMapEv6_transix=2404:8e00::feed:100
	GlobalMapEv6_transix=2404:8e01::feed:101
	GlobalMapEv6_xpass=2001:f60:0:200::1:1
	GlobalMapEv6_v6Connect=2405:6585:c40:700::1:1
	
##
## DGW-V4-Addr
##
	#DefaultGW_v4=192.168.128.1
	DefaultGW_v4=172.16.0.1
	DefaultRoute_v4=${DefaultGW_v4}50
	#Used in Throughput Measure Mode.
	DefaultGW_v4_2=192.168.10.10

	## WSR-1166DHP4 needs "p.buffalo.jp" to be resolved as global-v4 addr.
	Resolved_v4=157.7.164.171
	#Used in Throughput Measure Mode.
	Resolved_v4_2=192.168.5.1


##
## DUT-V4-Addr
##
	DutDHCPv4_NA=11.0.0
	DutPPPoEv4_NA=11.0.2

	## For CE1
	DutMapEv4_v6plus_1=14.11.2.32
	DutMapEv4_ipv6opt_1=`Get_DutMapEv4_ipv6opt $EAbit_ipv6opt`
	DutMapEv4_ocnvc_1=$DutMapEv4_v6plus_1
	DutTransixv4_1[0]=192.168.0.0/16
	DutTransixv4_1[1]=192.0.0.2/32
	DutTransixv4_1[2]=169.254.0.0/16
	DutPPPoEv4_1=$DutPPPoEv4_NA.101
	DutPPPoEv4_GW_1=$DutPPPoEv4_NA.1
	DutDHCPv4_1=$DutDHCPv4_NA.101
	DutDHCPv4_1_LAST=$DutDHCPv4_NA.110
	DutDHCPv4_GW_1=$DutDHCPv4_NA.1
	DutXpassv4_1[0]=192.168.0.0/16
	DutXpassv4_1[1]=192.0.0.2/32
	DutXpassv4_1[2]=169.254.0.0/16
	DutV6Connect_Dslite_v4_1[0]=192.168.0.0/16
	DutV6Connect_Dslite_v4_1[1]=192.0.0.2/32
	DutV6Connect_Dslite_v4_1[2]=169.254.0.0/16
	#RFC5737 TEST-NET-3, miniupnpcで処理が中断されるのでUPnPのテストには使用しない
	#DutV6Connect_Ipip_v4_1[0]=203.0.113.1/32
	DutV6Connect_Ipip_v4_1[0]=204.0.113.1/32


	## For CE2
	DutMapEv4_v6plus_2=106.72.2.32
	DutMapEv4_ipv6opt_2=$DutMapEv4_v6plus_2
	DutMapEv4_ocnvc_2=$DutMapEv4_v6plus_2
	DutPPPoEv4_2=$DutPPPoEv4_NA.102
	DutPPPoEv4_GW_2=$DutPPPoEv4_NA.2
	#DutDHCPv4_2=$DutDHCPv4_NA.102
	#DutDHCPv4_GW_2=$DutDHCPv4_NA.2


##
## DUT-V6-Addr
##
	## For CE1
	DutMapEv6_v6plus_ND_1=$SrvPrefix_v6plus_1:000e:0b02:2000:$SrvPrefix48_Suffix_1
	DutMapEv6_v6plus_ND_1_alt=$SrvPrefix_v6plus_1_alt:000e:0b02:2000:$SrvPrefix48_Suffix_1_alt
	DutMapEv6_v6plus_NT_1=$DutPrefix_v6plus_1:000e:0b02:2000:$DutPrefix48_Suffix_1
	DutMapEv6_ipv6opt_ND_1=$SrvPrefix_ipv6opt_1:`Get_DutMapEv6_SN_ipv6opt $EAbit_ipv6opt`:$SrvPrefix48_Suffix_1
	DutMapEv6_ipv6opt_ND_1_alt=$SrvPrefix_ipv6opt_1_alt:`Get_DutMapEv6_SN_ipv6opt $EAbit_ipv6opt`:$SrvPrefix48_Suffix_1_alt
	DutMapEv6_ipv6opt_NT_1=$DutPrefix_ipv6opt_1:`Get_DutMapEv6_SN_ipv6opt $EAbit_ipv6opt`:$DutPrefix48_Suffix_1
	DutMapEv6_ocnvc_ND_1=$SrvPrefix_ocnvc_1:000e:0b02:2000:$SrvPrefix48_Suffix_1
	DutMapEv6_ocnvc_ND_1_alt=$SrvPrefix_ocnvc_1_alt:000e:0b02:2000:$SrvPrefix48_Suffix_1_alt
	DutMapEv6_ocnvc_NT_1=$DutPrefix_ocnvc_1:000e:0b02:2000:$DutPrefix48_Suffix_1
	DutMapEv6_transix_ND=$SrvPrefix_transix:$DutLocal_1
	DutMapEv6_transix_NT=$DutPrefix_transix:$DutLocal_1
	DutMapEv6_xpass_ND=$SrvPrefix_xpass:$DutLocal_1
	DutMapEv6_xpass_NT=$DutPrefix_xpass:$DutLocal_1
	V6ConnectLocal_1=1:2:3:4
	return_v6connect_local() {
		if [ "$1" = "ipip" ]; then
			eval echo '$'V6ConnectLocal_1 ; 
		elif [ "$1" = "dslite" ]; then
			eval echo '$'DutLocal_1 ; 
		else
			echo "Error: not supported order($1)"
			exit 1;
		fi
	}
	DutMapEv6_v6Connect_ND() { echo $SrvPrefix_v6Connect:`return_v6connect_local $1`; }
	DutMapEv6_v6Connect_ND_alt() { echo $SrvPrefix_v6Connect_alt:`return_v6connect_local $1`; }
	DutMapEv6_v6Connect_NT() { echo $DutPrefix_v6Connect_NT:`return_v6connect_local $1`; }
	DutMapEv6_v6Connect_NT_alt() { echo $DutPrefix_v6Connect_NT_alt:`return_v6connect_local $1`; }

	## For CE2
	local DutMapEv6_Suffix_ND_2=006a:4802:2000:$SrvPrefix48_Suffix_2
	local DutMapEv6_Suffix_NT_2=006a:4802:2000:$DutPrefix48_Suffix_2
	DutMapEv6_v6plus_ND_2=$SrvPrefix_v6plus_2:$DutMapEv6_Suffix_ND_2
	DutMapEv6_v6plus_NT_2=$DutPrefix_v6plus_2:$DutMapEv6_Suffix_NT_2
	DutMapEv6_ipv6opt_ND_2=$SrvPrefix_ipv6opt_2:$DutMapEv6_Suffix_ND_2
	DutMapEv6_ipv6opt_NT_2=$DutPrefix_ipv6opt_2:$DutMapEv6_Suffix_NT_2
	DutMapEv6_ocnvc_ND_2=$SrvPrefix_ocnvc_2:$DutMapEv6_Suffix_ND_2
	DutMapEv6_ocnvc_NT_2=$DutPrefix_ocnvc_2:$DutMapEv6_Suffix_NT_2


##
## OPTION_VENDOR_OPTS: Enterprise-Number for transix
##
	OPTION_VENDOR_OPTS='option dhcp6.vendor-opts 00:00:00:D2:00:C9:00:06:74:03:BD:A9:1C:2E:00:CA:00:0A:30:35:32:32:36:35:36:30:30:32:00:CC:00:10:08:6E:74:74:2D:77:65:73:74:02:6E:65:02:6A:70:00:00:D2:00:1F:03:77:77:77:07:76:65:72:69:6E:66:6F:03:68:67:77:0A:66:6C:65:74:73:2D:77:65:73:74:02:6A:70:00;'

##
## V6MIG
##
	# Asahi-net v6Connect
	#V6MIG_4over6info_v6Connect="v=v6mig-1 url=https://prod.v6mig.v6connect.net/cpe/v1/config t=b"
	#V6MIG_4over6info_v6Connect="v=v6mig-1 url=https://prod.v6mig.v6connect.net/cpe/v1/config t=a"
	V6MIG_4over6info_v6Connect="v=v6mig-1 url=http://prod.v6mig.v6connect.net/cpe/v1/config t=a"
	#V6MIG_4over6info_v6Connect="v=v6mig-1 url= t=b"
	#V6MIG_4over6info_v6Connect=""
	V6MIG_ttl_v6Connect=86400
	V6MIG_enabler_name_v6Connect="朝日ネット"
	V6MIG_service_name_v6Connect="v6 コネクト"
	#V6MIG_service_name_v6Connect="<b>v6</b> <script>alert("hello")</script> コネクト"
	#V6MIG_service_name_v6Connect="ぶいろくこねくと！"
	V6MIG_dslite_aftr_v6Connect="dslite.v6connect.net"
	#V6MIG_dslite_aftr_v6Connect="2405:6585:c40:700::1:1"

	# Rakuten-mobile
	V6MIG_4over6info_rakutenMobile="v=v6mig-1 url=http://prov.isp.rakuten.jp/ t=a"
	V6MIG_ttl_rakutenMobile=259200
	V6MIG_enabler_name_rakutenMobile="Rakuten Mobile"
	V6MIG_service_name_rakutenMobile="Rakuten"
	V6MIG_dslite_aftr_rakutenMobile="gw.isp.rakuten.jp"

##
## V6MIG penetration
##
	# sedで置き換えているため '\' を入れ込むのに '\\\\' と書いている
	#V6MIG_enabler_name_v6Connect="<script>window.onload=function(){alert(\\\\\"朝日ネット\\\\\");}</script>"
	#V6MIG_service_name_v6Connect="<script>window.onload=function(){alert(\\\\\"v6 コネクト\\\\\");}</script>"
}


