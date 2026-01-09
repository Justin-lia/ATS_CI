*** Settings ***
#Resource    ./base.robot

*** Variables ***

*** Keywords ***
Delete an ACL Rule
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Click Element    xpath=//*[@id="acl_tbody_id_0"]/td[6]/button/img
    sleep    30
    Close Browser

Enable Service control on DUT, create a rule accept WAN access for http
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Enable ACL
    Click Add Button
    Click Element    id=lang_accept
    sleep    1
    Select Protocol to    HTTP
    Select Access Control to    WAN
    Select IP Protocol Type to    IPv4
    ${sourceIP}=    Get IP from host    wanhost
    Input Start IP Address    ${sourceIP}
    Input End IP Address    ${sourceIP}
    click element    id=leafConfirm
    sleep    30
    Close Browser

Enable Service control on DUT, create a rule deny WAN access for http
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Enable ACL
    Click Add Button
#    Enable Rule
    Click Element    id=lang_block
    sleep    1
    Select Protocol to    HTTP
    Select Access Control to    WAN
    Select IP Protocol Type to    IPv4
    ${sourceIP}=    Get IP from host    wanhost
    Input Start IP Address    ${sourceIP}
    Input End IP Address    ${sourceIP}
    click element    id=leafConfirm
    sleep    30
    Close Browser

Verify WAN PC use http Cannot access DUT's WebUI
    ${DUT_WAN_IP}=    Get DUT WAN IP
    ${result}=    cli    wanhost    \n
    ${result}=    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S curl -i "http://${DUT_WAN_IP}/login.html"    prompt=vagrant@WAN-host    timeout=150
    Should Contain Any    ${result}    couldn't connect to host    Connection timed out

Verify WAN PC use https Cannot access DUT's WebUI
    ${DUT_WAN_IP}=    Get DUT WAN IP
    ${result}=    cli    wanhost    \n
    ${result}=    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S curl -i "https://${DUT_WAN_IP}/login.html" -k    prompt=vagrant@WAN-host    timeout=120
    Should Contain    ${result}    couldn't connect to host

Verify WAN PC use https Can access DUT's WebUI
    ${DUT_WAN_IP}=    Get DUT WAN IP
    Wait Until Keyword Succeeds    2x    3s    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S curl -i "https://${DUT_WAN_IP}/login.html" -k    prompt=200 OK    timeout=30

Verify WAN PC use http Can access DUT's WebUI
    ${DUT_WAN_IP}=    Get DUT WAN IP
    Wait Until Keyword Succeeds    2x    3s    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S curl -i "http://${DUT_WAN_IP}/login.html"    prompt=200 OK    timeout=30

Disable Access control on DUT
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Disable ACL

Verify WAN PC can access DUT WAN IP by SSH
    ${DUT_WAN_IP}=    Get DUT WAN IP
    cli    wanhost    \n
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S rm /home/vagrant/.ssh/known_hosts
    cli    wanhost    \n
    cli    wanhost    ssh -oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=+ssh-rsa root@${DUT_WAN_IP}    prompt=established
    sleep    2

Verify WAN PC can access DUT WAN IP by Telent
    ${DUT_WAN_IP}=    Get DUT WAN IP
    cli    wanhost    \n
    cli    wanhost    telnet ${DUT_WAN_IP}    prompt=login

Create ACL SSH rule cannot be in Disable state, select WAN for Access Control, Source IP is WAN PC IP
    WAN PC Renew IP
    ${ip_wanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    wanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Enable ACL
    Click Add Button
    Click Element    id=lang_accept
    Select Protocol to    SSH
    Select Access Control to    WAN
    Select IP Protocol Type to    IPv4
    Input Start IP Address    ${ip_wanhost}
    Input End IP Address    ${ip_wanhost}
    click element    id=leafConfirm
    sleep    30
    Close Browser

Create ACL TELNET rule cannot be in Disable state, select WAN for Access Control, Source IP is WAN PC IP
    WAN PC Renew IP
    ${ip_wanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    wanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Enable ACL
    Click Add Button
    Click Element    id=lang_accept
    sleep    1
    Select Protocol to    TELNET
    Select Access Control to    WAN
    Select IP Protocol Type to    IPv4
    Input Start IP Address    ${ip_wanhost}
    Input End IP Address    ${ip_wanhost}
    click element    id=leafConfirm
    sleep    30
    Close Browser

Create ACL SSH rule cannot be in Disable state, select LAN for Access Control
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Enable ACL
    Click Add Button
    Click Element    id=lang_accept
    sleep    1
    Select Protocol to    SSH
    Select Access Control to    LAN
    Select IP Protocol Type to    IPv4
    Input Start IP Address    ${ip_lanhost}
    Input End IP Address    ${ip_lanhost}
    click element    id=leafConfirm
    sleep    30
    Close Browser


Create ACL TELNET rule cannot be in Disable state, select WAN for Access Control
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Enable ACL
    Click Add Button
    Click Element    id=lang_accept
    Select Protocol to    TELNET
    Select Access Control to    WAN
    Select IP Protocol Type to    IPv4
    Input Start IP Address    ${ip_lanhost}
    Input End IP Address    ${ip_lanhost}
    click element    id=leafConfirm
    sleep    30
    Close Browser

Verify LAN PC can access DUT WAN IP by SSH
    ${DUT_WAN_IP}=    Get DUT WAN IP
    cli    lanhost    \n
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S rm /home/vagrant/.ssh/known_hosts
    cli    lanhost    \n
    cli    lanhost    ssh root@${DUT_WAN_IP}    prompt=established
    sleep    2

Verify LAN PC can access DUT WAN IP by Telent
    ${DUT_WAN_IP}=    Get DUT WAN IP
    cli    lanhost    \n
    cli    lanhost    telnet ${DUT_WAN_IP}    prompt=login


Verify LAN PC can access DUT LAN IP by SSH
    ${result} =    cli    lanhost    ssh-keygen -f "/home/vagrant/.ssh/known_hosts" -R "192.168.1.1"
    ${result} =    cli    lanhost    ssh-keygen -f "/home/vagrant/.ssh/known_hosts" -R "192.168.1.1"
    ${result} =    cli    lanhost    ssh root@192.168.1.1    prompt=Are you sure you want to continue connecting

Verify LAN PC can access DUT by Telent
    [Tags]    @AUTHOR=Frank_Hung    testing2
    ${result} =    cli    DUT_LAN_Telnet    \n    prompt=root@
    ${result} =    cli    DUT_LAN_Telnet    ps    prompt=root@
    Should Contain    ${result}    root
    Should Contain    ${result}    httpd

Create ACL SSH rule cannot be in Disable state
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Enable ACL
    Click Add Button
    Click Element    id=lang_accept
    sleep    1
    Select Protocol to    SSH
    Select Access Control to    LAN
    Select IP Protocol Type to    IPv4
    Input Start IP Address    ${ip_lanhost}
    Input End IP Address    ${ip_lanhost}
    click element    id=leafConfirm
    sleep    30
    Close Browser

Create ACL TELNET rule cannot be in Disable state
    ${ip_lanhost}    Wait Until Keyword Succeeds    5x    3s    Get IP from host    lanhost
    Login GUI    ${URL}    ${DUT_Password}
    Open Service Ctrl Page
    Enable ACL
    Click Add Button
    Select Protocol to    TELNET
    Select Access Control to    LAN
    Select IP Protocol Type to    IPv4
    Enable Rule
    Input Start IP Address    ${ip_lanhost}
    Input End IP Address    ${ip_lanhost}
    click element    id=leafConfirm
    sleep    30
    Close Browser

Select IP Protocol Type to
     [Arguments]    ${target}
    Select From List By Value    id=ip_proto    ${target}
    sleep    1

Select Access Control to
     [Arguments]    ${target}
    Select From List By Value    id=access_ctrl    ${target}
    sleep    1

Select Protocol to
     [Arguments]    ${Protocol}
    Select From List By Value    id=protocol    ${Protocol}
    sleep    1

Input Start IP Address
    [Arguments]    ${ip}
    input_text    id=ip_start    ${ip}
    sleep    1

Input End IP Address
    [Arguments]    ${ip}
    input_text    id=ip_end    ${ip}
    sleep    1

Enable Rule
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_acl_rule_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_acl_rule_enable
    sleep    2

Disable Rule
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_acl_rule_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal checked'    click element    id=switch_layout_acl_rule_enable
    sleep    2

Click Add Button
    click element    xpath=//*[@id="btn_acl_add"]/a
    sleep    2

Disable ACL
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_acl_enabled    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal checked'    click element    id=switch_layout_acl_enabled
    sleep    30

Enable ACL
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_acl_enabled    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_acl_enabled
    sleep    30

Enable SSH Service
    Login GUI    ${URL}    ${DUT_Password}
    Open SSH Service Setup Page
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_ssh_enabled    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_ssh_enabled
    sleep    2
    click element    id=apply
    sleep    2
    Handle Alert
    sleep    30
    Close Browser

Enable Telent Service
    Login GUI    ${URL}    ${DUT_Password}
    Open Telent Service Setup Page
    ${enable_or_disable}=    get_element_attribute    xpath=//*[@id="main-content"]/div/form/div[1]/div/div    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='el-switch'    click element    xpath=//*[@id="main-content"]/div/form/div[1]/div/div
    sleep    2
    click element    xpath=//*[@class="el-form-item__content"]/button
    sleep    2
    click_alert_ok_button
    sleep    30
    Close Browser

Open Service Ctrl Page
    click element    id=menu_adv_setting
    sleep    2
    click element    id=menu_adv_setting_service_control
    sleep    2
    Wait until element is visible    id=switch_layout_acl_enabled
    sleep    1

Open SSH Service Setup Page
    click element    id=lang_mainmenu_adv_setting
    sleep    2
    click element    id=lang_submenu_adv_setting_ssh
    sleep    2
    Wait until element is visible    id=switch_layout_ssh_enabled
    sleep    1

Open Telent Service Setup Page
    click element    xpath=/html/body/div[1]/ul/li[4]/a/span
    sleep    2
    click element    xpath=/html/body/div[1]/div/div[1]/div/div[2]/div/h4/a[2]/span
    sleep    2
    Wait until element is visible    id=lang_telnet_apply_title
    sleep    1

Get IP from host
    [Arguments]    ${host}
    ${getIP}=    cli    ${host}    ifconfig ${DEVICES.${host}.interface} | grep "inet"
    @{getIP}=    Get Regexp Matches    ${getIP}    (\\d+\\.){3}\\d+
    ${getIP}=    Strip String    ${getIP}[0]
    [Return]    ${getIP}




