*** Settings ***
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../base.robot
Resource    ../../keyword/kw_Basic_WAN.robot
Resource    ../../keyword/kw_Filter.robot
Resource    ../../keyword/Variable.robot
Resource    ../../keyword/kw_testlink.robot
Library           Collections
Library           DateTime
Library           String
Library           OperatingSystem

*** Test Cases ***

Default DUT
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Run    echo 'vagrant' | sudo -S netplan apply
    sleep    4
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Get DUT WAN IP

G-CPE-144 : Enable IPv4 Black list
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Enable IP Filtering on GUI
    Add a LAN PC to IPv4 Black list
    Verify LAN PC cannot access to Internet
    [Teardown]    upload result to testlink    G-CPE-144

G-CPE-146 : Remove IPv4 Black list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Remove LAN PC local address from Current Blacklist Filter Table
    Verify LAN PC can access Internet by wget
    [Teardown]    upload result to testlink    G-CPE-146



G-CPE-148 : Enable IPv6 Black list
    [Tags]    @AUTHOR=Frank_Hung
    Reboot LAN PC
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Enable IP Filtering on GUI
    Add a LAN PC to IPv6 Black list
    Verify LAN PC cannot access to WAN PC by iperf3
    [Teardown]    upload result to testlink    G-CPE-148

G-CPE-149 : Remove IPv6 Black list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Enable IP Filtering on GUI
    Remove LAN PC local address from Current Blacklist Filter Table
    Verify LAN PC can access to WAN PC by iperf3
    [Teardown]    upload result to testlink    G-CPE-149

G-CPE-150 : Enable IPv4 White list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Enable IP Filtering on GUI
    Add a LAN PC to IPv4 White list
    Verify LAN PC can access Internet by wget
    [Teardown]    upload result to testlink    G-CPE-150

G-CPE-152 : Remove IPv4 White list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Remove LAN PC local address from Current Blacklist Filter Table
    Verify LAN PC cannot access to Internet
    [Teardown]    upload result to testlink    G-CPE-152

G-CPE-153 : Enable IPv6 White list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Enable IP Filtering on GUI
    Add a LAN PC to IPv6 White list
    Verify LAN PC can access to WAN PC by iperf3
    [Teardown]    upload result to testlink    G-CPE-153

G-CPE-155 : Remove IPv6 White list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Enable IP Filtering on GUI
    Remove LAN PC local address from Current Blacklist Filter Table
    Verify LAN PC cannot access to WAN PC by iperf3
    [Teardown]    upload result to testlink    G-CPE-155

G-CPE-156 : Disable IP Filtering
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Enable IP Filtering on GUI
    Add a LAN PC to IPv4 Black list
    Login GUI    ${URL}    ${DUT_Password}
    Open IP Filtering page
    Disable IP Filtering on GUI and save Settings
    Verify LAN PC can access Internet by wget
    [Teardown]    upload result to testlink    G-CPE-156

G-CPE-158 : Enable Black list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open MAC Filtering page
    Enable MAC Filtering and add LAN PC IP Address to Black list
    Verify LAN PC cannot access to Internet
    [Teardown]    upload result to testlink    G-CPE-158

G-CPE-159 : Remove Black list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open MAC Filtering page
    Remove LAN PC local address from Current Blacklist Filter Table on MAC Filtering Page
    Verify LAN PC can access Internet by wget
    [Teardown]    upload result to testlink    G-CPE-159

G-CPE-160 : Enable White list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open MAC Filtering page
    Enable MAC Filtering and add LAN PC IP Address to White list
    Verify LAN PC can access Internet by wget
    [Teardown]    upload result to testlink    G-CPE-160

G-CPE-161 : Remove White list
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open MAC Filtering page
    Remove LAN PC local address from Current Blacklist Filter Table on MAC Filtering Page
    Verify LAN PC cannot access to Internet
    [Teardown]    upload result to testlink    G-CPE-161

G-CPE-162 : MAC Filtering GUI Check
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open MAC Filtering page
    Verify MAC address cannot be repeated
    Verify MAC address cannot be blank
    Verify MAC address format must be correct. ex: 98:10:E8:ED:4F:5D
    [Teardown]    upload result to testlink    G-CPE-162

***Keywords***
Reboot LAN PC
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S /sbin/shutdown -r +1
    sleep    60