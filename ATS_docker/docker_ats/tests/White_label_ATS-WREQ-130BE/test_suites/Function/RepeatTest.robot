*** Settings ***
Resource    ../base.robot
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN.robot
Resource    ../../keyword/kw_Application.robot
Resource    ../../keyword/kw_Basic_WiFi.robot
Resource    ../../keyword/kw_Basic_NAT.robot

*** Variables ***

*** Test Cases ***

Repeat Test Case
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Repeat Keyword    9000 times    Send Traffic from LAN PC to WAN PC

***comment***

*** Keywords ***
Send Traffic from LAN PC to WAN PC
    Verify LAN PC can ping to 8.8.8.8
    Verify LAN PC can stend traffic to WAN PC
    Verify LAN PC can ping to 8.8.8.8
    Power OFF than Power ON DUT
    Waiting 180 seconds
    Waiting 10 seconds for log to Console

WiFi Connection Test 2.4GHz
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_2G_1}    ${wifi_password}

Power-off than Power-on DUT
    Power OFF than Power ON DUT
    Waiting 180 seconds
    Login GUI    ${URL}    ${DUT_Password}
    Close Browser

FN23WN006 Automatic Configuration - DHCP
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to DHCP mode
    Verify LAN PC can access Internet

FN23WN008 PPPoE
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to PPPoE mode
    Verify LAN PC can access Internet

FN23WN012 When WAN is DHCP, verify optional setting, MTU Size of Internet Port
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to DHCP mode, MTU be "Manual", enter size be 1400
    WAN PC Start capture packet
    LAN PC ping WAN PC, using command "ping WAN PC IP -s 1450 -c 2"
    WAN PC check the ICMP packet has been Fragment (MTU is 1400)

FN23WN011 Verify when WAN is static IP with munually set Address of Secondary DNS Name Server
    [Tags]    @AUTHOR=Frank_Hung
    Setup WAN mode to Static IP mode, incorrect IP in DNS1 and correct IP in DNS2

Case.FN23PS001 L2TP pass-through
    [Tags]    @AUTHOR=Frank_Hung
    #Enable L2TP passthrough on DUT
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx", Security to WPA2-PSK    ${ssid_5G_1}    ${wifi_password_64}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_5G_1}    ${wifi_password_64}
    #Verify Wirelss PC can Create a L2TP Connection

