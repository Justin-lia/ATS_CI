*** Settings ***
#Resource    ./base.robot

*** Variables ***


*** Keywords ***
Verify information is correct on Dual Image page
    ${result}=    get text    id=current
    Should Contain Any    ${result}    1    2
    ${result}=    get text    xpath=//*[@id="tbody_id_0"]/td[1]
    Should Be Equal    ${result}    1
    ${result}=    get text    xpath=//*[@id="tbody_id_0"]/td[2]
    Should Not Be Empty    ${result}
    ${result}=    get text    xpath=//*[@id="tbody_id_1"]/td[1]
    Should Be Equal    ${result}    2
    ${result}=    get text    xpath=//*[@id="tbody_id_1"]/td[2]
    Should Not Be Empty    ${result}

Open Dual Image Page
    click element    id=lang_mainmenu_status
    sleep    1
    click element    id=lang_submenu_status_dualImage
    sleep    4

Verify information is correct on Mesh Client List
    ${result}=    get text    xpath=//*[@id="Device_topology_table_id_0"]/td[1]
    Should Not Be Empty    ${result}
    ${result}=    get text    xpath=//*[@id="Device_topology_table_id_0"]/td[2]
    Should Contain    ${result}    192.168.
    ${result}=    get text    xpath=//*[@id="Device_topology_table_id_0"]/td[3]
    Should Not Be Empty    ${result}
    ${result}=    get text    xpath=//*[@id="Device_topology_table_id_0"]/td[4]
    Should Not Be Empty    ${result}
    ${result}=    get text    xpath=//*[@id="Device_topology_table_id_0"]/td[5]
    Should Contain Any    ${result}    ETHER    WLAN
    [Teardown]    Close Browser


Verify information is correct on Mesh Node List
    ${result}=    get text    xpath=//*[@id="Mesh_topology_table_id_0"]/td[1]
    Should Not Be Empty    ${result}

    ${result}=    get text    xpath=//*[@id="Mesh_topology_table_id_0"]/td[2]
    Should Contain    ${result}    192.168.

    ${result}=    get text    xpath=//*[@id="Mesh_topology_table_id_0"]/td[3]
    Should Not Be Empty    ${result}

    ${result}=    get text    xpath=//*[@id="Mesh_topology_table_id_0"]/td[4]
    Should Not Be Empty    ${result}

    ${result}=    get text    xpath=//*[@id="Mesh_topology_table_id_0"]/td[5]
    Should Not Be Empty    ${result}

    ${result}=    get text    xpath=//*[@id="Mesh_topology_table_id_0"]/td[6]
    Should Be Equal    ${result}    Controller



Verify shall shows 6G companion devices
    click element    id=scan_6g
    sleep    40
    ${result}=    get text    id=result_6g
    log    ${result}
    Should Contain    ${result}    WPA
    Should Contain    ${result}    PSK
    Close Browser

Verify shall shows 5G companion devices
    click element    id=scan_5g
    sleep    40
    ${result}=    get text    id=result_5g
    log    ${result}
    Should Contain    ${result}    WPA
    Should Contain    ${result}    PSK
    Close Browser

Verify shall shows 2.4G companion devices
    click element    id=scan_2g
    sleep    40
    ${result}=    get text    id=result_2g
    log    ${result}
    Should Contain    ${result}    WPA
    Should Contain    ${result}    PSK
    Close Browser

Open WiFi Neighbor Page
    click element    id=menu_status
    sleep    1
    click element    id=lang_submenu_status_wifiNeighbor
    sleep    4

Open LAN Status Page
    click element    id=menu_status
    sleep    1
    click element    id=menu_status_lan
    sleep    4

Open WAN Status Page
    click element    id=menu_status
    sleep    1
    click element    id=menu_status_wan
    sleep    4

Setup DUT to Bridge Mode
    click element    id=lang_mainmenu_basic_setting
    sleep    1
    click element    id=menu_basic_setting_wan
    sleep    2
    Select From List By Value    id=wan_mode    bridge
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=apply
    sleep    200
    Reload Page
    sleep    10

Setup PPPoE connection behind Login Status
    click element    id=lang_mainmenu_basic_setting
    sleep    1
    click element    id=menu_basic_setting_wan
    sleep    2
    click element    id=lang_ppp
    sleep    1
    input text    id=ppp_name    cisco
    sleep    1
    input text    id=ppp_pwd    cisco
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=apply
    sleep    200
    Reload Page
    sleep    10


Setup Static connection
    click element    id=lang_mainmenu_basic_setting
    sleep    1
    click element    id=menu_basic_setting_wan
    sleep    2
    click element    id=lang_static
    sleep    1
    input text    id=static_ip    172.16.11.111
    sleep    1
    input text    id=static_mask    255.255.255.0
    sleep    1
    input text    id=static_gatway    172.16.11.1
    sleep    1
    input text    id=static_dns1    8.8.8.8
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=apply
    sleep    200
    Reload Page
    sleep    10

Verify the status of Internet Connection is correct with DHCP mode
    ${message}=    Get Text    xpath=//*[@id="status_wan_ipv4_table_id_0"]/td[2]
    Should Contain    ${message}    dhcp
    sleep    1
    ${message}=    Get Text    xpath=//*[@id="status_wan_ipv4_table_id_0"]/td[4]
    Should Contain    ${message}    connected
    sleep    1
    click element    //*[@id="status_wan_ipv4_table_id_0"]/td[5]/button/img
    sleep    2
    ${result}=    Get Text    id=type_diag
    Should Contain    ${result}    dhcp
    ${result}=    Get Text    id=ipaddress_diag
    Should Contain    ${result}    172.16.11.
    ${result}=    Get Text    id=gateway_diag
    Should Contain    ${result}    172.16.11.1
    ${result}=    Get Text    id=dns1_diag
    Should Contain    ${result}    168.95.1.1
    ${result}=    Get Text    id=mask_diag
    Should Contain    ${result}    255.255.255.0
    ${result}=    Get Text    id=status_diag
    Should Contain Any    ${result}    connected    Connected
    click element    id=leafconfirm
    sleep    2
    click element    xpath=//*[@id="status_wan_ipv6_table_id_0"]/td[5]/button/img
    sleep   2
    ${result}=    Get Text    id=type_diag
    Should Contain Any    ${result}    dhcp   DHCP
    ${result}=    Get Text    id=ipaddress_diag
    Should Contain    ${result}    2001:1234:5678:9abc:
    ${result}=    Get Text    id=gateway_diag
    Should Contain    ${result}    fe80::
    ${result}=    Get Text    id=dns1_diag
    Should Contain    ${result}    2001:4860:4860::8888
    ${result}=    Get Text    id=status_diag
    Should Contain    ${result}    Connected
    [Teardown]    close browser

Verify the status of Internet connection is correct with Static IP Mode
    ${message}=    Get Text    xpath=//*[@id="status_wan_ipv4_table_id_0"]/td[2]
    Should Contain    ${message}    static
    sleep    1
    ${message}=    Get Text    xpath=//*[@id="status_wan_ipv4_table_id_0"]/td[4]
    Should Contain    ${message}    connected
    sleep    1
    click element    //*[@id="status_wan_ipv4_table_id_0"]/td[5]/button/img
    sleep    2
    ${result}=    Get Text    id=type_diag
    Should Contain    ${result}    static
    ${result}=    Get Text    id=ipaddress_diag
    Should Contain    ${result}    172.16.11.
    ${result}=    Get Text    id=gateway_diag
    Should Contain    ${result}    172.16.11.1
    ${result}=    Get Text    id=dns1_diag
    Should Contain    ${result}    8.8.8.8
    ${result}=    Get Text    id=mask_diag
    Should Contain    ${result}    255.255.255.0
    ${result}=    Get Text    id=status_diag
    Should Contain Any    ${result}    connected    Connected
    click element    id=leafconfirm
    sleep    2
    click element    xpath=//*[@id="status_wan_ipv6_table_id_0"]/td[5]/button/img
    sleep   2
    ${result}=    Get Text    id=type_diag
    Should Contain Any    ${result}    Static    static
    ${result}=    Get Text    id=ipaddress_diag
    Should Contain    ${result}    ::
    ${result}=    Get Text    id=gateway_diag
    Should Contain    ${result}    ::
    ${result}=    Get Text    id=dns1_diag
    Should Contain    ${result}    ::
    ${result}=    Get Text    id=status_diag
    Should Contain    ${result}    Connected
    [Teardown]    close browser

Check GUI ipv4 status
    Login GUI    ${URL}    ${DUT_Password}
    Open status page
    ${message}=    Get Text    id=ipv4type1
    Should Contain    ${message}    static
    sleep    1
    ${message}=    Get Text    id=ipv4status1
    Should Contain    ${message}    Connected
    sleep    1

Verify the status of Internet Connection is correct with PPPoE mode
    ${message}=    Get Text    xpath=//*[@id="status_wan_ipv4_table_id_0"]/td[2]
    Should Contain    ${message}    pppoe
    sleep    1
    ${message}=    Get Text    xpath=//*[@id="status_wan_ipv4_table_id_0"]/td[4]
    Should Contain    ${message}    connected
    sleep    1
    click element    //*[@id="status_wan_ipv4_table_id_0"]/td[5]/button/img
    sleep    2
    ${result}=    Get Text    id=type_diag
    Should Contain    ${result}    pppoe
    ${result}=    Get Text    id=ipaddress_diag
    Should Contain    ${result}    172.
    ${result}=    Get Text    id=gateway_diag
    Should Contain    ${result}    50.
    ${result}=    Get Text    id=dns1_diag
    Should Contain    ${result}    168.95.1.1
    ${result}=    Get Text    id=mask_diag
    Should Contain    ${result}    255.255.255.255
    ${result}=    Get Text    id=status_diag
    Should Contain Any    ${result}    connected    Connected
    click element    id=leafconfirm
    click element    xpath=//*[@id="status_wan_ipv6_table_id_0"]/td[5]/button/img
    sleep   2
    ${result}=    Get Text    id=type_diag
    Should Contain Any    ${result}    PPPoE    pppoe
    ${result}=    Get Text    id=ipaddress_diag
    Should Contain    ${result}    2001:1234:5678:9abc:
    ${result}=    Get Text    id=gateway_diag
    Should Contain    ${result}    fe80::
    ${result}=    Get Text    id=dns1_diag
    Should Contain    ${result}    2001:4860:4860::8888
    ${result}=    Get Text    id=status_diag
    Should Contain    ${result}    Connected
    [Teardown]    close browser

Verify the status of Internet Connection is correct with Bridge mode
    click element    id=lang_mainmenu_status
    sleep    2
    click element    id=menu_status_wan
    sleep    4
    ${message}=    Get Text    xpath=//*[@id="status_wan_ipv4_table_id_0"]/td[2]
    Should Contain    ${message}    bridge
    sleep    1
    ${message}=    Get Text    xpath=//*[@id="status_wan_ipv4_table_id_0"]/td[4]
    Should Contain    ${message}    connected
    sleep    1
    [Teardown]    Close Browser

Verify the status of Local Network is correct
    ${message}=    Get Text    xpath=//*[@id="status_lan_host_table_id_0"]/td[1]
    Should Contain    ${message}    192.168.1.
    sleep    1
    ${message}=    Get Text    xpath=//*[@id="status_lan_host_table_id_0"]/td[2]
    Should Contain    ${message}    255.255.255.0
    sleep    1
    ${message}=    Get Text    xpath=//*[@id="status_lan_host_table_id_0"]/td[3]
    Should Contain    ${message}    192.168.1.1
    sleep    1
    ${message}=    Get Text    xpath=//*[@id="status_lan_host_table_id_0"]/td[4]
    Should Contain    ${message}    fe80::
    ${message}=    Get Text    xpath=//*[@id="status_lan_host_table_id_0"]/td[5]
    Should Contain    ${message}    ${DUT_LAN_MAC}
    sleep    1
    ${message}=    Get Text    xpath=//*[@id="status_lan_table_id_0"]/td[2]
    Should Contain    ${message}    Down
    ${message}=    Get Text    xpath=//*[@id="status_lan_table_id_1"]/td[2]
    Should Contain    ${message}    Down
    ${message}=    Get Text    xpath=//*[@id="status_lan_table_id_2"]/td[2]
    Should Contain    ${message}    Up
    ${message}=    Get Text    xpath=//*[@id="status_lan_table_id_3"]/td[2]
    Should Contain    ${message}    Up
    ${message}=    Get Text    xpath=//*[@id="status_lan_table_id_2"]/td[3]
    Should Contain    ${message}        1000(Mbps)
    ${message}=    Get Text    xpath=//*[@id="status_lan_table_id_3"]/td[3]
    Should Contain    ${message}        1000(Mbps)
    ${message}=    Get Text    xpath=//*[@id="status_lan_table_id_2"]/td[4]
    Should Contain Any    ${message}    full    Full
    ${message}=    Get Text    xpath=//*[@id="status_lan_table_id_3"]/td[4]
    Should Contain Any    ${message}    full    Full
    [Teardown]    Close Browser

get MAC from host
    [Arguments]    ${host}
    ${getMAC}=    cli    ${host}    ifconfig ${DEVICES.${host}.interface} | grep "ether"
    @{getMAC}=    Get Regexp Matches    ${getMAC}    (?:[0-9A-Fa-f]{2}[:-]){5}(?:[0-9A-Fa-f]{2})
    ${getMAC}=    Strip String    ${getMAC}[0]
    [Return]    ${getMAC}


Open basic setup page
    click element    id=lang_mainmenu_basic_setting
    sleep    2
    wait_until_element_is_visible    id=wan_mode    timeout=5

Open status page
    click element    id=lang_mainmenu_status
    sleep    2
    wait_until_element_is_visible    id=ipv4type1    timeout=5

Login GUI
    [Tags]   @AUTHOR=Frank_Hung
    [Arguments]    ${URL}    ${DUT_Password}
    Wait Until Keyword Succeeds    4x    60s    Retry Login GUI    ${URL}    ${DUT_Password}
    [Teardown]    Stop Test Fail Retry Login Fail

Stop Test Fail Retry Login Fail
    ${gui_type}     run keyword and return status    wait_until_element_is_visible    id=homepage_tile    timeout=5
    Run Keyword if    ${gui_type}!=True    Fatal Error

#Stop Test Fail Retry Login Fail
#    ${gui_type}     run keyword and return status    wait_until_element_is_visible    id=lang_dev_info_name_title    timeout=5
#    Run Keyword if    ${gui_type}!=True    Power Off than Power On DUT when login Fail

Open Statistics Page
    Login GUI    ${URL}    ${DUT_Password}
    click element    id=lang_mainmenu_status
    sleep    2
    click element    id=lang_submenu_status_statistics
    sleep    4

Verify received/transmitted packets on Statistics WLAN Page
    ${2g_rxbytes}=    get text    xpath=//*[@id="wlan_statistics_tbody_id_0"]/td[2]
    Should Not Be Equal    ${2g_rxbytes}    0
    ${5g_rxbytes}=    get text    xpath=//*[@id="wlan_statistics_tbody_id_1"]/td[2]
    Should Not Be Equal    ${5g_rxbytes}    0
    ${6g_rxbytes}=    get text    xpath=//*[@id="wlan_statistics_tbody_id_2"]/td[2]
    Should Not Be Equal    ${6g_rxbytes}    0
    Should Not Be Equal    ${2g_rxbytes}    ${5g_rxbytes}
    Should Not Be Equal    ${5g_rxbytes}    ${6g_rxbytes}

    ${2g_rxpackets}=    get text    xpath=//*[@id="wlan_statistics_tbody_id_0"]/td[3]
    Should Not Be Equal    ${2g_rxpackets}    0
    ${5g_rxpackets}=    get text    xpath=//*[@id="wlan_statistics_tbody_id_1"]/td[3]
    Should Not Be Equal    ${5g_rxpackets}    0
    ${6g_rxpackets}=    get text    xpath=//*[@id="wlan_statistics_tbody_id_2"]/td[3]
    Should Not Be Equal    ${6g_rxpackets}    0
    Should Not Be Equal    ${2g_rxpackets}    ${5g_rxpackets}
    Should Not Be Equal    ${5g_rxpackets}    ${6g_rxpackets}

    ${2g_txbytes}=    get text    xpath=//*[@id="wlan_statistics_tbody_id_0"]/td[6]
    Should Not Be Equal    ${2g_txbytes}    0
    ${5g_txbytes}=    get text    xpath=//*[@id="wlan_statistics_tbody_id_1"]/td[6]
    Should Not Be Equal    ${5g_txbytes}    0
    ${6g_txbytes}=    get text    xpath=//*[@id="wlan_statistics_tbody_id_2"]/td[6]
    Should Not Be Equal    ${6g_txbytes}    0
    Should Not Be Equal    ${2g_txbytes}    ${5g_txbytes}
    Should Not Be Equal    ${5g_txbytes}    ${6g_txbytes}
    [Teardown]    Close Browser

Verify received/transmitted packets on Statistics LAN Page
    ${lan1_rxbytes}=    get text    xpath=//*[@id="lan_statistics_tbody_id_0"]/td[2]
    Should Be Equal    ${lan1_rxbytes}    0
    ${lan2_rxbytes}=    get text    xpath=//*[@id="lan_statistics_tbody_id_1"]/td[2]
    Should Be Equal    ${lan2_rxbytes}    0
    ${lan3_rxbytes}=    get text    xpath=//*[@id="lan_statistics_tbody_id_2"]/td[2]
    Should Not Be Equal    ${lan3_rxbytes}    0
    ${lan4_rxbytes}=    get text    xpath=//*[@id="lan_statistics_tbody_id_3"]/td[2]
    Should Not Be Equal    ${lan4_rxbytes}    0
    Should Not Be Equal    ${lan3_rxbytes}    ${lan4_rxbytes}

    ${lan1_rxpackets}=    get text    xpath=//*[@id="lan_statistics_tbody_id_0"]/td[3]
    Should Be Equal    ${lan1_rxpackets}    0
    ${lan2_rxpackets}=    get text    xpath=//*[@id="lan_statistics_tbody_id_1"]/td[3]
    Should Be Equal    ${lan2_rxpackets}    0
    ${lan3_rxpackets}=    get text    xpath=//*[@id="lan_statistics_tbody_id_2"]/td[3]
    Should Not Be Equal    ${lan3_rxpackets}    0
    ${lan4_rxpackets}=    get text    xpath=//*[@id="lan_statistics_tbody_id_3"]/td[3]
    Should Not Be Equal    ${lan4_rxpackets}    0
    Should Not Be Equal    ${lan3_rxpackets}    ${lan4_rxpackets}

    ${lan1_txbytes}=    get text    xpath=//*[@id="lan_statistics_tbody_id_0"]/td[6]
    Should Be Equal    ${lan1_txbytes}    0
    ${lan2_txbytes}=    get text    xpath=//*[@id="lan_statistics_tbody_id_1"]/td[6]
    Should Be Equal    ${lan2_txbytes}    0
    ${lan3_txbytes}=    get text    xpath=//*[@id="lan_statistics_tbody_id_2"]/td[6]
    Should Not Be Equal    ${lan3_txbytes}    0
    ${lan4_txbytes}=    get text    xpath=//*[@id="lan_statistics_tbody_id_3"]/td[6]
    Should Not Be Equal    ${lan4_txbytes}    0
    Should Not Be Equal    ${lan3_txbytes}    ${lan4_txbytes}

    ${lan1_txpackets}=    get text    xpath=//*[@id="lan_statistics_tbody_id_0"]/td[7]
    Should Be Equal    ${lan1_txpackets}    0
    ${lan2_txpackets}=    get text    xpath=//*[@id="lan_statistics_tbody_id_1"]/td[7]
    Should Be Equal    ${lan2_txpackets}    0
    ${lan3_txpackets}=    get text    xpath=//*[@id="lan_statistics_tbody_id_2"]/td[7]
    Should Not Be Equal    ${lan3_txpackets}    0
    ${lan4_txpackets}=    get text    xpath=//*[@id="lan_statistics_tbody_id_3"]/td[7]
    Should Not Be Equal    ${lan4_txpackets}    0
    Should Not Be Equal    ${lan3_txpackets}    ${lan4_txpackets}
    [Teardown]    Close Browser


Verify LAN PC can access Internet
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=60
    sleep    15
    ${ping_result}=    cli   lanhost    ping 192.168.1.1 -c 4    prompt=vagrant@lanhost    timeout=60
    Should Contain     ${ping_result}    ttl=
    ${ping_result}=    cli   lanhost    ping 8.8.8.8 -c 4    prompt=vagrant@lanhost    timeout=60
    Should Contain     ${ping_result}    ttl=


Power Off than Power On DUT when login Fail
    Run    python /home/vagrant/apc_script_power_off_to_on.py
    sleep    120

Retry Login GUI
    [Tags]   @AUTHOR=Frank_Hung
    [Arguments]    ${URL}    ${DUT_Password}
    run keyword and ignore error    Close Browser
    sleep    2
    Open Web GUI    ${URL}
#------Login GUI if detect login button
    sleep    5
    wait_until_element_is_visible    id=acnt_passwd    timeout=90
    input_text    id=acnt_username    admin
    sleep    1
    input_text    id=acnt_passwd    ${DUT_Password}
    sleep    1
    click element    id=myButton
    sleep    5
    Wait until element is visible    id=lang_mainmenu_basic_setting    timeout=30
    sleep    3
    Wait Until Element Is Not Visible    id=ajaxLoaderIcon    timeout=120
    sleep    2

Wizard-Setup
    Login GUI    ${URL}    ${DUT_Password}
    Click Element    id=next
    sleep    2
    input text    id=new_pwd    admin
    sleep    1
    input text    id=confirm_pwd    admin
    sleep    1
    Click Element    id=next
    sleep    1
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_enable_btn    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_enable_btn
    sleep    2
    Click Element    id=next
    sleep    1
    Click Element    id=apply
    sleep    180
    Close Browser

Login and Reset Default DUT
    [Arguments]    ${URL}    ${DUT_Password}
    Wait Until Keyword Succeeds    3x    10s    retry Login and Reset Default DUT    ${URL}    ${DUT_Password}


retry Login and Reset Default DUT
    [Arguments]    ${URL}    ${DUT_Password}
    IF    ${Platform}=='SPF12'
        sleep    1
    ELSE IF    ${Platform}=='SPF13'
        Run    echo "vagrant" | sudo -S chmod 777 /dev/ttyUSB0
        ${result}=    cli    DUT_serial_port    rm /opt/feature/GUI-QUICKSETUP-ENABLED && /etc/init.d/device-ui restart    prompt=root@
        sleep    1
        log    ${result}
    END
    Login GUI    ${URL}    ${DUT_Password}
    Reset Default DUT
    IF    ${Platform}=='SPF12'
        sleep    1
    ELSE IF    ${Platform}=='SPF13'
        Wizard-Setup
    END

Reset Default DUT
    [Tags]    @AUTHOR=Frank_Hung
    Go to Reset to Default Page
    Reset to Default DUT

Go to Reset to Default Page
    click element    id=lang_mainmenu_management
    sleep   2
    click element    id=lang_submenu_management_settings
    sleep    2

Reset to Default DUT
    click element    id=lang_restore_btn
    sleep    2
    click element    id=confirm_dialog_confirmed
    sleep    300
#    Run    python3 /home/vagrant/apc_script_power_off_to_on_port8.py
#    sleep    240
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} down
#    sleep    2
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} up
#    sleep    4
    Reload Page
    Wait until element is visible    id=acnt_passwd    timeout=60
    sleep    2
    close browser
    sleep    2
    Open Web GUI    ${URL}
    sleep    5
    input_text    id=acnt_passwd    ${DUT_Password}
    sleep    1
    close browser

Open Web GUI
    [Tags]   @AUTHOR=Frank_Hung
    [Arguments]    ${URL}
    run keyword and ignore error    delete all cookies
    #=========================================check Network
    ${result}=    Run    ifconfig
    log    ${result}
    ${result}=    Run    ping 192.168.1.1 -c 4
    log    ${result}
    #=========================================
    open browser    ${URL}    Firefox
    #Print Console Log If Open Browser Fail=======================================================================
#    ${gui_type}     run keyword and return status    open browser    ${URL}    Firefox
#    Run Keyword if    ${gui_type}!=True    cli    DUT_serial_port    \n    prompt=root@
#    Run Keyword if    ${gui_type}!=True    sleep    2
#    Run Keyword if    ${gui_type}!=True    cli    DUT_serial_port    ping 168.95.1.1 -c 4   prompt=root@
#    Run Keyword if    ${gui_type}!=True    sleep    2
#   Run Keyword if    ${gui_type}!=True    cli    DUT_serial_port    cat /proc/uptime    prompt=root@
#    Run Keyword if    ${gui_type}!=True    sleep    2
#    Run Keyword if    ${gui_type}!=True    cli    DUT_serial_port    ps -w    prompt=root@
#    Run Keyword if    ${gui_type}!=True    sleep    2
#    Run Keyword if    ${gui_type}!=True    cli    DUT_serial_port    ifconfig    prompt=root@
#    Run Keyword if    ${gui_type}!=True    sleep    2
#    Run Keyword if    ${gui_type}!=True    cli    DUT_serial_port    nft -a list table inet fw4    prompt=root@
#    Run Keyword if    ${gui_type}!=True    sleep    2
#    Run Keyword if    ${gui_type}!=True    cli    DUT_serial_port    netstat -tulpn | grep :80    prompt=root@
#    Run Keyword if    ${gui_type}!=True    sleep    2
#    Run Keyword if    ${gui_type}!=True    cli    DUT_serial_port    dmesg    prompt=root@
#    Run Keyword if    ${gui_type}!=True    sleep    2
#    Run Keyword if    ${gui_type}!=True    Fail    Login Fail
    #=======================================================================
    sleep    3
    Maximize Browser Window
    sleep    3

