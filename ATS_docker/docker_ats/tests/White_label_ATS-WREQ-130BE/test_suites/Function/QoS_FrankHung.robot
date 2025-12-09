*** Settings ***
Resource    ../base.robot
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN_FrankHung.robot
Resource    ../../keyword/kw_QoS_FrankHung.robot
Resource    ../../keyword/kw_AdvanceSetup_FrankHung.robot
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



Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

Verify Telnet access by LAN IP from LAN side
    [Tags]    @AUTHOR=Frank_Hung
    Enable Telent Service
    Create ACL TELNET rule cannot be in Disable state
    Verify LAN PC can access DUT by Telent

FN23QS001 Enable QoS for transmission to the Internet
    [Tags]    @AUTHOR=Frank_Hung
    Open QoS Page, enable the Internet Access Priority
    Select Bandwidth: Auto
    Select Category: Application
    Create 4 rules and save, TCP Port 50-60 (High), TCP Port 70-80 (Medium), TCP Port 90-100 (Normal), TCP Port 110-120 (Low)
    Use Iperf3, LAN PC send 4 traffics (Port 55,75,95,115) to WAN PC
    Use telnet to enter command qos-stat, verify there are four obvious options
    #Use console command qos-stat, verify there are four obvious options


FN23QS002 Enable QoS for transmission to the Internet
    [Tags]    @AUTHOR=Frank_Hung
    Open QoS Page, disable the Internet Access Priority
    Use Iperf3, LAN PC send 4 traffics (Port 55,75,95,115) to WAN PC
    #Use console command qos-stat, verify there are no four obvious options
    Use telnet to enter command qos-stat, verify there are no four obvious options

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}


FN23QS003 Internet Access Priority on, Auto, Application, TCP
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Open QoS Page, enable the Internet Access Priority
    Select Bandwidth: Auto
    Select Category: Application
    Create 4 rules and save, TCP Port 50-60 (High), TCP Port 70-80 (Medium), TCP Port 90-100 (Normal), TCP Port 110-120 (Low)
    Use Iperf3, LAN PC send 4 traffics (Port 55,75,95,115) to WAN PC
    Verify the throughput, bandwidth occupy rate: High (55) > Medium (75) > Normal (95) > Low (115)

FN23QS004 Internet Access Priority on, Manual 20 Mbps, Applications, TCP
    [Tags]    @AUTHOR=Frank_Hung
    Open QoS Page, enable the Internet Access Priority
    Select Bandwidth: Manual 20 MBps
    Use Iperf3, LAN PC send 4 traffics (Port 55,75,95,115) to WAN PC
    Verify the throughput, bandwidth occupy rate: High (55) > Medium (75) > Normal (95) > Low (115)

FN23QS005 Internet Access Priority on, Manual 51200 Kbps, Applications, TCP
    [Tags]    @AUTHOR=Frank_Hung
    Open QoS Page, enable the Internet Access Priority
    Select Bandwidth: Manual 51200 Kbps
    Use Iperf3, LAN PC send 4 traffics (Port 55,75,95,115) to WAN PC
    Verify the throughput, bandwidth occupy rate: High (55) > Medium (75) > Normal (95) > Low (115)

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

FN23QS006 Internet Access Priority on, Auto, Application, UDP
    [Tags]    @AUTHOR=Frank_Hung
    Open QoS Page, enable the Internet Access Priority
    Select Bandwidth: Auto
    Create 4 rules and save, UDP Port 50-60 (High), UDP Port 70-80 (Medium), UDP Port 90-100 (Normal), UDP Port 110-120 (Low)
    Use Iperf, LAN PC send 4 traffics (UDP Port 55,75,95,115) to WAN PC
    Verify the UDP throughput, bandwidth occupy rate: High (55) > Medium (75) > Normal (95) > Low (115)

FN23QS007 Internet Access Priority on, Manual 20 Mbps, Applications, UDP
    [Tags]    @AUTHOR=Frank_Hung
    Open QoS Page, enable the Internet Access Priority
    Select Bandwidth: Manual 20 MBps
    Use Iperf, LAN PC send 4 traffics (UDP Port 55,75,95,115) to WAN PC
    Verify the UDP throughput, bandwidth occupy rate: High (55) > Medium (75) > Normal (95) > Low (115)

FN23QS008 Internet Access Priority on, Manual 51200 Kbps, Applications, UDP
    [Tags]    @AUTHOR=Frank_Hung
    Open QoS Page, enable the Internet Access Priority
    Select Bandwidth: Manual 51200 Kbps
    Use Iperf, LAN PC send 4 traffics (UDP Port 55,75,95,115) to WAN PC
    Verify the UDP throughput, bandwidth occupy rate: High (55) > Medium (75) > Normal (95) > Low (115)



**** comments ****

























*** Keywords ***
