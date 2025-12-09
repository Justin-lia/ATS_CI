############################################
##                                        ##
##    Ubuntu MAP-E Test-Server v1.1.27    ##
##                                        ##
############################################


##
## Overview
##
-- MAP-E Rule distribution server simulator.
-- For developping and debugging MAP-E module.
-- "Ubuntu MAP-E Test-Server v1.x" is derived from "Ubuntu MapE Server v0.03".
-- Please see "USAGE.txt" for usage.


##
## Feature
##
-- Support several line types.
	--> v6-Plus (by JPNE)
	--> IPv6-Option (by Biglobe)
	--> OCN VirtualConnect (by NTTcomm)
	--> transix (by IIJ)
	--> Xpass (by ARTERIA)
	--> v6-Connect (by AsahiNet)
	--> NGN closed network (by NTT)
	--> PPPoE-server
	--> DHCPv4-server
	--> HGW environment
-- Support any types of Server error cases.
	--> 403
	--> 50x
	--> Http server stopped
	--> Invalid/Empty rule
-- Support MAP-E Inter-CE communication among 2CEs.
	--> Communication with a CE of which the CE-addr(IPv4) is different.
	--> **Limitation: CE-mode for same v4 address is not working.
-- Support NEC Router.
	--> PA-WG2600HS
	--> PA-WG2600HP3


##
## Supported Environment
##
[OS]
-- Ubuntu 16.04LTS
-- Ubuntu 18.04LTS

[VM]
-- VMWare Workstation 15
-- Virtual Box 6.0

[DUT]
-- WSR-2533DHP2/3
-- WSR-2533DHPL2
-- WSR-1166DHP4
-- WSR-1166DHPL2
-- WXR-1900DHP2/3
-- WXR-5950AX12
-- WXR-5700AX7S
-- WTR-M2133HP
-- NEC PA-WG2600HS
-- NEC PA-WG2600HP3
-- WSR-5400AX6

##
## Release Notes
##
v1.0 [2019/07/25]
-- Derived from "Ubuntu MapE Server v0.03".
-- Support p/J/B/O mode.
-- Support Internet connection. (NAT)
-- Support CE-mode for difference address CE.
-- Support NEC Router (PA-WG2600HS,PA-WG2600HP3).
v1.1.0 [2019/08/07]
-- Support P mode.
v1.1.1 [2019/08/08]
-- Support N/T mode.
v1.1.2 [2019/08/22]
-- Modify the local-DNS resolved IPv4-address to use Global address so that WSR-1166DHP4 working well.
v1.1.3 [2019/08/23]
-- Support D mode.
-- Change the basic command usage. Needs appropriate option to work.
v1.1.4 [2019/09/10]
-- Support HGW environment.
-- Add filter rule for DHCPv4 when it's used with IPv6 services.
v1.1.5 [2020/01/11]
-- Add E mode to make it selectable External Networking capability.
-- Add H mode to make it selectable HGW emulation.
-- Add Server connectivity easy checking page.
	--> by accessing "http://p.buffalo.jp" from DUT-LAN side PC browser.
-- Change Server interface to use "lo".
-- Change ServerLocal params to common value.
-- Removed Vender_id params.
v1.1.6 [2020/01/29]
-- Revert Server interface not to use "lo".
-- Support transix connectivity on NEC WG2600HS.
	--> "-p" option(-pT/-peT) is needed.
	--> WG2600HS uses "setup.trasix.jp" (contains json info.) for establishing the transix connection.
-- Add AutoUpdate server feature.
-- Add EA-bit length option (18/19/20/21/22bit) for IPv6-Option.
v1.1.7(by.m-ota) [2020/01/30]
-- **under checking!
-- Add F option(for Error reply 403/500/200(invalid)/9(No_response)/0(Empty_rule) ).
v1.1.8 [2020/01/31]
-- Fix MAP-E connectivity on NEC WG2600HP3.
	--> Side effect of v1.1.6.
-- Fix OCN-VC connectivity of -F option.
	--> Side effect of v1.1.7.
v1.1.9 [2020/02/12]
-- Fix transix connectivity on WSR-1166DHP4, WSR-1166DHPL2, WXR-1900DHP2/3, WXR-5950AX12.
	--> These models need to designate Internet connectivity option ("-e") for establishing the transix connection.
-- Fix AutoUpdate server feature.
	--> Add the support for FW ver.9.99/9.98/9.97 files.
v1.1.10 [2020/02/12]
-- Fix MAP-E keepalive test script (chkkpa.sh).
v1.1.11 [2020/03/26]
-- Add Flets-Cross Mode ("-x" option) which doesn't send RA to CPE but the DHCPv6 provides all necessary information instead.
-- Change IPv6, radvd, and dhcpd configuration to match with actual service environment.
v1.1.12 [2020/04/23]
-- Change prepared MAP-E prefix rules for IPv6-Option to follow Biglobe designated test sheet.
v1.1.13 [2020/06/22] by fukuda
-- Add Xpass Mode ("-X" option) which is similar to Transix using DS-Lite.
v1.1.14 [2020/06/24] by fukuda
-- Add Unique local prefix Mode ("-U" option) which uses unique local address.
-- Ready to update for WSR-1166DHPL2
v1.1.15 [2020/06/26] by fukuda
-- Add NAT rule (UDP any ---> *.*.*.1)
-- If you want to test UDP, input "sudo iptables -t nat -D PREROUTING 1" while the server is running.
v1.1.16 [2020/07/06] by fukuda
-- fix NAT rule(v1.1.15) (UDP any ---> *.*.*.75)
-- Add MANGLE rule (UDP if ttl < 10 then ttl=0)
-- Add Throughput Measure Mode ("-t" option). Use it when you measure DUT throughput by chariot console.
v1.1.17 [2020/07/08] by fukuda
-- fix Unique local prefix Mode ("-U" option) which uses prefix /56 with PD and /64 with RA.
v1.1.18 [2020/07/21] by fukuda
-- fix a little.
-- Add parameters DefaultGW_v4_2 and Resolved_v4_2 for Throughput Measure Mode.
v1.1.19 [2020/12/24] by ta.ono
-- Merge the "v6mig pseudo serv v0.06.2".
-- Support A mode and f/r option.
-- Support Asahi-net v6Connect.
v1.1.20 [2021/01/07] by ta.ono
-- Update document about v6Connect
v1.1.21 [2021/01/18] by ta.ono
-- Support F307 option for v6Connect.
v1.1.22 [2021/07/08] by ta.ono
-- Support v6Connect IPIP ("-A[ipip][,dslite][,ttl=<ttl>]" option).
-- Support RA preferred lifetime ("-l<sec>" option).
-- Support RA preferred lifetime zero ("-d" option).
-- Support alternative prefix notification ("-u" option).
   Node that "-ud" option can notify the alternatie prefix's prefferd lifetime to zero
-- Support Rakuten mobile ("-R" option).
v1.1.23 [2021/10/05] by ta.ono
-- Support Flet's Next mode ("-n" option).
v1.1.24 [2021/12/20] by ta.ono
-- Fix `cntn` initialization.
v1.1.25 [2022/02/07] by ta.ono
-- Update contents in airstation-ok.html, "setting-jp-Nietzsche.png" to "setting-jp-ok.png".
   Because WSR-3200AX4S can not connect DHCP.
-- Add CATV(for debug) configuration.
v1.1.26 [2022/07/01] by ta.ono
-- For testing RA advertise of notification of new prefix validation and old prefix invalidation by RA. (--with-invalid-old-prefix)
-- For testing DHCPv6 reply NoPrefixAvaild status code. (--NoPrefixAvail)
-- For testing DHCPv6 reply with rapid-commit. (--rapid-commit)
-- For testing RA(PIO) and DHCPv6-PD envioroment. (--native-and-passthrough)
-- For testing IA_NA adderss envioroment. (--iana-address)
-- For testing RA advertise of notification of new prefix validation and old prefix invalidation by RA. (--with-invalid-old-prefix)
-- For testing no reset ip6tables. (--no-reset-ip6tables)
v1.1.27 [2023/02/02] by ta.ono
-- Fix `--native-and-passthrough` because RA PIO must be sent for passthrough.


##
## Limitation, Known Bugs
##
-- CE-mode for same v4 address is not working.
