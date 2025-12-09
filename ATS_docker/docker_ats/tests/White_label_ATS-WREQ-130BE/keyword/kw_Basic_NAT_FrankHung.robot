*** Settings ***
#Resource    ./base.robot

*** Variables ***

*** Keywords ***
Enable DMZ option, Interface Selection field select to WAN1, Enter ip address of LAN PC in DMZ Host IP Address field
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open DMZ Host Page
    Enable DMZ
    Change [Interface Selection :] to WAN1
    Enter ip address to [DMZ Host IP Address :]    ${ip_lanhost}
    click element    id=add_btn
    sleep    60
    Close Browser

Enter ip address to [DMZ Host IP Address :]
    [Arguments]    ${ip}
    input_text    id=dmz_host_ip    ${ip}
    sleep    1

Change [Interface Selection :] to WAN1
    Select From List By Value    id=dmz_wan    WAN1
    sleep    1

Enable DMZ
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_dmz_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_dmz_enable
    sleep    2

Open DMZ Host Page
    click element    id=lang_mainmenu_basic_setting
    sleep    2
    click element    id=lang_submenu_basic_setting_nat
    sleep    2
    click element    id=tab_dmz
    sleep    2
    Wait until element is visible    id=switch_layout_dmz_enable
    sleep    1

Create a Port forwarding Rule, [External Port] to 3000~4000, [Internal Port] to 3000~4000, [Protocol] to Both
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open Port Forwarding Page
    Set [External Port Range] to    3000    4000
    Set [Local IP Address] to    ${ip_lanhost}
    Set [Internal Port Range] to    3000    4000
    Set [Protocol] to    both
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=leafConfirm
    sleep    60
    Close Browser

Verify LAN PC cannot capture the UDP packets from WAN PC
    [Arguments]    ${port_number}
    sleep    5
    ${capture_result}=    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   cat tshark_file
    Log    ${capture_result}
    ${ip_wanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    wanhost
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Should not Contain    ${capture_result}    Dst Port: ${port_number}
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    rm tshark_file
    [Teardown]    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S killall tshark

Verify LAN PC cannot capture the TCP packets from WAN PC
    [Arguments]    ${port_number}
    sleep    5
    ${capture_result}=    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   cat tshark_file
    Log    ${capture_result}
    ${ip_wanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    wanhost
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Should not Contain    ${capture_result}    Dst Port: ${port_number}
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    rm tshark_file
    [Teardown]    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S killall tshark

Create a Port forwarding Rule, [External Port] to 1000~2000, [Internal Port] to 1000~2000, [Protocol] to UDP
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open Port Forwarding Page
    Set [External Port Range] to    1000    2000
    Set [Local IP Address] to    ${ip_lanhost}
    Set [Internal Port Range] to    1000    2000
    Set [Protocol] to    udp
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=leafConfirm
    sleep    60
    Close Browser



Create a Port forwarding Rule, [External Port] to 1000~2000, [Internal Port] to 1000~2000, [Protocol] to TCP
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open Port Forwarding Page
    Set [External Port Range] to    1000    2000
    Set [Local IP Address] to    ${ip_lanhost}
    Set [Internal Port Range] to    1000    2000
    Set [Protocol] to    tcp
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=leafConfirm
    sleep    60
    Close Browser

Get IP from host
    [Arguments]    ${host}
    ${getIP}=    cli    ${host}    ifconfig ${DEVICES.${host}.interface} | grep "inet"
    @{getIP}=    Get Regexp Matches    ${getIP}    (\\d+\\.){3}\\d+
    ${getIP}=    Strip String    ${getIP}[0]
    [Return]    ${getIP}


Set [Protocol] to
    [Arguments]    ${protocol}
    Select From List By Value    id=pfr_item_proto    ${protocol}
    sleep    1

Set [Internal Port Range] to
    [Arguments]    ${start_port}    ${end_port}
    input_text    id=pfr_item_local_ipaddr_start    ${start_port}
    sleep    1
    input_text    id=pfr_item_local_ipaddr_end    ${end_port}
    sleep    1

Set [Local IP Address] to
    [Arguments]    ${ip}
    input_text    id=pfr_item_local_ipaddr    ${ip}
    sleep    1

Set [External Port Range] to
    [Arguments]    ${start_port}    ${end_port}
    click element    id=add_btn
    sleep    2
    input_text    id=pfr_item_remote_ipaddr_start    ${start_port}
    sleep    1
    input_text    id=pfr_item_remote_ipaddr_end    ${end_port}
    sleep    1

Open Port Forwarding Page
    click element    id=lang_mainmenu_basic_setting
    sleep    2
    click element    id=menu_basic_setting_nat
    sleep    2
    click element    id=tab_portforward
    sleep    2
    Wait until element is visible    id=add_btn
    sleep    3

Verify LAN PC can capture the ICMP packets from WAN PC
    sleep    5
    ${capture_result}=    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   cat tshark_file
    Log    ${capture_result}
    ${ip_wanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    wanhost
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Should Contain    ${capture_result}    Protocol: ICMP
    Should Contain    ${capture_result}    Source Address: ${ip_wanhost}
    Should Contain    ${capture_result}    Destination Address: ${ip_lanhost}
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    rm tshark_file
    [Teardown]    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S killall tshark

Verify LAN PC can capture the UDP packets on Port 3000 from WAN PC
    [Arguments]    ${port_number}
    sleep    5
    ${capture_result}=    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   cat tshark_file
    Log    ${capture_result}
    ${ip_wanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    wanhost
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Should Contain    ${capture_result}    Dst Port: 3000
    Should Contain    ${capture_result}    Source Address: ${ip_wanhost}
    Should Contain    ${capture_result}    Destination Address: ${ip_lanhost}
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    rm tshark_file
    [Teardown]    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S killall tshark

Verify LAN PC can capture the UDP packets from WAN PC
    [Arguments]    ${port_number}
    sleep    5
    ${capture_result}=    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   cat tshark_file
    Log    ${capture_result}
    ${ip_wanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    wanhost
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Should Contain    ${capture_result}    Dst Port: ${port_number}
    Should Contain    ${capture_result}    Source Address: ${ip_wanhost}
    Should Contain    ${capture_result}    Destination Address: ${ip_lanhost}
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    rm tshark_file
    [Teardown]    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S killall tshark

Verify LAN PC can capture the TCP packets on Port 3000 from WAN PC
    [Arguments]    ${port_number}
    sleep    5
    ${capture_result}=    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   cat tshark_file
    Log    ${capture_result}
    ${ip_wanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    wanhost
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Should Contain    ${capture_result}    Destination Port: 3000
    Should Contain    ${capture_result}    Source Address: ${ip_wanhost}
    Should Contain    ${capture_result}    Destination Address: ${ip_lanhost}
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    rm tshark_file
    [Teardown]    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S killall tshark

Verify LAN PC can capture the TCP packets from WAN PC
    [Arguments]    ${port_number}
    sleep    5
    ${capture_result}=    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   cat tshark_file
    Log    ${capture_result}
    ${ip_wanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    wanhost
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Should Contain    ${capture_result}    Dst Port: ${port_number}
    Should Contain    ${capture_result}    Source Address: ${ip_wanhost}
    Should Contain    ${capture_result}    Destination Address: ${ip_lanhost}
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    rm tshark_file
    [Teardown]    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S killall tshark

LAN PC start capturing ICMP packets
    [Tags]    @AUTHOR=Frank_Hung
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    rm tshark_file
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S tshark -i ${DEVICES.lanhost.interface} -Y 'ip.src==172.16.11.4&&icmp' -V -a duration:100> tshark_file&    prompt=Capturing on



LAN PC start capturing UDP packets
    [Tags]    @AUTHOR=Frank_Hung
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    rm tshark_file
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S tshark -i ${DEVICES.lanhost.interface} -Y 'ip.src==172.16.11.4&&udp' -V -a duration:100> tshark_file&    prompt=Capturing on



LAN PC start capturing TCP packets
    [Tags]    @AUTHOR=Frank_Hung
    Telnet.Open Connection    ${DEVICES.lanhost.ip}    timeout=60    prompt=${DEVICES.lanhost.prompt}     port=${DEVICES.lanhost.port}
    Telnet.Login    ${DEVICES.lanhost.user_name}    ${DEVICES.lanhost.password}    login_prompt=${DEVICES.lanhost.login_prompt}    password_prompt=${DEVICES.lanhost.password_prompt}
    Telnet.Set Timeout    ${DEVICES.lanhost.timeout}
    ${result}=    Telnet.Read
    Telnet.Set Prompt    Capturing on
    ${result}=    Telnet.Write    echo '${DEVICES.lanhost.password}' | sudo -S tshark -i ${DEVICES.lanhost.interface} -Y 'ip.src==172.16.11.4&&tcp' -V -a duration:100> tshark_file&
    log    ${result}

With WAN PC ping to DUT WAN IP
    WAN PC Renew IP
    ${DUT_WAN_IP}=    Get DUT WAN IP
    Wait Until Keyword Succeeds    3x    2s    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S ping -c 4 ${DUT_WAN_IP}


With WAN PC send UDP packets to DUT WAN IP
    [Arguments]    ${port_number}
    WAN PC Renew IP
    ${DUT_WAN_IP}=    Get DUT WAN IP
    Wait Until Keyword Succeeds    3x    2s    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S hping3 ${DUT_WAN_IP} -2 -p ${port_number} -I ${DEVICES.wanhost.interface} -c 4


With WAN PC send TCP packets to DUT WAN IP
    [Tags]    @AUTHOR=Frank_Hung
    [Arguments]    ${port_number}
    WAN PC Renew IP
    ${DUT_WAN_IP}=    Get DUT WAN IP
    Wait Until Keyword Succeeds    3x    2s    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S hping3 ${DUT_WAN_IP} -S -p ${port_number} -I ${DEVICES.wanhost.interface} -c 4



Verify LAN PC can Create a L2TP Connection
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S nmcli connection up "l2tp-test-2"
    sleep    5
    cli    lanhost    \n
    sleep    1
    ${result}=    cli    lanhost    ifconfig
    log    ${result}
    Should Contain    ${result}    ppp0
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S nmcli connection down "l2tp-test-2"
    sleep    5
    ${result}=    cli    lanhost    ifconfig
    log    ${result}
    Should Not Contain    ${result}    ppp0

Verify LAN PC can Create a PPTP Connection
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S nmcli connection up "pptp-test-2"
    sleep    5
    cli    lanhost    \n
    sleep    1
    ${result}=    cli    lanhost    ifconfig
    log    ${result}
    Should Contain    ${result}    ppp
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S nmcli connection down "pptp-test-2"
    sleep    5
    ${result}=    cli    lanhost    ifconfig
    log    ${result}
    Should Not Contain    ${result}    ppp

Enable L2TP passthrough on DUT
    Login GUI    ${URL}    ${DUT_Password}
    Open ALG Page
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_l2tp_pth    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_l2tp_pth
    sleep    2
    click element    id=btn_apply
    sleep    60
    Close Browser



Enable PPTP and IPSEC passthrough on DUT
    Login GUI    ${URL}    ${DUT_Password}
    Open ALG Page
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_pptp_pth    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_pptp_pth
    sleep    2

    ${enable_or_disable}=    get_element_attribute    id=switch_layout_ipsec_pth    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_ipsec_pth
    sleep    2

    click element    id=btn_apply
    sleep    60
    Close Browser


Open ALG Page
    click element    id=lang_mainmenu_basic_setting
    sleep    2
    click element    id=lang_submenu_basic_setting_nat
    sleep    2
    click element    id=tab_alg
    sleep    2
    Wait until element is visible    id=switch_layout_pptp_pth
    sleep    1


Enable NAT on DUT
    Login GUI    ${URL}    ${DUT_Password}
    Open WAN Page
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_nat    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_nat
    sleep    2
    click element    id=apply
    sleep    200
    Close Browser
    Verify LAN PC can access buffalo.jp


Verify LAN PC cannot access buffalo.jp
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=60
    sleep    15
    ${ping_result}=    cli   lanhost    ping buffalo.jp -c 4    prompt=vagrant@lanhost    timeout=60
    Should Not Contain     ${ping_result}    ttl=




