*** Settings ***
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../base.robot
Resource    ../../keyword/kw_basic_LAN.robot
Resource    ../../keyword/Variable.robot
Library           Collections
Library           DateTime
Library           String
Library           OperatingSystem
#Variables		Myvariable.yaml
Suite Teardown    Telnet.Close All Connections

*** Test Cases ***

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung    rebootTag
	#open browser	192.168.1.1
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Get DUT WAN IP

G-CPE-7 : Verify default setting of DHCP server
    [Tags]    @AUTHOR=Frank_Hung	gcpe7
    Verify LAN PC can get ip from DUT
    Verify LAN PC can access WebGUI
#    [Teardown]    upload result to testlink    G-CPE-7

G-CPE-617 : Verify LAN IP change to 192.168.0.0/16
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Change DUT LAN IP adddress and subnet mask config 192.168.0.1/255.255.0.0
    Verify LAN IP change to 192.168.0.0/16
    sleep    1

***Keywords***

G-CPE-618 : Verify LAN IP change to 172.56.0.0/16
    [Tags]    @AUTHOR=Frank_Hung    blockTag
    Change DUT LAN IP adddress and subnet mask config 172.56.0.1/255.255.0.0
    Verify LAN IP change to 172.56.0.0/16
    [Teardown]    upload result to testlink and Change DUT LAN IP to Default from GUI    172.56.0    G-CPE-618

G-CPE-619 : Verify LAN IP change to 10.0.0.0/8
    [Tags]    @AUTHOR=Frank_Hung
    Change DUT LAN IP adddress and subnet mask config 10.0.0.1/255.0.0.0
    Verify LAN IP change to 10.0.0.0/8
    [Teardown]    upload result to testlink and Change DUT LAN IP to Default from GUI    10.0.0    G-CPE-619

G-CPE-5 : Verify that LAN Side IP Address can be changed
    [Tags]    @AUTHOR=Frank_Hung
    Change DUT LAN IP adddress and subnet mask config 192.168.2.1/255.255.255.0
    Verify LAN IP change to 192.168.2.1/24
    [Teardown]    upload result to testlink and Change DUT LAN IP to Default from GUI    192.168.2    G-CPE-5

G-CPE-6 : Verify that Subnet Mask can be changed
    [Tags]    @AUTHOR=Frank_Hung
    Change DUT LAN IP adddress and subnet mask config 192.168.0.1/255.255.0.0
    Verify the Subnet Mask should be 255.255.0.0
    [Teardown]    upload result to testlink and Change DUT LAN IP to Default from GUI    192.168.0    G-CPE-6

G-CPE-8 : Verify DHCP server disabled
    [Tags]    @AUTHOR=Frank_Hung
    Disable DUT LAN DHCP v4 Server
    Check client can not get ip from DUT
    Enable DUT LAN DHCP v4 Server
    [Teardown]    upload result to testlink    G-CPE-8

G-CPE-9 : Change DHCP server setting
    [Tags]    @AUTHOR=Frank_Hung
    Set DUT LAN IP address be 192.168.123.1 and change Start IP Address to 192.168.123.50, Maximum Number of Users to 25, Client Lease Time to 3 minutes, DNS(8.8.8.8)
    Verify on LAN PC, the DHCP related information is as the setting
    [Teardown]    upload result to testlink and Change DUT LAN IP to Default from GUI    192.168.123    G-CPE-9

G-CPE-620 : Manually Add Client on Reserved IP Address Settings
    [Tags]    @AUTHOR=Frank_Hung
    On Basic Setup > LAN Page, click "DHCP Reservation" button, Enter Client Name, Assign IP Address, To This MAC Address and click "Add" button in Manually Add Client
    Verify the information of client are added in the Client Already Reserved
    [Teardown]    upload result to testlink    G-CPE-620

G-CPE-621 : Edit Clients Already Reserved
    [Tags]    @AUTHOR=Frank_Hung
    Edit Client Name, Assign IP Address and click "Save" button in Clients Already Reserved
    Verify the Assign IP Address is Correct on LAN PC
    [Teardown]    upload result to testlink    G-CPE-621

G-CPE-622 : Delete Clients Already Reserved
    [Tags]    @AUTHOR=Frank_Hung
    Delete Clients Already Reserved, verify client list is correct
    [Teardown]    upload result to testlink    G-CPE-622

G-CPE-623 : Clients Already Reserved
    [Tags]    @AUTHOR=Frank_Hung
    Add an IP 192.168.1.201 to DHCP Reservation, verify GUI show error message
    [Teardown]    upload result to testlink    G-CPE-623


upload result to testlink and Change DUT LAN IP to Default from GUI
    [Arguments]    ${network_segment}    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Change DUT LAN IP to Default from GUI    ${network_segment}
