*** Settings ***
Resource    ../base.robot
Library    Selenium2Library
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN.robot
Resource    ../../keyword/kw_Basic_WiFi.robot
Resource    ../../keyword/kw_WB_Mode_WPS.robot
Resource    ../../keyword/kw_testlink.robot
Suite Setup    Up WAN Interface
Suite Teardown    Up WAN Interface

*** Variables ***
${Channel_1}    1
${Channel_11}    11


*** Test Cases ***

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung

    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Change WiFi 6GHz Channel to 1 from GUI
    Down Agent Interface
    Get DUT WAN IP

Create SSID Name for auto test
    [Tags]    @AUTHOR=Frank_Hung    testing2
    ${result}=    Generate Random String    4    [NUMBERS]

    ${ssid_2G_1}=    Catenate    SEPARATOR=    2G_0123456789    ${result}
    ${ssid_2G_2}=    Set Variable    2G_abcdefghijklmnopqrstuvwxyz
    ${ssid_2G_3}=    Set Variable    2G_ABCDEFGHIJKLMNOPQRSTUVWXYZ
    ${ssid_2G_4}=    Set Variable    ~!@#$%^&*()_+{}|:"<>?`-=[]\\;',./
    ${ssid_2G_5}=    Catenate    SEPARATOR=    2G_00000000000000000009azAZ#    ${result}
    ${ssid_common}=    Catenate    SEPARATOR=    common_    ${result}

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
    Set Suite Variable    ${ssid_common}    ${ssid_common}
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

Delete WiFi Profile and Reboot Wirless PC
     [Tags]    @AUTHOR=Frank_Hung
     Wait Until Keyword Succeeds    3x    2s    cli    wifi_client    echo '${DEVICES.wifi_client.password}' | sudo -S find /etc/NetworkManager/system-connections/ ! -name '${WirelessPC1_telnet_Profile}' ! -name 'l2tp-test-2.nmconnection' -type f -delete    prompt=gemtek@gemtek    timeout=30
     Wait Until Keyword Succeeds    3x    2s    cli    wifi_client    echo '${DEVICES.wifi_client.password}' | sudo -S /sbin/shutdown -r    prompt=scheduled    timeout=70
     sleep    60

Delete WiFi Profile and Reboot Wirless PC2
     [Tags]    @AUTHOR=Frank_Hung
     Wait Until Keyword Succeeds    3x    2s    cli    wifi_client2    echo '${DEVICES.wifi_client2.password}' | sudo -S find /etc/NetworkManager/system-connections/ ! -name '${WirelessPC2_telnet_Profile}' ! -name 'l2tp-test-2.nmconnection' -type f -delete    prompt=gemtek@gemtek    timeout=30
     Wait Until Keyword Succeeds    3x    2s    cli    wifi_client2    echo '${DEVICES.wifi_client2.password}' | sudo -S /sbin/shutdown -r    prompt=scheduled    timeout=70
     sleep    60

G-CPE-1 : Wireless default setting check
    [Tags]    @AUTHOR=Frank_Hung
    Verify Common SSID Enabled : ON and MLO Default is : disable
    Get DUT WAN IP
    [Teardown]    upload result to testlink    G-CPE-1

G-CPE-2 : 2G SSID default Value
    [Tags]    @AUTHOR=Frank_Hung    consoleTag    testing2
    Disable Common SSID on GUI
    Verify 2.4G SSID Default Value is Gemtek_Wifi7_2G_XXXXXX
    ${default_password}    Get Default WiFi Password
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_default}    ${default_password}
    [Teardown]    upload result to testlink    G-CPE-2

G-CPE-20 : 2G default Authentication check
    [Tags]    @AUTHOR=Frank_Hung    consoleTag
    Verify the 2.4G default Authentication setting should Be WPA3/WPA2 PSK
    [Teardown]    upload result to testlink    G-CPE-20

G-CPE-22 : 2G WPA Preshare key default Value check
    [Tags]    @AUTHOR=Frank_Hung    consoleTag
    ${default_password}    Get Default WiFi Password
    Verify WiFi 2.4GHz WPA Preshare key default Value    ${ssid_2G_default}    ${default_password}
    [Teardown]    upload result to testlink    G-CPE-22

G-CPE-21 : 2G security type WPA3/WPA2 PAK check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_2G_1}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-21

G-CPE-23 : 2G WPA Preshare key minimum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz Preshare key to 8 bit input and click "Save"    ${ssid_2G_1}    87654321
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    87654321
    [Teardown]    upload result to testlink    G-CPE-23

G-CPE-26 : 2G WPA Preshare key special format input check
    [Tags]    @AUTHOR=Frank_Hung
    Verify "1 345678" can input to 2.4G Password Field and click "Save"    ${ssid_2G_1}    1${SPACE}345678
    Verify Wireless PC can connect to DUT and access to Internet by WPA3        ${ssid_2G_1}    1${SPACE}345678
    [Teardown]    upload result to testlink    G-CPE-26

G-CPE-33 : 5G default Authentication check
    [Tags]    @AUTHOR=Frank_Hung    consoleTag
    Verify the 5G default Authentication setting should Be WPA3/WPA2 PSK
    [Teardown]    upload result to testlink    G-CPE-33

G-CPE-3 : 2G SSID minimum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to 1 bit input and click "Save"    1    12345678
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    1    12345678
    [Teardown]    upload result to testlink    G-CPE-3

G-CPE-4 : 2G SSID maximum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to 32 bit input and click "Save"    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa    12345678
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa    12345678
    [Teardown]    upload result to testlink    G-CPE-4

G-CPE-19 : 2G SSID wrong format Check
    [Tags]    @AUTHOR=Frank_Hung
    Open WLAN Basic Config Page
    Verify " 234" cannot input to 2.4G SSID Field
    Verify "1 34" can input to 2.4G SSID Field and click "Save"
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    1${SPACE}34    12345678
    [Teardown]    upload result to testlink    G-CPE-19

G-CPE-28 : 5G SSID default Value check
    [Tags]    @AUTHOR=Frank_Hung    consoleTag
    Disable Common SSID on GUI
    Verify 5G SSID Default Value is Gemtek_Wifi7_5G_XXXXXX
    ${default_password}    Get Default 5G WiFi Password
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_default}    ${default_password}
    [Teardown]    upload result to testlink    G-CPE-28

G-CPE-35 : 5G WPA Preshare key default Value check
    [Tags]    @AUTHOR=Frank_Hung    consoleTag
    ${default_password}    Get Default 5G WiFi Password
    Verify WiFi 5GHz WPA Preshare key default Value    ${ssid_5G_default}    ${default_password}
    [Teardown]    upload result to testlink    G-CPE-35

G-CPE-29 : 5G SSID minimum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to 1 bit input and click "Save"    5    12345678
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    5    12345678
    [Teardown]    upload result to testlink    G-CPE-29

G-CPE-30 : 5G SSID maximum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to 32 bit input and click "Save"    zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz    12345678
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz    12345678
    [Teardown]    upload result to testlink    G-CPE-30

G-CPE-32 : 5G SSID wrong format Check
    [Tags]    @AUTHOR=Frank_Hung
    Open WLAN Basic Config Page
    Verify " 234" cannot input to 5G SSID Field
    Verify "1 34-5G" can input to 5G SSID Field and click "Save"
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    1${SPACE}34-5G    12345678
    [Teardown]    upload result to testlink    G-CPE-32

G-CPE-34 : 5G security type WPA3/WPA2 PAK check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz security type WPA3/WPA2 PAK and click "Save"    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_5G_1}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-34

G-CPE-36 : 5G WPA Preshare key minimum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz Preshare key to 8 bit input and click "Save"    ${ssid_5G_1}    87654321
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    87654321
    [Teardown]    upload result to testlink    G-CPE-36

G-CPE-37 : 5G WPA Preshare key maximum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz Preshare key to 63 bit input and click "Save"    ${ssid_5G_1}    ${wifi_password_63}
    [Teardown]    upload result to testlink    G-CPE-37

G-CPE-39 : 5G WPA Preshare key special format input check
    [Tags]    @AUTHOR=Frank_Hung
    Verify "1 345678" can input to 5G Password Field and click "Save"    ${ssid_5G_1}    1${SPACE}345678
    Verify Wireless PC can connect to DUT and access to Internet by WPA3        ${ssid_5G_1}    1${SPACE}345678
    [Teardown]    upload result to testlink    G-CPE-39

G-CPE-40-41 : 6G SSID default Value
    [Tags]    @AUTHOR=Frank_Hung    consoleTag
    Verify 6G SSID Default Value is Gemtek_Wifi7_6G_XXXXXX
    ${default_password}    Get Default 6G WiFi Password
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G_default}    ${default_password}
    [Teardown]    upload result to testlink for G-CPE-40-41     G-CPE-40    G-CPE-41

G-CPE-46 : 6G default Authentication check
    [Tags]    @AUTHOR=Frank_Hung    consoleTag
    Verify the 6G default Authentication setting should Be WPA3/WPA2 PSK
    [Teardown]    upload result to testlink    G-CPE-46

G-CPE-53 : Cancel Button Test
    [Tags]    @AUTHOR=Frank_Hung
    Set Any Value on GUI and Click Cancel Button, verify value cannot be saved
    [Teardown]    upload result to testlink    G-CPE-53

G-CPE-48 : 6G WPA Preshare key default Value check
    [Tags]    @AUTHOR=Frank_Hung    consoleTag
    ${default_password}    Get Default 6G WiFi Password
    Verify WiFi 6GHz WPA Preshare key default Value    ${ssid_6G_default}    ${default_password}
    [Teardown]    upload result to testlink    G-CPE-48

G-CPE-42 : 6G SSID minimum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz SSID to 1 bit input and click "Save"    6    12345678
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    6    12345678
    [Teardown]    upload result to testlink    G-CPE-42

G-CPE-43 : 6G SSID maximum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz SSID to 32 bit input and click "Save"    66666666666666666666666666666666    12345678
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    66666666666666666666666666666666    12345678
    [Teardown]    upload result to testlink    G-CPE-43

G-CPE-45 : 6G SSID wrong format Check
    [Tags]    @AUTHOR=Frank_Hung
    Open WLAN Basic Config Page
    Verify " 234" cannot input to 6G SSID Field
    Verify "1 34-6G" can input to 6G SSID Field and click "Save"
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    1${SPACE}34-6G    12345678
    [Teardown]    upload result to testlink    G-CPE-45

G-CPE-47 : 6G security type WPA3/WPA2 PAK check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz security type WPA3/WPA2 PAK and click "Save"    ${ssid_6G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G_1}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-47

G-CPE-49 : 6G WPA Preshare key minimum input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz Preshare key to 8 bit input and click "Save"    ${ssid_6G_1}    87654321
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G_1}    87654321
    [Teardown]    upload result to testlink    G-CPE-49

G-CPE-52 : 6G WPA Preshare key special format input check
    [Tags]    @AUTHOR=Frank_Hung
    Verify "1 345678" can input to 6G Password Field and click "Save"    ${ssid_6G_1}    1${SPACE}345678
    Verify Wireless PC can connect to DUT and access to Internet by WPA3        ${ssid_6G_1}    1${SPACE}345678
    [Teardown]    upload result to testlink    G-CPE-52

G-CPE-55 : Common SSID function check
    [Tags]    @AUTHOR=Frank_Hung
    Enable Common SSID, Config [SSID] [security type] and [Password] on GUI    ${ssid_common}    ${wifi_password_63}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_common}    ${wifi_password_63}
    [Teardown]    upload result to testlink    G-CPE-55

G-CPE-58 : 2.4 GHz Wireless Settings default Value check
    [Tags]    @AUTHOR=Frank_Hung
    Verify WiFi 2.4GHz Mode is 802.11be, Bandwith is 20 / 40 MHz and Channel is Auto on GUI
    [Teardown]    upload result to testlink    G-CPE-58

G-CPE-60 : 2.4 GHz Wireless Settings-Bandwidth Test
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz Bandwith to 40Mhz
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    ${wifi_password}
    Verify Bandwith on Wireless PC should be 40Mhz
    Change WiFi 2.4GHz Bandwith to 20Mhz
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    ${wifi_password}
    Verify Bandwith on Wireless PC should be 20Mhz
    [Teardown]    upload result to testlink    G-CPE-60

G-CPE-204 : Check 6G Enable/Disable function
    [Tags]    @AUTHOR=Frank_Hung    consoleTag
    Change WiFi 6GHz SSID to "0123456789_6G_xxxx" and click "Save"    ${ssid_6G_1}    ${wifi_password}
    Disable WiFi 6GHz on GUI
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_6G_1}    ${wifi_password}
    Reboot DUT frome Console
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_6G_1}    ${wifi_password}
    Enable WiFi 6GHz on GUI
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G_1}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-204

G-CPE-563 WiFi 2.4GHz SSID changed ---0 to 9
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-563

G-CPE-564 WiFi 5GHz SSID changed ---0 to 9
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-564

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Change WiFi 6GHz Channel to 1 from GUI

G-CPE-565 WiFi 6GHz SSID changed ---0 to 9
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz SSID to "0123456789_6G_xxxx", Security to WPA3-PSK    ${ssid_6G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G_1}    ${wifi_password}
    Verify Wireless PC's Channel is 1
    [Teardown]    upload result to testlink    G-CPE-565

G-CPE-61 : 2.4 GHz Wireless Settings-Channel Test
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password}
    Change WiFi 2.4GHz Channel to 1
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC's Channel is 1
    Change WiFi 2.4GHz Channel to 11
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC's Channel is 11
    [Teardown]    upload result to testlink    G-CPE-61

G-CPE-79 : 5 GHz Wireless Settings-Channel Test
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_5G_1}    ${wifi_password}
    Change WiFi 5GHz Channel to 36
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC's Channel is 36
    Change WiFi 5GHz Channel to 100
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC's Channel is 100
    Change WiFi 5GHz Channel to 165
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC's Channel is 165
    [Teardown]    upload result to testlink    G-CPE-79

G-CPE-566 WiFi 2.4GHz SSID changed --- lower case
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "abcdefghijklmnopqrstuvwxyz_2G_xxxx" and click "Save"    ${ssid_2G_2}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_2}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-566

G-CPE-567 WiFi 5GHz SSID changed --- lower case
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "abcdefghijklmnopqrstuvwxyz_5G_xxxx" and click "Save"    ${ssid_5G_2}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3   ${ssid_5G_2}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-567

G-CPE-568 WiFi 6GHz SSID changed --- lower case
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz SSID to "abcdefghijklmnopqrstuvwxyz_6G_xxxx" and click "Save"    ${ssid_6G_2}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3   ${ssid_6G_2}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-568

G-CPE-569 2.4GHz SSID changed --- upper case
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to Uppercase letter"ABCDEFGHIJKLMNOPQRSTUVWXYZ_2G_xxxx" and click "Save"    ${ssid_2G_3}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_3}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-569

G-CPE-570 5GHz SSID changed --- upper case
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to Uppercase letter "ABCDEFGHIJKLMNOPQRSTUVWXYZ_5G_xxxx" and click "Save"    ${ssid_5G_3}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3   ${ssid_5G_3}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-570

G-CPE-571 6GHz SSID changed --- upper case
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz SSID to Uppercase letter "ABCDEFGHIJKLMNOPQRSTUVWXYZ_6G_xxxx" and click "Save"    ${ssid_6G_3}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3   ${ssid_6G_3}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-571

G-CPE-18 : 2G SSID Special string check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "~!@#$%^&*()_+{}|:"<>?`-=[]\;',./" and click "Save"    ${ssid_2G_4}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet for special char    ${ssid_2G_4}    wpa_supplicant_special_2G_ssid_wpa3.conf
    [Teardown]    upload result to testlink and Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password}    G-CPE-18

G-CPE-25 : 2G WPA Preshare key special string input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz Password to "~!@#$%^&*()_+{}|:"<>?`-=[]\;',./" and click "Save"    2GHz_ssid    ${wifi_password_special}
    Verify Wireless PC can connect to DUT and access to Internet for special char Password    2GHz_ssid    wpa_supplicant_special_password_2G_pwa3.conf
    [Teardown]    upload result to testlink    G-CPE-25

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung    regressionTag
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Change WiFi 6GHz Channel to 1 from GUI

G-CPE-31 : 5G SSID Special string check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "~!@#$%^&*()_+{}|:"<>?`-=[]\;',./" and click "Save"    ${ssid_5G_4}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet for special char    ${ssid_5G_4}    wpa_supplicant_special_5G_ssid_wpa3.conf
    [Teardown]    upload result to testlink and Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_5G_1}    ${wifi_password}    G-CPE-31

G-CPE-44 : 6G SSID Special string check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz SSID to "~!@#$%^&*()_+{}|:"<>?`-=[]\;',./" and click "Save"    ${ssid_6G_4}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet for special char    ${ssid_6G_4}    wpa_supplicant_special_6G_ssid_wpa3.conf
    [Teardown]    upload result to testlink and Change WiFi 6GHz SSID to "0123456789_6G_xxxx", Security to WPA3-PSK    ${ssid_6G_1}    ${wifi_password_63}    G-CPE-44

G-CPE-38 : 5G WPA Preshare key special string input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz Password to "~!@#$%^&*()_+{}|:"<>?`-=[]\;',./" and click "Save"    5GHz_ssid    ${wifi_password_special}
    Verify Wireless PC can connect to DUT and access to Internet for special char Password    5GHz_ssid    ./wpa_supplicant_special_password_5G_pwa3.conf
    [Teardown]    upload result to testlink    G-CPE-38

G-CPE-51 : 6G WPA Preshare key special string input check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz Password to "~!@#$%^&*()_+{}|:"<>?`-=[]\;',./" and click "Save"    6GHz_ssid    ${wifi_password_special}
    Verify Wireless PC can connect to DUT and access to Internet for special char Password    6GHz_ssid    ./wpa_supplicant_special_password_6G_pwa3.conf
    [Teardown]    upload result to testlink    G-CPE-51

G-CPE-4 : 2G SSID maximum input check --- 32 char
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "00000000000000000009azAZ#_2G_xxxx" and click "Save"    ${ssid_2G_5}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_5}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-4

G-CPE-30 : 5G SSID maximum input check --- 32 char
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "00000000000000000009azAZ#_5G_xxxx" and click "Save"    ${ssid_5G_5}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3   ${ssid_5G_5}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-30

G-CPE-43 : 6G SSID maximum input check --- 32 char
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz SSID to "00000000000000000009azAZ#_6G_xxxx" and click "Save"    ${ssid_6G_5}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3   ${ssid_6G_5}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-43

G-CPE-21 : 2G security type WPA3/WPA2 PAK check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx", Security to WPA3/WPA2-PSK    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3   ${ssid_2G_1}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-21

G-CPE-34 : 5G security type WPA3/WPA2 PAK check
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx", Security to WPA3/WPA2-PSK    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    ${wifi_password}
    [Teardown]    upload result to testlink    G-CPE-34

G-CPE-572 : 2.4GHz WPA3-Personal (WPA3 PSK)
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx", Security to WPA3-PSK    ${ssid_2G_1}    ${wifi_password_64}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    ${wifi_password_64}
    [Teardown]    upload result to testlink    G-CPE-572

G-CPE-573 : 5GHz WPA3-Personal (WPA3 PSK)
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx", Security to WPA3-PSK    ${ssid_5G_1}    ${wifi_password_64}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3   ${ssid_5G_1}    ${wifi_password_64}
    [Teardown]    upload result to testlink    G-CPE-573

Delete WiFi Profile and Reboot Wirless PC
     [Tags]    @AUTHOR=Frank_Hung
     Wait Until Keyword Succeeds    3x    2s    cli    wifi_client    echo '${DEVICES.wifi_client.password}' | sudo -S find /etc/NetworkManager/system-connections/ ! -name 'Wired connection 1.nmconnection' ! -name 'l2tp-test-2.nmconnection' -type f -delete    prompt=gemtek@gemtek    timeout=30
     Wait Until Keyword Succeeds    3x    2s    cli    wifi_client    echo '${DEVICES.wifi_client.password}' | sudo -S /sbin/shutdown -r    prompt=scheduled    timeout=70
     sleep    60

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

G-CPE-574 : Verify with WPS Push button (Virtual Button)
    [Tags]    @AUTHOR=Frank_Hung
    Change Common SSID Security to WPA3/WPA2 PSK
    Wait Until Keyword Succeeds    2x    60s    Retry WPS PBC    ${WPS_bssid_5G}    wifi_client
    [Teardown]    upload result to testlink    G-CPE-574

G-CPE-575 : WPS function is disabled (Virtual Button)
    [Tags]    @AUTHOR=Frank_Hung
    Disable WPS on DUT
    Repeat keyword    2 times    Retry WPS PBC Should Fail    ${WPS_bssid_5G}    wifi_client
    [Teardown]    upload result to testlink    G-CPE-575

G-CPE-576 : WiFi 2.4GHz incorrect Preshare key
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password}
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_2G_1}    incorrect_password
    [Teardown]    upload result to testlink    G-CPE-576

G-CPE-577 : WiFi 5GHz incorrect Peshare key
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_5G_1}    ${wifi_password}
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_5G_1}    incorrect_password
    [Teardown]    upload result to testlink    G-CPE-577

G-CPE-578 : WiFi 6GHz incorrect Peshare key
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 6GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_6G_1}    ${wifi_password}
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_6G_1}    incorrect_password
    [Teardown]    upload result to testlink    G-CPE-578

G-CPE-579 : Setup a Mesh Network (Ethernet Onboarding)
    [Tags]    @AUTHOR=Frank_Hung    regressionTag
    Power OFF than Power ON Agent
    Up Agent Interface
    sleep    240
    Verify mesh topology from GUI, it should display Controller and Agent
    [Teardown]    upload result to testlink    G-CPE-579

G-CPE-580 : Check mesh network topology (Ethernet Onboarding)
    [Tags]    @AUTHOR=Frank_Hung    regressionTag
    Verify mesh node(devices) in the mesh network
    Verify clients(users) in the mesh network
    [Teardown]    upload result to testlink and Down Agent Interface    G-CPE-580

G-CPE-130 : Wireless Extender Basic function check (Need Confirm)
    [Tags]    @AUTHOR=Frank_Hung    regressionTag    consoleTag
    Change device to WiFi Extender Mode From GUI
    After device reboot, the device will change IP to 192.168.100.100, the connected PC must change IP to 192.168.100.x
    Verify the connected PC can open DUT GUI 192.168.100.100
    Choose one SSID and input password and click Connect
    Verify the page show Connected Status for connection
    [Teardown]    upload result to testlink and Reset DUT and Wait 210 seconds    G-CPE-130

**** comments ****

Case. FN23WP004 Verify with Device PIN
    [Tags]    @AUTHOR=Frank_Hung
    Wait Until Keyword Succeeds    2x    10s    Retry WPS PIN on Client    wifi_client
    Wait Until Keyword Succeeds    2x    10s    Retry WPS PIN    ${WPS_bssid_5G}    ${WPS_PIN_Code}    wifi_client
    Wait Until Keyword Succeeds    2x    10s    Retry WPS PIN    ${WPS_bssid_2G}    ${WPS_PIN_Code}    wifi_client

Temp
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx", Security to WPA2-PSK    ${ssid_5G_1}    ${wifi_password_64}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_5G_1}    ${wifi_password_64}

Case. FN23WL002 Security is disabled (OPEN)
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx", Security to OPEN    ${ssid_2G_1}
    Verify Wireless PC can connect to DUT and access to Internet (OPEN)    ${ssid_2G_1}
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx", Security to OPEN    ${ssid_5G_1}
    Verify Wireless PC can connect to DUT and access to Internet (OPEN)    ${ssid_5G_1}

Case. FN23WL004 WPA2/WPA-Personal (WPA2/WPA PSK)
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx", Security to WPA2/WPA-PSK    ${ssid_2G_1}    ${wifi_password_63}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_2G_1}    ${wifi_password_63}
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx", Security to WPA2/WPA-PSK    ${ssid_5G_1}    ${wifi_password_63}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_5G_1}    ${wifi_password_63}

Case. FN23WL006 WPA3/WPA2-Personal (WPA3/WPA2 PSK)
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password_63}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_2G_1}    ${wifi_password_63}
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_5G_1}    ${wifi_password_63}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_5G_1}    ${wifi_password_63}

*** Keywords ***
upload result to testlink for G-CPE-40-41
    [Arguments]    ${testCaseID}    ${testCaseID2}
    upload result to testlink    ${testCaseID}
    upload result to testlink    ${testCaseID2}

upload result to testlink and Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"
    [Arguments]     ${ssid_2G_1}    ${wifi_password}    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Change WiFi 2.4GHz SSID to "0123456789_2G_xxxx" and click "Save"    ${ssid_2G_1}    ${wifi_password}

upload result to testlink and Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"
    [Arguments]     ${ssid_5G_1}    ${wifi_password}    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_5G_1}    ${wifi_password}

upload result to testlink and Change WiFi 6GHz SSID to "0123456789_6G_xxxx", Security to WPA3-PSK
    [Arguments]     ${ssid_6G_1}    ${wifi_password_63}    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Change WiFi 6GHz SSID to "0123456789_6G_xxxx", Security to WPA3-PSK    ${ssid_6G_1}    ${wifi_password_63}

upload result to testlink and Down Agent Interface
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Down Agent Interface

upload result to testlink and Reset DUT and Wait 210 seconds
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Reset DUT and Wait 210 seconds




