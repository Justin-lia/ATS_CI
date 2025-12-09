*** Settings ***
Resource    ../base.robot
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../base.robot
Resource    ../../keyword/kw_Basic_WAN_FrankHung.robot
Resource    ../../keyword/kw_Basic_WiFi_FrankHung.robot
Resource    ../../keyword/kw_Basic_NAT_FrankHung.robot
Resource    ../../keyword/kw_testlink_FrankHung.robot
#Suite Setup    Open Web GUI    ${URL}
#Suite Setup    Open Web GUI and Reboot Wifi_Client    ${URL}
#Suite Setup    Open Web GUI and Reset to Default    ${URL}    ${DUT_Password}
#Suite Teardown    Login and Reset Default DUT        ${URL}    ${DUT_Password}

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

Create SSID Name for auto test
    [Tags]    @AUTHOR=Frank_Hung
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


Reset DUT
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Get DUT WAN IP

G-CPE-454 : NAT function - basic test
    [Tags]    @AUTHOR=Frank_Hung
    Verify LAN PC can access buffalo.jp
    Disable NAT on DUT
    Verify LAN PC cannot access buffalo.jp
    [Teardown]    upload result to testlink and Enable NAT on DUT    G-CPE-454

G-CPE-137 : L2TP Passthrough
    [Tags]    @AUTHOR=Frank_Hung
    Get DUT WAN IP
    Enable L2TP passthrough on DUT
    Verify LAN PC can Create a L2TP Connection
    [Teardown]    upload result to testlink    G-CPE-137


G-CPE-136 : PPTP Passthrough
    [Tags]    @AUTHOR=Frank_Hung
    Enable PPTP and IPSEC passthrough on DUT
    Verify LAN PC can Create a PPTP Connection
    [Teardown]    upload result to testlink    G-CPE-136


G-CPE-14 : Verify TCP port forwarding
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Create a Port forwarding Rule, [External Port] to 1000~2000, [Internal Port] to 1000~2000, [Protocol] to TCP
    LAN PC start capturing TCP packets
    With WAN PC send TCP packets to DUT WAN IP    1000
    Verify LAN PC can capture the TCP packets from WAN PC    1000

    LAN PC start capturing TCP packets
    With WAN PC send TCP packets to DUT WAN IP    1000
    Verify LAN PC cannot capture the TCP packets from WAN PC    2001
    [Teardown]    upload result to testlink    G-CPE-14

G-CPE-15 : Verify UDP port forwarding
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Create a Port forwarding Rule, [External Port] to 1000~2000, [Internal Port] to 1000~2000, [Protocol] to UDP
    LAN PC start capturing UDP packets
    With WAN PC send UDP packets to DUT WAN IP    1000
    Verify LAN PC can capture the UDP packets from WAN PC    1000

    LAN PC start capturing UDP packets
    With WAN PC send UDP packets to DUT WAN IP    1000
    Verify LAN PC cannot capture the UDP packets from WAN PC    2001
    [Teardown]    upload result to testlink    G-CPE-15

G-CPE-16 : Verify Both TCP and UDP port forwarding
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Create a Port forwarding Rule, [External Port] to 3000~4000, [Internal Port] to 3000~4000, [Protocol] to Both

    LAN PC start capturing TCP packets
    With WAN PC send TCP packets to DUT WAN IP    3000
    Verify LAN PC can capture the TCP packets on Port 3000 from WAN PC    3000

    LAN PC start capturing TCP packets
    With WAN PC send TCP packets to DUT WAN IP    3000
    Verify LAN PC cannot capture the TCP packets from WAN PC    4001

    LAN PC start capturing UDP packets
    With WAN PC send UDP packets to DUT WAN IP    3000
    Verify LAN PC can capture the UDP packets on Port 3000 from WAN PC    3000

    LAN PC start capturing UDP packets
    With WAN PC send UDP packets to DUT WAN IP    3000
    Verify LAN PC cannot capture the UDP packets from WAN PC    4001
    [Teardown]    upload result to testlink    G-CPE-16


G-CPE-135 : IP Address of DMZ
    [Tags]    @AUTHOR=Frank_Hung
    Enable DMZ option, Interface Selection field select to WAN1, Enter ip address of LAN PC in DMZ Host IP Address field
    LAN PC start capturing ICMP packets
    With WAN PC ping to DUT WAN IP
    Verify LAN PC can capture the ICMP packets from WAN PC
    [Teardown]    upload result to testlink    G-CPE-135


**** comments ****

























*** Keywords ***
upload result to testlink and Enable NAT on DUT
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Enable NAT on DUT


