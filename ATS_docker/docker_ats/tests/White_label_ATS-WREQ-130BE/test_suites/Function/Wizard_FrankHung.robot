*** Settings ***
Resource    ../base.robot
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN_FrankHung.robot
Resource    ../../keyword/kw_Basic_WiFi_FrankHung.robot
Resource    ../../keyword/kw_testlink_FrankHung.robot
#Test Teardown    print debug message to console
Suite Setup    Up WAN Interface
#Suite Setup    Open Web GUI and Reboot Wifi_Client    ${URL}
#Suite Setup    Open Web GUI and Reset to Default    ${URL}    ${DUT_Password}
Suite Teardown    Up WAN Interface

*** Variables ***

*** Test Cases ***


Reboot Cisco Router
    [Tags]    @AUTHOR=Frank_Hung
    v6 Server setup, M bit 1
    Reboot Cisco Router and waiting 180 seconds
    Up WAN Interface

Reboot LAN PC
    [Tags]    @AUTHOR=Frank_Hung
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S /sbin/shutdown -r +1
    sleep    60
    Up WAN Interface

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung    rebootTag
    Run    echo 'vagrant' | sudo -S netplan apply
    sleep    4
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Get DUT WAN IP

Create SSID Name for auto test
    [Tags]    @AUTHOR=Frank_Hung
    ${result}=    Generate Random String    8    [NUMBERS]
    ${ssid}=    Catenate    SEPARATOR=    ssid-    ${result}
    ${ssid_2G}=    Catenate    SEPARATOR=    2G-    ${result}
    ${ssid_5G}=    Catenate    SEPARATOR=    5G-    ${result}
    ${ssid_6G}=    Catenate    SEPARATOR=    6G-    ${result}
    Set Suite Variable    ${ssid}    ${ssid}
    Set Suite Variable    ${ssid_2G}    ${ssid_2G}
    Set Suite Variable    ${ssid_5G}    ${ssid_5G}
    Set Suite Variable    ${ssid_6G}    ${ssid_6G}
    Set Suite Variable    ${wifi_password}    ghijGHIJK/

Wizard/Router Mode/DHCP/Enable Smart Connect/Disable MLO/Enable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to DHCP than click Next Button
    Config MLO, Config "Smart Connect" and Config WiFi Settings than click Next Button    Disabled    Enabled    ${ssid}    ${wifi_password}
    Enable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from DHCP Server
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid}    ${wifi_password}
    Verify MLO is Disabled
    Verify Mesh Network can be Setup [Ethernet Onboarding]
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx




Wizard/Router Mode/DHCP/Enable Smart Connect/Disable MLO/[Disable Smart Mesh]
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to DHCP than click Next Button
    Config MLO, Config "Smart Connect" and Config WiFi Settings than click Next Button    Disabled    Enabled    ${ssid}    ${wifi_password}
    Disable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from DHCP Server
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid}    ${wifi_password}
    Verify MLO is Disabled
    Verify Mesh is Disabled
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Router Mode/DHCP/Enable Smart Connect/[Enable MLO]/Disable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to DHCP than click Next Button
    Config MLO, Config "Smart Connect" and Config WiFi Settings than click Next Button    Enabled    Enabled    ${ssid}    ${wifi_password}
    Disable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from DHCP Server
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid}    ${wifi_password}
    Verify MLO is Enabled
    Verify Mesh is Disabled
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Router Mode/DHCP/[Disable Smart Connect][Enable WiFi 2.4G 5G 6G][Enable PSC][Disable PMF]/Disable MLO/Disable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to DHCP than click Next Button
    Disable MLO
    Disable "Smart Connect"
    Enable WiFi 2.4G, Security Type is WPA3-Personal    ${ssid_2G}    ${wifi_password}
    Enable WiFi 5G, Security Type is WPA3-Personal    ${ssid_5G}    ${wifi_password}
    Enable WiFi 6G, Security Type is WPA3-Personal    ${ssid_6G}    ${wifi_password}
    Enable PSC
    Disable PMF than click Next Button
    Disable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from DHCP Server
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G}    ${wifi_password}
    Verify PSC is Enabled
    Verify PMF is Disabled
    Verify MLO is Disabled
    Verify Mesh is Disabled
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Router Mode/DHCP/[Disable Smart Connect][Enable WiFi 2.4G 5G 6G][Enable PSC][Enable PMF]/Disable MLO/Disable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to DHCP than click Next Button
    Disable MLO
    Disable "Smart Connect"
    Enable WiFi 2.4G, Security Type is WPA2-Personal    ${ssid_2G}    ${wifi_password}
    Enable WiFi 5G, Security Type is WPA2-Personal    ${ssid_5G}    ${wifi_password}
    Enable WiFi 6G, Security Type is WPA3-Personal    ${ssid_6G}    ${wifi_password}
    Enable PSC
    Enable PMF than click Next Button
    Disable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from DHCP Server
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_2G}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet    ${ssid_5G}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G}    ${wifi_password}
    Verify PSC is Enabled
    Verify PMF is Enabled
    Verify MLO is Disabled
    Verify Mesh is Disabled
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Router Mode/DHCP/[Disable Smart Connect][Enable WiFi 2.4G 5G 6G][Disable PSC][Disable PMF]/Disable MLO/Disable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to DHCP than click Next Button
    Disable MLO
    Disable "Smart Connect"
    Enable WiFi 2.4G, Security Type is WPA3-Personal    ${ssid_2G}    ${wifi_password}
    Enable WiFi 5G, Security Type is WPA3-Personal    ${ssid_5G}    ${wifi_password}
    Enable WiFi 6G, Security Type is WPA3-Personal    ${ssid_6G}    ${wifi_password}
    Disable PSC
    Disable PMF than click Next Button
    Disable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from DHCP Server
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G}    ${wifi_password}
    Verify PSC is Disabled
    Verify PMF is Disabled
    Verify MLO is Disabled
    Verify Mesh is Disabled
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Router Mode/DHCP/[Disable Smart Connect][Only Enable WiFi 2.4G][Enable PSC][Disable PMF]/Disable MLO/Disable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to DHCP than click Next Button
    Disable MLO
    Disable "Smart Connect"
    Enable WiFi 2.4G, Security Type is WPA3-Personal    ${ssid_2G}    ${wifi_password}
    Disable WiFi 5G
    Disable WiFi 6G
    Enable PSC
    Disable PMF than click Next Button
    Disable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from DHCP Server
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_2G}    ${wifi_password}
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_5G}    ${wifi_password}
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_6G}    ${wifi_password}
    Verify PSC is Enabled
    Verify PMF is Disabled
    Verify MLO is Disabled
    Verify Mesh is Disabled
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Router Mode/DHCP/[Disable Smart Connect][Only Enable WiFi 5G][Enable PSC][Disable PMF]/Disable MLO/Disable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to DHCP than click Next Button
    Disable MLO
    Disable "Smart Connect"
    Disable WiFi 2.4G
    Enable WiFi 5G, Security Type is WPA3-Personal    ${ssid_5G}    ${wifi_password}
    Disable WiFi 6G
    Enable PSC
    Disable PMF than click Next Button
    Disable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from DHCP Server
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_2G}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_5G}    ${wifi_password}
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_6G}    ${wifi_password}
    Verify PSC is Enabled
    Verify PMF is Disabled
    Verify MLO is Disabled
    Verify Mesh is Disabled
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Router Mode/DHCP/[Disable Smart Connect][Only Enable WiFi 6G][Enable PSC][Disable PMF]/Disable MLO/Disable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to DHCP than click Next Button
    Disable MLO
    Disable "Smart Connect"
    Disable WiFi 2.4G
    Disable WiFi 5G
    Enable WiFi 6G, Security Type is WPA3-Personal    ${ssid_6G}    ${wifi_password}
    Enable PSC
    Disable PMF than click Next Button
    Disable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from DHCP Server
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_2G}    ${wifi_password}
    Verify Wireless PC cannot connect to DUT and access to Internet by WPA3    ${ssid_5G}    ${wifi_password}
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid_6G}    ${wifi_password}
    Verify PSC is Enabled
    Verify PMF is Disabled
    Verify MLO is Disabled
    Verify Mesh is Disabled
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Router Mode/[PPPoE]/Enable Smart Connect/Disable MLO/Disable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to PPPoE than click Next Button
    Config MLO, Config "Smart Connect" and Config WiFi Settings than click Next Button    Disabled    Enabled    ${ssid}    ${wifi_password}
    Disable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface can get IP address from PPPoE Server
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid}    ${wifi_password}
    Verify MLO is Disabled
    Verify Mesh is Disabled
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Router Mode/[Static IP]/Enable Smart Connect/Disable MLO/Enable Smart Mesh
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Router Mode
    Click Next Button on "Get Your Device Ready" Page
    Select DUT WAM Mode to Static IP than click Next Button
    Config MLO, Config "Smart Connect" and Config WiFi Settings than click Next Button    Disabled    Enabled    ${ssid}    ${wifi_password}
    Enable Smart Mesh than click Next Button
    Enter Admin Username and Password than click Next Button    admin     admin
    Verify the "SETTINGS SUMMARY"    DHCP    Enabled    Disabled    ${ssid}    ${wifi_password}    Enabled    admin    admin
    Waiting 260 seconds

    Verify Login Username and Password    admin    admin
    Verify DUT WAN Interface is Static IP address
    Verify Wireless PC can connect to DUT and access to Internet by WPA3    ${ssid}    ${wifi_password}
    Verify MLO is Disabled
    Verify Mesh Network can be Setup [Ethernet Onboarding]
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console    G-CPE-xxxx

Wizard/Agent Mode
    Click Agree Button on "Terms of Service and Privacy Policy" Page
    Select Agent Mode
    Select "Setup via Ethernet" than click Next Button
    Connect DUT and Controller by Ethernet
    Waiting 260 seconds

    Verify DUT is Agent Mode
    Verify LAN PC can access Internet
    [Teardown]    upload result to testlink and Reset DUT from Console and Disconnect DUT and Controller    G-CPE-xxxx





***Comments***





*** Keywords ***
upload result to testlink and Reset DUT from Console
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Reset DUT from Console

upload result to testlink and Reset DUT from Console and Disconnect DUT and Controller
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Disconnect DUT and Controller
    Reset DUT from Console



