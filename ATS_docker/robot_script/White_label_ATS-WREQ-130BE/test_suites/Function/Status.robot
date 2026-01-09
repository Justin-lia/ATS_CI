*** Settings ***
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../base.robot
Resource    ../../keyword/kw_Status.robot
Resource    ../../keyword/kw_Basic_WiFi.robot
Resource    ../../keyword/Variable.robot
Resource    ../../keyword/kw_testlink.robot
Library           Collections
Library           DateTime
Library           String
Library           OperatingSystem

*** Test Cases ***
Create SSID Name for auto test
    [Tags]    @AUTHOR=Frank_Hung    testing2
    ${result}=    Generate Random String    4    [NUMBERS]
    ${ssid_2G_1}=    Catenate    SEPARATOR=    2G_0123456789    ${result}
    ${ssid_2G_2}=    Set Variable    2G_abcdefghijklmnopqrstuvwxyz
    ${ssid_2G_3}=    Set Variable    2G_ABCDEFGHIJKLMNOPQRSTUVWXYZ
    ${ssid_2G_4}=    Set Variable    ~!@#$%^&*()_+{}|:"<>?`-=[]\\;',./
    ${ssid_2G_5}=    Catenate    SEPARATOR=    2G_00000000000000000009azAZ#    ${result}

    ${ssid_5G_1}=    Catenate    SEPARATOR=    5G_0123456789    ${result}
    ${ssid_5G_2}=    Set Variable    5G_abcdefghijklmnopqrstuvwxyz
    ${ssid_5G_3}=    Set Variable    5G_ABCDEFGHIJKLMNOPQRSTUVWXYZ
    ${ssid_5G_4}=    Set Variable    ~!@#$%^&*()_+{}|:"<>?`-=[]\\;',./
    ${ssid_5G_5}=    Catenate    SEPARATOR=    5G_00000000000000000009azAZ#    ${result}

    ${ssid_6G_1}=    Catenate    SEPARATOR=    6G_0123456789    ${result}
    ${ssid_6G_2}=    Set Variable    6G_abcdefghijklmnopqrstuvwxyz
    ${ssid_6G_3}=    Set Variable    6G_ABCDEFGHIJKLMNOPQRSTUVWXYZ
    ${ssid_6G_4}=    Set Variable    ~!@#$%^&*()_+{}|:"<>?`-=[]\\;',./
    ${ssid_6G_5}=    Catenate    SEPARATOR=    6G_00000000000000000009azAZ#    ${result}
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
    Set Suite Variable    ${ssid_6G_1}    ${ssid_6G_1}
    Set Suite Variable    ${ssid_6G_2}    ${ssid_6G_2}
    Set Suite Variable    ${ssid_6G_3}    ${ssid_6G_3}
    Set Suite Variable    ${ssid_6G_4}    ${ssid_6G_4}
    Set Suite Variable    ${ssid_6G_5}    ${ssid_6G_5}
    Set Suite Variable    ${wifi_password}    ghijGHIJK/
    Set Suite Variable    ${wifi_password_special}    ~!@#$%^&*()_+{}|:"<>?`-=[]\\;',./
    Set Suite Variable    ${wifi_password_64}    111111111111111111111111111111111111111111111111111111111111111
    Set Suite Variable    ${wifi_password_63}    zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
    Set Suite Variable    ${ssid_guest}    ${ssid_guest}

Default DUT
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Run    echo 'vagrant' | sudo -S netplan apply
    sleep    4
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

G-CPE-251 : IPv4 WAN Connection Status with DHCP mode
    [Tags]    @AUTHOR=Frank_Hung
    sleep    60
    Login GUI    ${URL}    ${DUT_Password}
    Open WAN Status Page
    Verify the status of Internet Connection is correct with DHCP mode
    [Teardown]    upload result to testlink    G-CPE-251

G-CPE-667 : Verify the status of Internet Connection is correct with Static mode
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Setup Static connection
    Open WAN Status Page
    Verify the status of Internet connection is correct with Static IP Mode
    [Teardown]    upload result to testlink    G-CPE-667

G-CPE-668 : Verify the status of Internet Connection is correct with PPPoE mode
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Setup PPPoE connection behind Login Status
    Open WAN Status Page
    Verify the status of Internet connection is correct with PPPoE Mode
    [Teardown]    upload result to testlink    G-CPE-668

G-CPE-253 : Check IPv4 Address
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Login GUI    ${URL}    ${DUT_Password}
    Open LAN Status Page
    Verify the status of Local Network is correct
    [Teardown]    upload result to testlink    G-CPE-253

G-CPE-264 : Click 2.4G Wifi Neighbor
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open WiFi Neighbor Page
    Verify shall shows 2.4G companion devices
    [Teardown]    upload result to testlink    G-CPE-264

G-CPE-265 : Click 5G Wifi Neighbor
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open WiFi Neighbor Page
    Verify shall shows 5G companion devices
    [Teardown]    upload result to testlink    G-CPE-65

G-CPE-266 : Click 6G Wifi Neighbor
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open WiFi Neighbor Page
    Verify shall shows 6G companion devices
    [Teardown]    upload result to testlink    G-CPE-266

Statistics - LAN Page
    [Tags]    @AUTHOR=Frank_Hung
    Verify LAN PC can access Internet
    Open Statistics Page
    Verify received/transmitted packets on Statistics LAN Page

G-CPE-261-263: Statistics - WLAN Page
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz Channel to 1 from GUI
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    ${wifi_password}
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    ${wifi_password}
    Change WiFi 6GHz SSID to "0123456789_6G_xxxx", Security to WPA3-PSK    ${ssid_6G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G_1}    ${wifi_password}
    Open Statistics Page
    Verify received/transmitted packets on Statistics WLAN Page
    [Teardown]    upload result to testlink for G-CPE-261-263    G-CPE-261    G-CPE-262    G-CPE-263

Mesh information
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open Mesh information Page
    Verify information is correct on Mesh Node List
    Verify information is correct on Mesh Client List

Dual Image Information
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Open Dual Image Page
    Verify information is correct on Dual Image page


***Keywords***
upload result to testlink for G-CPE-261-263
    [Arguments]    ${testCaseID}    ${testCaseID2}    ${testCaseID3}
    upload result to testlink    ${testCaseID}
    upload result to testlink    ${testCaseID2}
    upload result to testlink    ${testCaseID3}