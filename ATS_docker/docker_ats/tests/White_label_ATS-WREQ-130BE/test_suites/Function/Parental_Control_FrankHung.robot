*** Settings ***
Resource    ../base.robot
Library    Selenium2Library
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN_FrankHung.robot
Resource    ../../keyword/kw_Basic_WiFi_FrankHung.robot
Resource    ../../keyword/kw_WB_Mode_WPS_FrankHung.robot
Resource    ../../keyword/kw_Parental_Control.robot
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


Create SSID Name for auto test
    [Tags]    @AUTHOR=Frank_Hung    testing2
    ${result}=    Generate Random String    4    [NUMBERS]


    ${ssid_2G_1}=    Catenate    SEPARATOR=    2G_0123456789    ${result}
    ${ssid_2G_2}=    Set Variable    2G_abcdefghijklmnopqrstuvwxyz
    ${ssid_2G_3}=    Set Variable    2G_ABCDEFGHIJKLMNOPQRSTUVWXYZ
    ${ssid_2G_4}=    Set Variable    ~!@#$%^&*()_+{}|:"<>?`-=[]\\;',./
    ${ssid_2G_5}=    Catenate    SEPARATOR=    2G_00000000000000000009azAZ#    ${result}

    ${ssid_6G_1}=    Catenate    SEPARATOR=    6G_0123456789    ${result}
    ${ssid_5G_1}=    Catenate    SEPARATOR=    5G_0123456789    ${result}
    ${ssid_5G_2}=    Set Variable    5G_abcdefghijklmnopqrstuvwxyz
    ${ssid_5G_3}=    Set Variable    5G_ABCDEFGHIJKLMNOPQRSTUVWXYZ
    ${ssid_5G_4}=    Set Variable    ~!@#$%^&*()_+{}|:"<>?`-=[]\\;',./
    ${ssid_5G_5}=    Catenate    SEPARATOR=    5G_00000000000000000009azAZ#    ${result}

    ${ssid_guest}=    Catenate    SEPARATOR=    ${result}    -guest

    Set Suite Variable    ${ssid_2G_1}    ${ssid_2G_1}
    Set Suite Variable    ${ssid_2G_2}    ${ssid_2G_2}
    Set Suite Variable    ${ssid_2G_3}    ${ssid_2G_3}
    Set Suite Variable    ${ssid_2G_4}    ${ssid_2G_4}
    Set Suite Variable    ${ssid_2G_5}    ${ssid_2G_5}
    Set Suite Variable    ${ssid_6G_1}    ${ssid_6G_1}
    Set Suite Variable    ${ssid_5G_1}    ${ssid_5G_1}
    Set Suite Variable    ${ssid_5G_2}    ${ssid_5G_2}
    Set Suite Variable    ${ssid_5G_3}    ${ssid_5G_3}
    Set Suite Variable    ${ssid_5G_4}    ${ssid_5G_4}
    Set Suite Variable    ${ssid_5G_5}    ${ssid_5G_5}
    Set Suite Variable    ${wifi_password}    ghijGHIJK/
    Set Suite Variable    ${wifi_password_special}    ~!@#$%^&*()_+{}|:"<>?`-=[]\\;',./
    Set Suite Variable    ${wifi_password_64}    111111111111111111111111111111111111111111111111111111111111111
    Set Suite Variable    ${wifi_password_63}    zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
    Set Suite Variable    ${ssid_guest}    ${ssid_guest}


G-CPE-656 : Verify DUT can discover all connected devices(DHCP/Static, Wireless/Wired) on LAN, WLAN
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    ${wifi_password}
    Verify DUT can discover LAN PC and Wireless PC on Parental Control GUI    ${LAN_PC_MAC}    ${Wireless_PC_MAC}
    [Teardown]    upload result to testlink    G-CPE-656

G-CPE-228 : Remove and Rename device in list
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Add LAN PC and Wireless PC to Target Devices on GUI    ${LAN_PC_MAC}    ${Wireless_PC_MAC}
    Verify LAN PC and Wireless PC can be Remove from Tagret Devices on GUI    ${LAN_PC_MAC}    ${Wireless_PC_MAC}
    Add LAN PC and Wireless PC to Target Devices on GUI    ${LAN_PC_MAC}    ${Wireless_PC_MAC}
    Verify LAN PC and Wireless PC can be Rename from Tagret Devices on GUI    ${LAN_PC_MAC}    ${Wireless_PC_MAC}
    [Teardown]    upload result to testlink    G-CPE-228
















*** comments ***


*** Keywords ***
