*** Settings ***

*** Variables ***

*** Keywords ***
Verify MAC address format must be correct. ex: 98:10:E8:ED:4F:5D
    input text    id=macfilter_smac    1.2.3.4
    sleep    1
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    ${message} =    Handle Alert
    Should Contain    ${message}    The Source MAC Address field format is incorrect
    Close Browser

Verify MAC address cannot be blank
    Clear Element Text    id=macfilter_smac
    sleep    1
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    ${message} =    Handle Alert
    Should Contain    ${message}    The Source MAC Address field format is incorrect

Verify MAC address cannot be repeated
    click element    id=lang_Blacklist
    sleep    1
    ${mac}=    get MAC from host    lanhost
    input text    id=macfilter_smac    ${mac}
    sleep    1
    input text    id=macfilter_comment    1234
    sleep    1
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=apply
    sleep    30
    input text    id=macfilter_smac    ${mac}
    sleep    1
    input text    id=macfilter_comment    123456
    sleep    1
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    ${message}=    run keyword and ignore error    Handle Alert
    Should Contain    ${message}    This MAC Address has already been reserved

Remove LAN PC local address from Current Blacklist Filter Table on MAC Filtering Page
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    xpath=//*[@id="macfilter_table_id_0"]/td[4]/button/img
    sleep    1
    click element    id=apply
    sleep    30
    Close Browser

Enable MAC Filtering and add LAN PC IP Address to White list
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_macfilter_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_macfilter_enable
    sleep    2
    click element    id=lang_Whitelist
    sleep    1
    ${mac}=    get MAC from host    lanhost
    input text    id=macfilter_smac    ${mac}
    sleep    1
    input text    id=macfilter_comment    1234
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    click element    id=apply
    sleep    30
    Close Browser

Enable MAC Filtering and add LAN PC IP Address to Black list
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_macfilter_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_macfilter_enable
    sleep    30
    click element    id=lang_Blacklist
    sleep    1
    ${mac}=    get MAC from host    lanhost
    input text    id=macfilter_smac    ${mac}
    sleep    1
    input text    id=macfilter_comment    1234
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    click element    id=apply
    sleep    30
    Close Browser

Verify LAN PC can access Internet by wget
    ${result}=    cli   lanhost    wget -p "https://www.google.com/" -T 10 -t 1    prompt=vagrant@lanhost    timeout=60
    Should Contain    ${result}   200 OK

Remove LAN PC local address from Current Blacklist Filter Table
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    xpath=//*[@id="ipfilter_table_id_0"]/td[6]/button/img
    sleep    1
    click element    id=apply
    sleep    30
    Close Browser

Disable IP Filtering on GUI and save Settings
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_ipfilter_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal checked'    click element    id=switch_layout_ipfilter_enable
    sleep    40
    Close Browser

Enable IP Filtering on GUI
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_ipfilter_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_ipfilter_enable
    sleep    30

Open IP Filtering page
    Open basic setup page
    sleep    2
    click element    id=lang_submenu_basic_setting_seciruty
    sleep    2
    click element    id=tab_ipfilter
    sleep    2
    wait_until_element_is_visible    id=switch_layout_ipfilter_enable    timeout=10

Add a LAN PC to IPv4 Black list
    click element    id=lang_Blacklist
    sleep    1
    click element    id=lang_Enable IPv4
    sleep    1
    ${lan_pc_IP}=    Get IP from host    lanhost
    input_text    id=ipfilter_local_ip_start    ${lan_pc_IP}
    sleep    1
    input_text    id=ipfilter_local_ip_end    ${lan_pc_IP}
    sleep    1
    input_text    id=ipfilter_comment    1234
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    click element    id=apply
    sleep    60
    ${result}=    Get Text    xpath=//*[@id="ipfilter_table_id_0"]/td[5]
    Should Contain     ${result}    1234
    Close Browser

Add a LAN PC to IPv6 White list
    click element    id=lang_Whitelist
    sleep    1
    click element    id=lang_Enable IPv6
    sleep    1
    ${lan_pc_IP}=    Get v6IP from host    lanhost
    input_text    id=ipfilter_local_ip_start    2001:5::0
    sleep    1
    input_text    id=ipfilter_local_ip_end    2001:5:ffff:ffff:ffff:ffff:ffff:ffff
    sleep    1
    input_text    id=ipfilter_comment    1234
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    click element    id=apply
    sleep    30
    ${result}=    Get Text    xpath=//*[@id="ipfilter_table_id_0"]/td[5]
    Should Contain     ${result}    1234
    Close Browser

Add a LAN PC to IPv6 Black list
    click element    id=lang_Blacklist
    sleep    1
    click element    id=lang_Enable IPv6
    sleep    1
    ${lan_pc_IP}=    Get v6IP from host    lanhost
    input_text    id=ipfilter_local_ip_start    2001:5::0
    sleep    1
    input_text    id=ipfilter_local_ip_end    2001:5:ffff:ffff:ffff:ffff:ffff:ffff
    sleep    1
    input_text    id=ipfilter_comment    1234
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    click element    id=apply
    sleep    30
    ${result}=    Get Text    xpath=//*[@id="ipfilter_table_id_0"]/td[5]
    Should Contain     ${result}    1234
    Close Browser

Add a LAN PC to IPv4 White list
    click element    id=lang_Whitelist
    sleep    1
    click element    id=lang_Enable IPv4
    sleep    1
    ${lan_pc_IP}=    Get IP from host    lanhost
    input_text    id=ipfilter_local_ip_start    ${lan_pc_IP}
    sleep    1
    input_text    id=ipfilter_local_ip_end    ${lan_pc_IP}
    sleep    1
    input_text    id=ipfilter_comment    1234
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    xpath=//*[@id="btn_add_filter"]/a
    sleep    2
    click element    id=apply
    sleep    30
    ${result}=    Get Text    xpath=//*[@id="ipfilter_table_id_0"]/td[5]
    Should Contain     ${result}    1234
    Close Browser

Get v6IP from host
    [Arguments]    ${host}
    ${getIP}=    cli    ${host}    ifconfig ${DEVICES.${host}.interface} | grep "global"
    @{getIP}=    Get Regexp Matches    ${getIP}    ([0-9a-fA-F]{4}[:])([0-9a-fA-F]{0,4}[:]){0,6}([0-9a-fA-F]{0,4})
    ${getIP}=    Strip String    ${getIP}[0]
    [Return]    ${getIP}

get MAC from host
    [Arguments]    ${host}
    ${getMAC}=    cli    ${host}    ifconfig ${DEVICES.${host}.interface} | grep "ether"
    @{getMAC}=    Get Regexp Matches    ${getMAC}    (?:[0-9A-Fa-f]{2}[:-]){5}(?:[0-9A-Fa-f]{2})
    ${getMAC}=    Strip String    ${getMAC}[0]
    [Return]    ${getMAC}

Get IP from host
    [Arguments]    ${host}
    ${getIP}=    cli    ${host}    ifconfig ${DEVICES.${host}.interface} | grep "inet"
    @{getIP}=    Get Regexp Matches    ${getIP}    (\\d+\\.){3}\\d+
    ${getIP}=    Strip String    ${getIP}[0]
    [Return]    ${getIP}

Verify LAN PC can access to DUT
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${ping_result}=    cli   lanhost    ping -c 4 192.168.1.1    prompt=vagrant@lanhost    timeout=60
    Should Contain    ${ping_result}   ttl

Verify LAN PC can access to WAN PC by iperf3
    Wait Until Keyword Succeeds    3x    2s    retry Verify LAN PC can access to WAN PC by iperf3

retry Verify LAN PC can access to WAN PC by iperf3
    WAN PC use iperf3 for listen
    ${result}=    LAN PC use iperf3 for transmit message to WAN PC
    Should Contain    ${result}    connected to

Verify LAN PC cannot access to WAN PC by iperf3
     Repeat Keyword    3 times    retry Verify LAN PC cannot access to WAN PC by iperf3


retry Verify LAN PC cannot access to WAN PC by iperf3
    WAN PC use iperf3 for listen
    ${result}=    LAN PC use iperf3 for transmit message to WAN PC
    Should Not Contain    ${result}    connected to

LAN PC use iperf3 for transmit message to WAN PC
    ${WAN_v6_IP_Address}=    Get v6IP from host    wanhost

    Telnet.Close All Connections
    Wait Until Keyword Succeeds    3x    2s    cli   wanhost    rm /home/vagrant/tshark_file
    Telnet.Open Connection    ${DEVICES.lanhost.ip}    timeout=60    prompt=${DEVICES.lanhost.prompt}     port=${DEVICES.lanhost.port}
    Telnet.Login    ${DEVICES.lanhost.user_name}    ${DEVICES.lanhost.password}    login_prompt=${DEVICES.lanhost.login_prompt}    password_prompt=${DEVICES.lanhost.password_prompt}
    Telnet.Set Timeout    ${DEVICES.lanhost.timeout}
    ${result}=    Telnet.Read

    Telnet.Set Prompt    vagrant@
    ${result}=    Telnet.Execute Command    echo '${DEVICES.lanhost.password}' | sudo -S killall iperf3
    sleep    2
    ${result}=    Telnet.Execute Command    iperf3 -c ${WAN_v6_IP_Address} -6 -t 1 > temp.txt&
    sleep    4
    ${result}=    Telnet.Execute Command    cat temp.txt
    log    ${result}
    [Return]    ${result}

WAN PC use iperf3 for listen
    Telnet.Close All Connections
    Wait Until Keyword Succeeds    3x    2s    cli   wanhost    rm /home/vagrant/tshark_file
    Telnet.Open Connection    ${DEVICES.wanhost.ip}    timeout=60    prompt=${DEVICES.wanhost.prompt}     port=${DEVICES.wanhost.port}
    Telnet.Login    ${DEVICES.wanhost.user_name}    ${DEVICES.wanhost.password}    login_prompt=${DEVICES.wanhost.login_prompt}    password_prompt=${DEVICES.wanhost.password_prompt}
    Telnet.Set Timeout    ${DEVICES.wanhost.timeout}
    ${result}=    Telnet.Read

    Telnet.Set Prompt    vagrant@
    ${result}=    Telnet.Execute Command    echo '${DEVICES.wanhost.password}' | sudo -S killall iperf3
    sleep    2
    ${result}=    Telnet.Execute Command    iperf3 -s -6&
    log    ${result}

Verify LAN PC cannot access to Internet
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${result}=    cli   lanhost    wget -p "https://www.google.com/" -T 10 -t 1    prompt=vagrant@lanhost    timeout=60
    Should Contain    ${result}   failed:

Remove IPv4 Black list client
    click element    xpath=//*[@id="ipfilter_table"]/tr/td[6]/a
    sleep    2
    run keyword and ignore error    click element    xpath=//*[@id="lang_apply_btn_title"]
    sleep    60

Check LAN PC can access to Internet
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${ping_result}=    cli   lanhost    wget --timeout=30 --tries=1 buffalo.jp    prompt=vagrant@lanhost    timeout=60
    Should Contain     ${ping_result}    HTTP request sent, awaiting response
    Should Contain     ${ping_result}    OK
    Should Contain     ${ping_result}    connected
    Close Browser

Enable IPv4 White list and add LAN PC local address
    click element    id=ipfilter_whitelist
    sleep    2
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${get_lanIP}=    cli   lanhost    ifconfig ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=60
    ${get_lanIP}=    Fetch From Right  ${get_lanIP}    inet addr:
    ${get_lanIP}=    Fetch From Left    ${get_lanIP}    Bcast
    ${get_lanIP}=    Strip String    ${get_lanIP}
    input_text    id=ipfilter_local_ip_start    ${get_lanIP}
    sleep    2
    input_text    id=ipfilter_local_ip_end    ${get_lanIP}
    sleep    2
    click element    id=lang_ipfilter_add_btn
    sleep    2
    run keyword and ignore error    click element    xpath=//*[@id="lang_apply_btn_title"]
    sleep    60

LAN PC can access the Internet
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${ping_result}=    cli   lanhost    wget --timeout=30 --tries=1 buffalo.jp    prompt=vagrant@lanhost    timeout=60
    Should Contain     ${ping_result}    HTTP request sent, awaiting response
    Should Contain     ${ping_result}    OK
    Should Contain     ${ping_result}    connected
    Close Browser

Remove IPv4 White list client
    click element    xpath=//*[@id="ipfilter_table"]/tr/td[6]/a
    sleep    2
    run keyword and ignore error    click element    xpath=//*[@id="lang_apply_btn_title"]
    sleep    60

LAN PC can't access to Internet
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${ping_result}=    cli   lanhost    wget --timeout=30 --tries=1 buffalo.jp    prompt=vagrant@lanhost    timeout=60
    Should Contain     ${ping_result}    failed: Connection timed out
    Close Browser

Check Whitelist / Blacklist function is not work
    ${ping_result}=    cli   lanhost    ping -c 4 192.168.1.1    prompt=vagrant@lanhost    timeout=60
    Should Contain     ${ping_result}    ttl=

Open MAC Filtering page
    Open basic setup page
    sleep    2
    click element    id=lang_submenu_basic_setting_seciruty
    sleep    2
    click element    id=tab_macfilter
    sleep    2
    wait_until_element_is_visible    id=switch_layout_macfilter_enable    timeout=10

Enable MAC Filtering and add a client
    click element    xpath=//*[@id="main-content"]/div[1]/div[2]/div/span
    sleep    15
    wait_until_element_is_visible    id=macfilter_smac    timeout=30
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${ping_result}=    cli   lanhost    ping 8.8.8.8 -c 4    prompt=vagrant@lanhost    timeout=60
    Should Contain     ${ping_result}    ttl=
    ${get_lanpc_mac}=    cli   lanhost    ifconfig ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=60
    ${get_lanpc_mac}=    Fetch From Right  ${get_lanpc_mac}    HWaddr
    ${get_lanpc_mac}=    Fetch From Left    ${get_lanpc_mac}    inet addr:
    ${get_lanpc_mac}=    Strip String    ${get_lanpc_mac}
    input_text    id=macfilter_smac    ${get_lanpc_mac}
    sleep    2
    click element    xpath=//*[@id="main-content"]/div[5]/div[2]/button
    sleep    2
    run keyword and ignore error    click element    xpath=//*[@id="main-content"]/div[6]/div[2]/div/div/button
    sleep    60
    Close Browser

Check LAN PC can not access to Internet > Ping
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${ping_result}=    cli   lanhost    ping 8.8.8.8 -c 4    prompt=vagrant@lanhost    timeout=60
    Should NOT Contain     ${ping_result}    ttl=

Check LAN PC can access to Internet > Ping
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${ping_result}=    cli   lanhost    ping 8.8.8.8 -c 4    prompt=vagrant@lanhost    timeout=60
    Should Contain     ${ping_result}    ttl=

Remove Black list client
    run keyword and ignore error    click element    xpath=//*[@id="macfilter_table"]/tr/td[4]/a
    sleep    5
    run keyword and ignore error    click element    xpath=//*[@id="main-content"]/div[6]/div[2]/div/div/button
    sleep    60
    wait_until_element_is_visible    id=macfilter_smac    timeout=30
    Close Browser

Enable White list and add a client
    click element    id=mode_whitelist
    sleep    5
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    15
    ${get_lanpc_mac}=    cli   lanhost    ifconfig ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=60
    ${get_lanpc_mac}=    Fetch From Right  ${get_lanpc_mac}    HWaddr
    ${get_lanpc_mac}=    Fetch From Left    ${get_lanpc_mac}    inet addr:
    ${get_lanpc_mac}=    Strip String    ${get_lanpc_mac}
    input_text    id=macfilter_smac    ${get_lanpc_mac}
    sleep    2
    click element    xpath=//*[@id="main-content"]/div[5]/div[2]/button
    sleep    2
    run keyword and ignore error    click element    xpath=//*[@id="main-content"]/div[6]/div[2]/div/div/button
    sleep    60
    wait_until_element_is_visible    id=macfilter_smac    timeout=30
    Close Browser

Remove White list client
    run keyword and ignore error    click element    xpath=//*[@id="macfilter_table"]/tr/td[4]/a
    sleep    5
    run keyword and ignore error    click element    xpath=//*[@id="main-content"]/div[6]/div[2]/div/div/button
    sleep    60
    wait_until_element_is_visible    id=macfilter_smac    timeout=30
    Close Browser

GUI Check mac value
    input_text    id=macfilter_smac    08:00:27:D0:90:CC
    sleep    2
    click element    xpath=//*[@id="main-content"]/div[5]/div[2]/button
    sleep    2
    input_text    id=macfilter_smac    08:00:27:D0:90:CC
    sleep    2
    click element    xpath=//*[@id="main-content"]/div[5]/div[2]/button
    sleep    2
    click_alert_ok_button
    input_text    id=macfilter_smac    ${EMPTY}
    sleep    2
    click element    xpath=//*[@id="main-content"]/div[5]/div[2]/button
    sleep    2
    click_alert_ok_button
    input_text    id=macfilter_smac    ergfhew9ifh38j
    sleep    2
    click element    xpath=//*[@id="main-content"]/div[5]/div[2]/button
    sleep    2
    click_alert_ok_button
    Close Browser

Chech wan status
    ${message}=    Get Text    id=ipv4status1
    Should Contain    ${message}    Connected
    sleep    2

Chech lan status
    run keyword and ignore error    click element    id=submenu-status-lan
    sleep    2
    ${message1}=    Get Text    xpath=//*[@id="lan_ethernet_tbody"]/tr/td[2]/div
    Should Contain    ${message}    Up
    sleep    2

Open basic setup page
    click element    id=lang_mainmenu_basic_setting
    sleep    2

Open status page
    click element    id=lang_mainmenu_status
    sleep    2
    wait_until_element_is_visible    id=ipv4type1    timeout=5


