*** Settings ***
Resource    ../base.robot
Library    Selenium2Library
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN.robot
Resource    ../../keyword/kw_Basic_WiFi.robot
Resource    ../../keyword/kw_WB_Mode_WPS.robot
Resource    ../../keyword/kw_Parental_Control.robot
Resource    ../../keyword/kw_testlink.robot

*** Variables ***

*** Test Cases ***

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

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
