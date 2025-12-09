*** Settings ***
Resource    ../base.robot
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN_FrankHung.robot
Resource    ../../keyword/kw_testlink_FrankHung.robot
#Test Teardown    print debug message to console
Suite Setup    Up WAN Interface
#Suite Setup    Open Web GUI and Reboot Wifi_Client    ${URL}
#Suite Setup    Open Web GUI and Reset to Default    ${URL}    ${DUT_Password}
Suite Teardown    Up WAN Interface

*** Variables ***

*** Test Cases ***
#Reboot Wifi_Client
#    [Tags]    @AUTHOR=Frank_Hung
#    Reboot Wifi_Client_1 and Wifi_Client_2

#Detect GUI with Model Name
#    [Tags]
#    ${gui_type}     run keyword and return status    Page Should Contain Text    WSR-1166DHP
#    ${gui_type}    Convert to String    ${gui_type}
#    Should Contain    ${gui_type}    True

#Reboot from Consloe
#    [Tags]    @AUTHOR=Frank_Hung
#    Reboot DUT from Console

Reboot Cisco Router
    [Tags]    @AUTHOR=Frank_Hung
    v6 Server setup, M bit 1
    Reboot Cisco Router and waiting 180 seconds
    Up WAN Interface

Reboot LAN PC
    [Tags]    @AUTHOR=Frank_Hung
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S /sbin/shutdown -r +1
    sleep    60
    Up WAN Interface

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung    rebootTag
    Run    echo 'vagrant' | sudo -S netplan apply
    sleep    4
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Get DUT WAN IP



Create SSID Name for auto test
    [Tags]    @AUTHOR=Frank_Hung
    ${result}=    Generate Random String    8    [NUMBERS]
    ${ssid_2G}=    Catenate    SEPARATOR=    2G-    ${result}
    ${ssid_5G}=    Catenate    SEPARATOR=    5G-    ${result}
    ${ssid_5G_HB}=    Catenate    SEPARATOR=    5G-HB-    ${result}
    ${ssid_5G_HB_WPA3}=    Catenate    SEPARATOR=    5G-HB-WPA3-    ${result}
    ${ssid_2G_WPA3}=    Catenate    SEPARATOR=    2G-WPA3-    ${result}
    ${ssid_5G_WPA3}=    Catenate    SEPARATOR=    5G-WPA3-    ${result}
    ${ssid_guest}=    Catenate    SEPARATOR=    ${result}    -guest
    Set Suite Variable    ${ssid_guest}    ${ssid_guest}
    Set Suite Variable    ${ssid_2G}    ${ssid_2G}
    Set Suite Variable    ${ssid_5G}    ${ssid_5G}
    Set Suite Variable    ${ssid_5G_HB}    ${ssid_5G_HB}
    Set Suite Variable    ${ssid_5G_HB_WPA3}    ${ssid_5G_HB_WPA3}
    Set Suite Variable    ${ssid_2G_WPA3}    ${ssid_2G_WPA3}
    Set Suite Variable    ${ssid_5G_WPA3}    ${ssid_5G_WPA3}



#G-CPE-311 Temp Test Case
#    [Tags]    @AUTHOR=Frank_Hung    testing2
#    sleep    1
#    ${result}=    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S ping 192.168.1.1 -c 4    prompt=vagrant@WAN-host    timeout=150
#    [Teardown]    upload result to testlink    G-CPE-593



G-CPE-236 : Default Wan default connection
    [Tags]    @AUTHOR=Frank_Hung
    Verify Default WAN Mode is DHCP
    [Teardown]    upload result to testlink    G-CPE-236




G-CPE-12 : Automatic Configuration - DHCP
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to DHCP mode
    Verify LAN PC can access Internet
    Verify Internet Status is UP on GUI
    Verify DEVICES INFORMATION is correct on GUI for DHCP Mode
    [Teardown]    upload result to testlink    G-CPE-12


G-CPE-308 : Won’t get WAN Domain IP after unplug/plug the power cable of router when WAN is DHCP mode
    [Tags]    @AUTHOR=Frank_Hung    rebootTag
    LAN PC Renew IP for Verify FN23WN007
    LAN PC Start capture packet
    Power OFF than Power ON DUT
    Waiting 240 seconds
    Verify there is no DHCP packet sent from WAN
    [Teardown]    upload result to testlink    G-CPE-308


G-CPE-581 : PPPoE Mode Basic Settings
    [Tags]    @AUTHOR=Frank_Hung
    Up WAN Interface
    Setup WAN mode to PPPoE mode
    Verify LAN PC can access Internet
    Verify Internet Status is UP on GUI
    Verify DEVICES INFORMATION is correct on GUI for PPPoE Mode
    Check the PPPoE IP Address from GUI and other information are correct
    [Teardown]    upload result to testlink    G-CPE-581

G-CPE-309 : PPPoE with incorrect user name
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to PPPoE mode with incorrect user name
    Verify LAN PC cannot access Internet
    [Teardown]    upload result to testlink    G-CPE-309

G-CPE-310 : PPPoE with incorrect password
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to PPPoE mode with incorrect password
    Verify LAN PC cannot access Internet
    [Teardown]    upload result to testlink    G-CPE-310



G-CPE-582 : Static IP Mode Basic Settings
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to Static IP mode
    Verify LAN PC can access Internet
    Verify Internet Status is UP on GUI
    Verify DEVICES INFORMATION is correct on GUI for STATIC Mode
    [Teardown]    upload result to testlink    G-CPE-582

G-CPE-304 : WAN is static IP with munually set Address of Primary DNS Name Server
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to Static IP mode, correct IP in DNS1 and incorrect IP in DNS2
    Verify LAN PC can access buffalo.jp
    [Teardown]    upload result to testlink    G-CPE-304

G-CPE-305 : WAN is static IP with munually set Address of Secondary DNS Name Server
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to Static IP mode, incorrect IP in DNS1 and correct IP in DNS2
    Verify LAN PC can access buffalo.jp
    [Teardown]    upload result to testlink    G-CPE-305



G-CPE-13 : MTU Size of Internet Port
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to DHCP mode, MTU be "Manual", enter size be 1400
    WAN PC Start capture packet
    LAN PC ping WAN PC, using command "ping WAN PC IP -s 1450 -c 2"
    WAN PC check the ICMP packet has been Fragment (MTU is 1400)
    [Teardown]    upload result to testlink    G-CPE-13




#Case.FN23WN001 Dial Mode: Manual (PPPoE)
#    [Tags]    @AUTHOR=Frank_Hung
#    Setup WAN mode to PPPoE mode, Dial Mode: Manual
#    Verify LAN PC can access Internet

G-CPE-583 : When WAN mode is PPPoE, verify MTU Size
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to PPPoE mode, MTU(Default):Auto, Size:1492
    WAN PC Start capture packet
    LAN PC ping WAN PC, using command "ping WAN PC IP -s 1500 -c 2"
    WAN PC check the ICMP packet has been Fragment (MTU is 1492)
    Setup WAN mode to PPPoE mode, MTU Size:1300
    WAN PC Start capture packet
    LAN PC ping WAN PC, using command "ping WAN PC IP -s 1400 -c 2"
    WAN PC check the ICMP packet has been Fragment (MTU is 1300)
    [Teardown]    upload result to testlink    G-CPE-583

G-CPE-239 : PPPoE connection Test
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to PPPoE mode, MTU(Default):Auto, Size:1492, Dial Mode: on Demand
    Start capture PADT packets from WAN side
    Down LAN PC Network Interface
    Down ATS Server Interface
    Down Agent Interface
    Sleep    760
    Check there are PADT packets in WAN side about 11 minutes
    [Teardown]    upload result to testlink and Up LAN PC and ATS Server Network Interface    G-CPE-239

G-CPE-454 : NAT function - basic test
    [Tags]    @AUTHOR=Frank_Hung
    Disable NAT on DUT
    Verify LAN PC unable to ping 8.8.8.8 and 168.95.1.1
    [Teardown]    upload result to testlink    G-CPE-454


Reset DUT
    [Tags]    @AUTHOR=Frank_Hung    rebootTag
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

Reboot LAN PC - 2
    [Tags]    @AUTHOR=Frank_Hung
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S /sbin/shutdown -r +1
    sleep    60

G-CPE-584 : Verify DUT WAN Status, Get IPv6 Address: DHCPv6, M bit 1, O bit 1, Enable PD
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Verify on GUI, IP address : "get ip from RA(pd) ipv6 server", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"
    Check if LAN PC can get IPv6 address and can access IPv6 WAN host
    [Teardown]    upload result to testlink    G-CPE-584


G-CPE-585 : Verify DUT LAN PC Status, Get IPv6 Address: DHCPv6, M bit 1, O bit 1, Enable PD
    [Tags]    @AUTHOR=Frank_Hung
    Verify LAN PC get v6 IP from v6 Server: M bit 1, O bit 1
    [Teardown]    upload result to testlink    G-CPE-585

G-CPE-586 : Verify DUT WAN Status, Get IPv6 Address: SLAAC, M bit 0, O bit 1, Enable PD
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:SLAAC, PD enable
    Verify on GUI, IP address : "EUI-64", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"    ${ipv6_DUT_MAC}
    Check if LAN PC can get IPv6 address and can access IPv6 WAN host
    [Teardown]    upload result to testlink    G-CPE-586

G-CPE-587 : Verify DUT LAN PC Status, Get IPv6 Address: SLAAC, M bit 0, O bit 1, Enable PD
    [Tags]    @AUTHOR=Frank_Hung
    Verify LAN PC get v6 IP from v6 Server: M bit 0, O bit 1
    [Teardown]    upload result to testlink    G-CPE-587

G-CPE-588 : Verify DUT WAN Status, Get IPv6 Address: DHCPv6, M bit 1, O bit 1, Disable PD
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Disable
    GUI setup, Get IPv6 Address:DHCPv6, PD Disable
    Verify on GUI, IP address : "get ip from RA(pd) ipv6 server", Prefix Delegation : Null, Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"
    [Teardown]    upload result to testlink    G-CPE-588

G-CPE-589 : Verify DUT LAN PC Status, Get IPv6 Address: DHCPv6, M bit 1, O bit 1, Disable PD
    [Tags]    @AUTHOR=Frank_Hung
    Verify LAN PC get v6 IP Link-local: M bit 1, O bit 1, Disable PD
    [Teardown]    upload result to testlink and v6 Server setup, DHCPv6 Prefix Enable    G-CPE-589

G-CPE-590 : Verify DUT WAN Status, Get IPv6 Address: SLAAC, M bit 0, O bit 1, Disable PD
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Disable
    GUI setup, Get IPv6 Address:SLAAC, PD Disable
    Verify on GUI, IP address : "EUI-64", Prefix Delegation : Null, Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"    ${ipv6_DUT_MAC}
    [Teardown]    upload result to testlink    G-CPE-590

G-CPE-591 : Verify DUT LAN PC Status, Get IPv6 Address: SLAAC, M bit 0, O bit 1, Disable PD
    [Tags]    @AUTHOR=Frank_Hung
    Verify LAN PC get v6 IP Link-local: M bit 0, O bit 1
    [Teardown]    upload result to testlink and v6 Server setup, DHCPv6 Prefix Enable    G-CPE-591

Reboot LAN PC - 3
    [Tags]    @AUTHOR=Frank_Hung
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S /sbin/shutdown -r +1
    sleep    60


G-CPE-592 : Link Local Address
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    Sniffer PC start capture packet for FN23WN014
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Verify Router wan interface can generate its own link local address    ${DUT_WAN_Linklocal_IP}
    Verify Router performs DAD procedure (Neighbor Solicitation) before assigning the link local address to its interface    ${DUT_WAN_Linklocal_IP}
    verify The source address used in the subsequent Router Solicitation MUST be the link-local address on the WAN interface    ${DUT_WAN_Linklocal_IP}
    [Teardown]    upload result to testlink    G-CPE-592

G-CPE-593 : IPv6 Stateless Address Autoconfiguration
    [Tags]    @AUTHOR=Frank_Hung    rebootTag
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:SLAAC, PD enable
    Sniffer PC start capture packet for FN23WN015
    Power OFF than Power ON DUT
    sleep    300
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} down
#    sleep    2
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} up
#    sleep    4
    Verify Router sends out MLD report message to join solicited-node multicast address    ${DUT_WAN_Linklocal_IP}
    Verify Router wan interface can generate its own link local address    ${DUT_WAN_Linklocal_IP}
    Verify Router performs DAD procedure (Neighbor Solicitation) before assigning the link local address to its interface    ${DUT_WAN_Linklocal_IP}
    verify The source address used in the subsequent Router Solicitation MUST be the link-local address on the WAN interface    ${DUT_WAN_Linklocal_IP}
    Verify Accept valid Router Advertisement message from its neighboring router and configure itself with global unicast address plus default route
    [Teardown]    upload result to testlink    G-CPE-593

G-CPE-594 : WAN Router Discovery
    [Tags]    @AUTHOR=Frank_Hung
    sleep    60
    Verify on GUI, IP address : "EUI-64", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"    ${ipv6_DUT_MAC}
    [Teardown]    upload result to testlink    G-CPE-594

G-CPE-595 : Ethernet Support from Router WAN Link
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    Sniffer PC start capture packet for FN23WN017    ${DUT_WAN_Linklocal_IP}
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Verify the frame type in link layer is ether type of value 86DD
    [Teardown]    upload result to testlink    G-CPE-595

G-CPE-596 : Router WAN Interface Identifier Conforms to EUI-64
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:SLAAC, PD enable
    Verify on GUI, IP address : "EUI-64", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"    ${ipv6_DUT_MAC}
    [Teardown]    upload result to testlink    G-CPE-596

G-CPE-597 : Stateless Autoconfiguration Plus Stateful DHCPv6 Options (O-Flag=1)
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:SLAAC, PD enable
    Verify on GUI, IP address : "EUI-64", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"    ${ipv6_DUT_MAC}
    Verify LAN PC get v6 IP from v6 Server: M bit 0, O bit 1
    [Teardown]    upload result to testlink    G-CPE-597

G-CPE-598 : DHCP Information Request Message
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    Sniffer PC start capture packet for FN23WN020
    GUI setup, Get IPv6 Address:SLAAC, PD enable
    Verify Router needs to send a dhcp information request message to dhcp server, dhcp server replies with the configuration informations that Router requested
    [Teardown]    upload result to testlink    G-CPE-598

Reboot LAN PC - 4
    [Tags]    @AUTHOR=Frank_Hung
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S /sbin/shutdown -r +1
    sleep    60

G-CPE-599 : Release/Renew DHCPv6
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    Sniffer PC start capture packet for FN23WN021
    GUI setup, Get IPv6 Address:SLAAC, PD enable
    Verify from sniffer capture that Router sends out "dhcp release" message
    [Teardown]    upload result to testlink    G-CPE-599


G-CPE-601 : RA Message with M-Bit Sets to 1
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    Sniffer PC start capture packet for FN23WN023
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    verify that Router sends out dhcp solicitation (IA_NA option) after it detects the M bit sets to 1 in RA message
    Verify on GUI, IP address : "get ip from RA(pd) ipv6 server", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"
    Sniffer PC start capture packet for FN23WN023-2
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Verify Router recognizes the M bit in RA message and requesting dhcp server for IPv6 address instead
    [Teardown]    upload result to testlink    G-CPE-601


G-CPE-602 : Router Can get DHCP PD Even DHCP Flags: M = 0 & O = 0
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 0
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Verify on GUI, IP address : "get ip from RA(pd) ipv6 server", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"
    Check the IPv6 address in LAN PC,make sure LAN PC can get IP address, verify LAN PC can ping v6 server IP
    [Teardown]    upload result to testlink    G-CPE-602


G-CPE-603 : Router can get DHCP PD when DHCP Flags: M = 0 & O = 1
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:SLAAC, PD enable
    Verify on GUI, IP address : "EUI-64", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"    ${ipv6_DUT_MAC}
    Check the IPv6 address in LAN PC,make sure LAN PC can get IP address, verify LAN PC can ping v6 server IP
    [Teardown]    upload result to testlink    G-CPE-603

Reboot LAN PC - 5
    [Tags]    @AUTHOR=Frank_Hung
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S /sbin/shutdown -r +1
    sleep    60


G-CPE-604 : Router Can get DHCP PD when DHCP Flags: M = 1 & O = 0
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 0
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Verify on GUI, IP address : "get ip from RA(pd) ipv6 server", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"
    Check the IPv6 address in LAN PC,make sure LAN PC can get IP address, verify LAN PC can ping v6 server IP
    [Teardown]    upload result to testlink    G-CPE-604

G-CPE-605 : Router Can get DHCP PD when DHCP Flags: M = 1 & O =1
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Verify on GUI, IP address : "get ip from RA(pd) ipv6 server", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"
    Check the IPv6 address in LAN PC,make sure LAN PC can get IP address, verify LAN PC can ping v6 server IP
    [Teardown]    upload result to testlink    G-CPE-605

G-CPE-606 : Router Requests DHCP (IA_NA & IA_PD) Before RA Message
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    v6 Server setup, NOT send out Router Advertisement
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Verify on GUI, IP address : "get ip from RA(pd) ipv6 server", Prefix Delegation : "get Prefix from ipv6 server", Default Gate way: "get from ipv6 server", Primary DNS: "get from ipv6 server"
    Check the IPv6 address in LAN PC,make sure LAN PC can get IP address, verify LAN PC can ping v6 server IP
    [Teardown]    upload result to testlink and v6 Server setup, send out Router Advertisement    G-CPE-606



G-CPE-607 : [WPD-6]IPv6 CE router requests both an IA_NA and an IA_PD in DHCPv6 MUST accept an IA_PD in DHCPv6 Advertise/Reply messages, even if the message does not contain any addresses
    [Tags]    @AUTHOR=Frank_Hung    rebootTag
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    v6 Server setup, remove the IA_NA in DHCPv6 setting
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Power OFF than Power ON DUT
    sleep    240
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} down
#    sleep    2
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} up
#    sleep    4
    Check if LAN PC can get IPv6 address and can access IPv6 WAN host
    [Teardown]    upload result to testlink and v6 Server setup, add the IA_NA in DHCPv6 setting    G-CPE-607



















***Comments***


Case.FN23WN022 M14.6: DHCP Decline Message
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 1
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:DHCPv6, PD enable
    Get DUT v6 IP Address, assign it to Sniffer PC
    Sniffer PC start capture packet for FN23WN022
    Power OFF than Power ON DUT
    sleep    240
    Verify Router will send out "Dhcp Decline" message back to the dhcp server
    [Teardown]    Sniffer PC down up interface

    #sudo ifconfig eth0 inet6 add 2001:db8:1234:5678::2/64

Case.FN23WN029 M12.4: Duplicate Address Detection (DAD)
    [Tags]    @AUTHOR=Frank_Hung
    [Setup]    Clear Cisco Router Port    ${Console_Port_Number_Clear}
    v6 Server setup, M bit 0
    v6 Server setup, O bit 1
    v6 Server setup, DHCPv6 Prefix Enable
    GUI setup, Get IPv6 Address:SLAAC, PD enable
    ${DUT_v6_IP}=    Get DUT v6 IP Address, assign it to Sniffer PC for SLAAC
    Power OFF than Power ON DUT
    sleep    240
    Verify DUT WAN v6 IP should be changed    ${DUT_v6_IP}









*** Keywords ***
upload result to testlink and Up LAN PC and ATS Server Network Interface
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Up LAN PC and ATS Server Network Interface

upload result to testlink and v6 Server setup, DHCPv6 Prefix Enable
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    v6 Server setup, DHCPv6 Prefix Enable

upload result to testlink and v6 Server setup, send out Router Advertisement
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    v6 Server setup, send out Router Advertisement

upload result to testlink and v6 Server setup, add the IA_NA in DHCPv6 setting
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    v6 Server setup, add the IA_NA in DHCPv6 setting



