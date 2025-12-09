*** Settings ***
Resource    ../base.robot
Library    Selenium2Library
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN_FrankHung.robot
Resource    ../../keyword/kw_HomePage.robot
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

#Set ATS Server IP Address
#    [Tags]    @AUTHOR=Frank_Hung
#    Run    echo 'vagrant' | sudo -S ifconfig enp6s0 192.168.1.51 netmask 255.255.255.0

#Reset DUT using Console
#    [Tags]    @AUTHOR=Frank_Hung
#    Reset DUT from Console




#Add a Static route
#    [Tags]    @AUTHOR=Frank_Hung
#    Run    echo 'vagrant' | sudo -S dhclient ${ATS_to_DUT_Interface} -r
#    sleep    2
#    Run    echo 'vagrant' | sudo -S ip addr add 192.168.1.52/24 dev ${ATS_to_DUT_Interface}
#    sleep    2
#    Run    echo 'vagrant' | sudo -S ip route add 192.168.1.0/24 via 0.0.0.0 dev ${ATS_to_DUT_Interface}

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
#    Run    echo "vagrant" | sudo -S chmod 777 /dev/ttyUSB0
#    ${result}=    cli    DUT_serial_port    /opt/bin/restore_to_default.sh    prompt=#
#    sleep    240
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
#    Run    python3 /home/vagrant/apc_script_power_off_to_on_port8.py
#    sleep    240
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} down
#    sleep    2
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} up
#    sleep    4
#    Login and Reset Default DUT        ${URL}    ${DUT_Password}

G-CPE-272 : Internet Status
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Verify Internet Status should be up
    [Teardown]    upload result to testlink    G-CPE-272

G-CPE-275 : Internet Address
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Internet Address should be 172.16.11.x
    [Teardown]    upload result to testlink    G-CPE-275

G-CPE-273 : Online device list
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Number of Online device lists should greater than 1
    [Teardown]    upload result to testlink    G-CPE-273

G-CPE-274 : Protocol
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Default Protocol of WAN Port should be DHCP
    Setup WAN mode to Static IP mode
    Verify the Protocol of WAN Port should be Static
    Setup WAN mode to PPPoE mode
    Verify the Protocol of WAN Port should be PPPoE
    [Teardown]    upload result to testlink    G-CPE-274

G-CPE-276 : Primary DNS
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Primary DNS should be 168.95.1.1
    [Teardown]    upload result to testlink    G-CPE-276

G-CPE-277 : Secondary DNS
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Setup WAN mode to Static IP mode
    Verify the Secondary DNS should be 8.8.8.8
    [Teardown]    upload result to testlink    G-CPE-277

G-CPE-278 : MacAddress
    [Tags]    @AUTHOR=Frank_Hung
    Verify the MacAddress should not be Empty
    [Teardown]    upload result to testlink    G-CPE-278

G-CPE-267 : Manufacture
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Manufacturer should be Gemtek Technology Co.
    [Teardown]    upload result to testlink    G-CPE-267

G-CPE-268 : Serial Number
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Serial Number should Not be Empty
    [Teardown]    upload result to testlink    G-CPE-268

G-CPE-269 : Firmware Version
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Firmware Version should Not be Empty
    [Teardown]    upload result to testlink    G-CPE-269

G-CPE-270 : Model Name
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Model Name should be    ${Product_Name}
    [Teardown]    upload result to testlink    G-CPE-270

G-CPE-271 : Hardware Version
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Hardware Version should Not be Empty
    [Teardown]    upload result to testlink    G-CPE-271

G-CPE-279 : WAN interface
    [Tags]    @AUTHOR=Frank_Hung
    Verify the WAN Port should be Active
    [Teardown]    upload result to testlink    G-CPE-279

G-CPE-280 : LAN interface 1
    [Tags]    @AUTHOR=Frank_Hung
    Verify the LAN1 Port should be Inactive
    [Teardown]    upload result to testlink    G-CPE-280

G-CPE-281 : LAN interface 2
    [Tags]    @AUTHOR=Frank_Hung
    Verify the LAN2 Port should be Inactive
    [Teardown]    upload result to testlink    G-CPE-281

G-CPE-282 : LAN interface 3
    [Tags]    @AUTHOR=Frank_Hung
    Verify the LAN3 Port should be Active
    [Teardown]    upload result to testlink    G-CPE-282

G-CPE-283 : LAN interface 4
    [Tags]    @AUTHOR=Frank_Hung
    Verify the LAN4 Port should be Active
    Close Browser
    [Teardown]    upload result to testlink    G-CPE-283



















*** Keywords ***
