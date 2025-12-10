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

Create SSID Name for auto test
    [Tags]    @AUTHOR=Frank_Hung    testing2
    ${result}=    Generate Random String    4    [NUMBERS]
    ${ssid_2G_1}=    Catenate    SEPARATOR=    2G_0123456789    ${result}
    ${ssid_2G_2}=    Set Variable    2G_abcdefghijklmnopqrstuvwxyz
    ${ssid_2G_3}=    Set Variable    2G_ABCDEFGHIJKLMNOPQRSTUVWXYZ
    ${ssid_2G_4}=    Set Variable    ~!@#$%^&*()_+{}|:"<>?`-=[]\;',./
    ${ssid_2G_5}=    Catenate    SEPARATOR=    2G_00000000000000000009azAZ#    ${result}
    ${ssid_5G_1}=    Catenate    SEPARATOR=    5G_0123456789    ${result}
    ${ssid_5G_2}=    Set Variable    5G_abcdefghijklmnopqrstuvwxyz
    ${ssid_5G_3}=    Set Variable    5G_ABCDEFGHIJKLMNOPQRSTUVWXYZ
    ${ssid_5G_4}=    Set Variable    ~!@#$%^&*()_+{}|:"<>?`-=[]\;',./
    ${ssid_5G_5}=    Catenate    SEPARATOR=    5G_00000000000000000009azAZ#    ${result}
    ${ssid_guest}=    Catenate    SEPARATOR=    ${result}    -guest
    Set Suite Variable    ${ssid_2G_1}    ${ssid_2G_1}
    Set Suite Variable    ${ssid_2G_2}    ${ssid_2G_2}
    Set Suite Variable    ${ssid_2G_3}    ${ssid_2G_3}
    Set Suite Variable    ${ssid_2G_4}    ${ssid_2G_4}
    Set Suite Variable    ${ssid_2G_5}    ${ssid_2G_5}
    Set Suite Variable    ${ssid_5G_1}    ${ssid_5G_1}
    Set Suite Variable    ${ssid_5G_2}    ${ssid_5G_2}
    Set Suite Variable    ${ssid_5G_3}    ${ssid_5G_3}
    Set Suite Variable    ${ssid_5G_4}    ${ssid_5G_4}
    Set Suite Variable    ${ssid_5G_5}    ${ssid_5G_5}
    Set Suite Variable    ${wifi_password}    ghijGHIJK/
    Set Suite Variable    ${wifi_password_64}    1111111111111111111111111111111111111111111111111111111111111111
    Set Suite Variable    ${wifi_password_63}    zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
    Set Suite Variable    ${ssid_guest}    ${ssid_guest}

Set ATS Server IP Address
    [Tags]    @AUTHOR=Frank_Hung
    Run    sudo ifconfig eth3 192.168.1.51 netmask 255.255.255.0

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Repeat Keyword    20 times    Login and Reset Default DUT        ${URL}    ${DUT_Password}

Reboot DUT
    [Tags]    @AUTHOR=Frank_Hung
    Repeat Keyword    10 times    Reboot DUT from GUI    ${URL}    ${DUT_Password}

WAN Repeat Test
    [Tags]    @AUTHOR=Frank_Hung
    Repeat Keyword    10 times    FN23WN011 Verify when WAN is static IP with munually set Address of Secondary DNS Name Server

Repeat L2TP pass-through
    [Tags]    @AUTHOR=Frank_Hung
    Repeat Keyword    10 times    Case.FN23PS001 L2TP pass-through

Power-off than Power-on DUT Repeat Test
    [Tags]    @AUTHOR=Frank_Hung
    Repeat Keyword    20 times    Power-off than Power-on DUT

WiFi Connection Test
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Repeat Keyword    20 times    WiFi Connection Test 2.4GHz

***comment***

*** Keywords ***

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

