*** Settings ***
#Resource    ./base.robot

*** Variables ***

*** Keywords ***
LAN PC ping DUT LAN IP should ping Fail
    sleep    20
    ${ping_result}=    cli    lanhost    ping 8.8.8.8 -c 3
    Should Not Contain    ${ping_result}    ttl=

Config DUT system time zone to (GTM+8) from GUI
    Login GUI    ${URL}    ${DUT_Password}
    Open NTP Page
    sleep    1
    Select From List By Value    id=timezone    utc_p_8-0_0_0_taiwan
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=apply
    sleep    30
    Close Browser

Wait 180 seconds, Verify GUI show Login Page
    sleep    240
    wait_until_element_is_visible    id=acnt_passwd    timeout=10

Verify GUI show Rebooting message
    wait_until_element_is_visible    id=loading_message    timeout=10

Click Reboot Button
    click element    id=lang_reboot_btn_title
    sleep    4

Open Reboot Page
    click element    id=lang_mainmenu_management
    sleep    1
    click element    id=menu_management_reboot
    sleep    2

Select Protocol Type to IPv6 on DNS Diagnosis page
    Select From List By Value    id=nslookup_proto    IPv6
    sleep    1

Select Protocol Type to IPv6
    Select From List By Value    id=traceroute_proto    IPv6
    sleep    1

Click "Start" Button and Verify Return a URL represents to IP
    Click Element    id=nslookup_btn
    sleep    6
    ${result}=    Get Text    id=nslookup_result
    Should Contain    ${result}    ip6.arpa name = dns.google
    Close Browser

Click "Start" Button and Verify Return a IP represents to URL
    Click Element    id=nslookup_btn
    sleep    6
    ${result}=    Get Text    id=nslookup_result
    Should Contain Any    ${result}    www.google.com has AAAA address 2404:    Address: 2404:
    Close Browser

Click "Start" Button and Verify Result is Return 8.8.8.8.in-addr.arpa name = dns.google
    Click Element    id=nslookup_btn
    sleep    4
    ${result}=    Get Text    id=nslookup_result
    Should Contain    ${result}    8.8.8.8.in-addr.arpa name = dns.google
    Close Browser

Click "Start" Button and Verify Result is Return a IP represents to URL
    Click Element    id=nslookup_btn
    sleep    14
    ${result}=    Get Text    id=nslookup_result
    Should Contain    ${result}    Name: www.google.com
    Should Match Regexp    ${result}   Address: (\\d+\\.){3}\\d+
    Close Browser

Click "Start to Traceroute" Button and Verify Result is traceroute to 2001:1234:5678:9ABC::1
    Click Element    id=traceroute_btn
    sleep    4
    ${result}=    Get Text    id=traceroute_result
    Should Contain    ${result}    traceroute to 2001:1234:5678:9ABC::1
    Close Browser

Click "Start to Traceroute" Button and Verify Result is traceroute to www.google.com
    Click Element    id=traceroute_btn
    sleep    20
    ${result}=    Get Text    id=traceroute_result
    Should Contain    ${result}    traceroute to www.google.com
    Close Browser

Click "Start to Traceroute" Button and Verify Result is [traceroute to 8.8.8.8]
    Click Element    id=traceroute_btn
    sleep    20
    ${result}=    Get Text    id=traceroute_result
    Should Contain    ${result}    traceroute to 8.8.8.8
    Close Browser

Input 2001:4860:4860::8888 to [Target Address] on DNS Diagnosis Page
    Input Text    id=nslookup_ipurl    2001:4860:4860::8888
    sleep    1

Input 8.8.8.8 to [Target Address] on DNS Diagnosis Page
    Input Text    id=nslookup_ipurl    8.8.8.8
    sleep    1

Input www.google.com to [Target Address] on DNS Diagnosis Page
    Input Text    id=nslookup_ipurl    www.google.com
    sleep    1

Input www.google.com to [Target Address]
    Input Text    id=traceroute_ipurl    www.google.com
    sleep    1

Input 2001:1234:5678:9ABC::1 to [Target Address]
    Input Text    id=traceroute_ipurl    2001:1234:5678:9ABC::1
    sleep    1

Input 8.8.8.8 to [Target Address]
    Input Text    id=traceroute_ipurl    8.8.8.8
    sleep    1

Setup [Interface Selection] to WAN on DNS Diagnosis Page
    Select From List By Value    id=nslookup_iface    WAN1
    sleep    1

Setup [Interface Selection] to LAN on DNS Diagnosis Page
    Select From List By Value    id=nslookup_iface    lan
    sleep    1

Setup [Interface Selection] to WAN
    Select From List By Value    id=traceroute_iface    WAN1
    sleep    1

Setup [Interface Selection] to LAN
    Select From List By Value    id=traceroute_iface    lan
    sleep    1

Set DUT Time zone to GTM+10 on NTP Page
    Login GUI    ${URL}    ${DUT_Password}
    Open NTP Page
    sleep    1
    Select From List By Value    id=timezone    utc_p_10-0_0_0_guam
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=apply
    sleep    30
    Close Browser

Open NTP Page
    click element    id=lang_mainmenu_management
    sleep    1
    click element    id=menu_management_ntp
    wait_until_element_is_visible    id=timezone    timeout=10

Verify on DUT console, DUT default system time(GMT+10) should match current time(GMT+10)
    ${current_year}=   Get Time    return year    UTC + 10 hour
    ${current_month}=   Get Time    return month    UTC + 10 hour
    ${current_day}=   Get Time    return day    UTC + 10 hour
    ${current_hour}=   Get Time    return hour    UTC + 10 hour
    Run    echo "vagrant" | sudo -S chmod 777 /dev/ttyUSB0
    ${DUT_year}=    cli    DUT_serial_port    date "+%Y"    prompt=#
    ${DUT_year}=    Fetch from Left    ${DUT_year}    root
    ${DUT_year}=    Fetch from Right    ${DUT_year}    "+%Y"
    ${DUT_year}=    Strip String    ${DUT_year}
    ${DUT_month}=    cli    DUT_serial_port    date "+%m"    prompt=#
    ${DUT_month}=    Fetch from Left    ${DUT_month}    root
    ${DUT_month}=    Fetch from Right    ${DUT_month}    "+%m"
    ${DUT_month}=    Strip String    ${DUT_month}
    ${DUT_day}=    cli    DUT_serial_port    date "+%d"    prompt=#
    ${DUT_day}=    Fetch from Left    ${DUT_day}    root
    ${DUT_day}=    Fetch from Right    ${DUT_day}    "+%d"
    ${DUT_day}=    Strip String    ${DUT_day}
    ${DUT_hour}=    cli    DUT_serial_port    date "+%H"    prompt=#
    ${DUT_hour}=    Fetch from Left    ${DUT_hour}    root
    ${DUT_hour}=    Fetch from Right    ${DUT_hour}    "+%H"
    ${DUT_hour}=    Strip String    ${DUT_hour}
    Should Be Equal    ${current_year}    ${DUT_year}
    Should Be Equal    ${current_month}    ${DUT_month}
    Should Be Equal    ${current_day}    ${DUT_day}
    Should Be Equal    ${current_hour}    ${DUT_hour}


Verify on DUT console, DUT default system time(GMT+8) should match current time(GMT+8)
    ${ping_result}=    cli    lanhost    ping 8.8.8.8 -c 4
    ${current_year}=   Get Time    return year    UTC + 8 hour
    ${current_month}=   Get Time    return month    UTC + 8 hour
    ${current_day}=   Get Time    return day    UTC + 7 hour
    ${current_hour}=   Get Time    return hour    UTC + 8 hour
    Run    echo "vagrant" | sudo -S chmod 777 /dev/ttyUSB0
    ${DUT_year}=    cli    DUT_serial_port    date "+%Y"    prompt=#
    ${DUT_year}=    Fetch from Left    ${DUT_year}    root
    ${DUT_year}=    Fetch from Right    ${DUT_year}    "+%Y"
    ${DUT_year}=    Strip String    ${DUT_year}
    ${DUT_month}=    cli    DUT_serial_port    date "+%m"    prompt=#
    ${DUT_month}=    Fetch from Left    ${DUT_month}    root
    ${DUT_month}=    Fetch from Right    ${DUT_month}    "+%m"
    ${DUT_month}=    Strip String    ${DUT_month}
    ${DUT_day}=    cli    DUT_serial_port    date "+%d"    prompt=#
    ${DUT_day}=    Fetch from Left    ${DUT_day}    root
    ${DUT_day}=    Fetch from Right    ${DUT_day}    "+%d"
    ${DUT_day}=    Strip String    ${DUT_day}
    ${DUT_hour}=    cli    DUT_serial_port    date "+%H"    prompt=#
    ${DUT_hour}=    Fetch from Left    ${DUT_hour}    root
    ${DUT_hour}=    Fetch from Right    ${DUT_hour}    "+%H"
    ${DUT_hour}=    Strip String    ${DUT_hour}
    Should Be Equal    ${current_year}    ${DUT_year}
    Should Be Equal    ${current_month}    ${DUT_month}
    Should Be Equal    ${current_day}    ${DUT_day}
    Should Be Equal    ${current_hour}    ${DUT_hour}

Verify password can not be change and an error message appears
    click element    id=apply
    sleep    2
    ${message}=    Handle Alert
    Should Contain    ${message}    The password format is incorrect
    Close Browser

Enter New Password include other special character or wron format
    input text    id=new_pwd    !@#$%^&*
    sleep    1
    input text    id=confirm_pwd    !@#$%^&*
    sleep    1

Change the admin's password with correct old password
    input text    id=old_pwd    admin
    sleep    1

Verify the password can not be change and an error message appears
    ${message}=    Get Text    id=old_pwd_error_msg
    Should Contain    ${message}    Entered password is incorrect
    Close Browser

Change the admin's password with incorrect old password
    input_text    id=old_pwd    xxxxxxxx
    sleep    1
    input_text    id=new_pwd    admin
    sleep    1
    input_text    id=confirm_pwd    admin
    sleep    1
    click element    id=apply
    sleep    2

Open Account Managementment page
    click element    id=lang_mainmenu_management
    sleep    2
    click element    id=lang_submenu_management_account
    sleep    2
    wait_until_element_is_visible    id=old_pwd    timeout=10

Change the admin's password
    [Arguments]    ${oldPassword}    ${newPassword}
    input_text    id=old_pwd    ${oldPassword}
    sleep    1
    input_text    id=new_pwd    ${newPassword}
    sleep    1
    input_text    id=confirm_pwd    ${newPassword}
    sleep    1
    click element    id=apply
    sleep    5
    wait_until_element_is_visible    id=old_pwd    timeout=30

Reboot the DUT
    click element    id=lang_submenu_management_reboot
    sleep    1
    wait_until_element_is_visible    name=reboot_device    timeout=10
    click element    name=reboot_device
    sleep    240
    close browser
    sleep    2

Login to DUT with new password than set admin's password to admin
    Wait Until Keyword Succeeds    3x    4 sec    Retry Login to DUT with new password than set admin's password to admin

Retry Login to DUT with new password than set admin's password to admin
    open browser    ${URL}    Firefox
    sleep    5
    Maximize Browser Window
    sleep    3
    Wait until element is visible    id=acnt_passwd    timeout=180
    input text     id=acnt_username    admin
    sleep    1
    input_text    id=acnt_passwd    12345678
    sleep    1
    click element    id=lang_login_btn
    sleep    5
    Wait until element is not visible    id=loading_message    timeout=90
    sleep    1
    Open Account Managementment page
    Change the admin's password    12345678    admin
    Close Browser

Access Control_Passwords_admin account with incorrect old password
    input_text    id=old_pwd    admin12345678
    sleep    2
    input_text    id=new_pwd    12345678
    sleep    2
    input_text    id=confirm_pwd    12345678
    sleep    2
    click element    xpath=//*[@id="main-content"]/div/form/div[5]/div/button[1]
    sleep    5
    wait_until_element_is_visible    id=old_pwd_error    timeout=10
    ${message}=    Get Text    id=old_pwd_error
    Should Contain    ${message}    Entered password is incorrect!
    sleep    2
    Close Browser

Confirm whether the password meets the restrictions
    input_text    id=old_pwd    admin
    sleep    2
    input_text    id=new_pwd    !@#$%^&*()
    sleep    2
    input_text    id=confirm_pwd    !@#$%^&*()
    sleep    2
    click element    xpath=//*[@id="main-content"]/div/form/div[5]/div/button[1]
    sleep    5
    click_alert_ok_button
    sleep    3
    Close Browser

Check default time zone and the current time
    Open management page
    sleep    3
    wait_until_element_is_visible    id=submenu-management-ntp    timeout=10
    click element    id=submenu-management-ntp
    sleep    3
    ${message}=    get_element_value    id=timezone
    Should Contain    ${message}    utc_p_7-0_0_0_thailand
    ${getDUTtime}=    cli    ${DEVICES.console.vendor}    date    timeout=30
    ${result}=    Console Command    \n
    ${result}=    Console Command    \n
    ${getDUTtime}=    Fetch From Left    ${getDUTtime}    ICT
    ${time}=    get time    time_=NOW -1h
    ${converted_date}    Convert Date    ${time}    result_format=%a %b %e %H:%M:%S
    ${converted_year}    Convert Date    ${time}    result_format=%Y
    Should Contain    ${getDUTtime}    ${converted_date}
    Should Contain    ${getDUTtime}    ${converted_year}
    sleep    2
    Close Browser

Save Current Settings
    Open basic setup page
    sleep    3
    click element    id=lang_submenu_basic_setting_wlan
    sleep    2
    click element    id=lang_submenu_basic_setting_wlan_wifi_basic_allinone
    sleep    2
    input_text    id=2g_ssid    2GSSID12345678
    sleep    2
    input_text    id=5g_ssid    5GSSID12345678
    sleep    2
    click element    xpath=//*[@id="main-content"]/div/form/div/div[3]/div/button[1]
    sleep    20
    Open management page
    click element    id=lang_submenu_management_settings
    sleep    2
    click element    id=lang_submenu_management_settings_backup
    sleep    2
    click element    xpath=//*[@id="main-content"]/div[2]/div/form/div[1]/div/button
    sleep    2

Open IPv4 Configuration page
    Open basic setup page
    click element    id=lang_submenu_basic_setting_lan
    sleep    2
    click element    id=lang_submenu_basic_setting_lan_lan4
    sleep    2
    wait_until_element_is_visible    id=mask    timeout=10
    sleep    1

Change DUT's IP to "192.168.65.5"
    input_text    id=ip    192.168.65.5
    sleep    2
    click element    xpath=//*[@id="page_content_l1"]/form/div[8]/div/button[1]
    sleep    60

Reset by Local IP
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    sleep    5
    Run    sudo ifconfig eth3 192.168.65.51 netmask 255.255.255.0
    sleep    10
    run keyword and ignore error    Close Browser
    sleep    2
    open browser    http://192.168.65.5/
    sleep    3
    wait_until_element_is_visible    id=acnt_passwd    timeout=90
    input_text    id=acnt_passwd    ${DUT_Password}
    sleep    1
    click element    id=myButton
    sleep    5
    Wait until element is visible    id=lang_dev_info_name_title    timeout=30
    sleep    3
    run keyword and ignore error    Reset Default DUT
    Run    sudo ifconfig eth3 192.168.1.51 netmask 255.255.255.0

Open Ping Diagnosis page
    click element    id=lang_mainmenu_management
    sleep    1
    click element    id=lang_submenu_management_tools
    sleep    1
    click element    id=tab_ping
    sleep    2

On GUI Select Interface LAN
    Select From List By Value    id=ping_iface    lan
    sleep    1

On GUI Select Interface WAN
    Select From List By Value    id=ping_iface    WAN1
    sleep    1

On GUI Select Protocol IPv6
    Select From List By Value    id=ping_proto    IPv6
    sleep    1

Enter desination address: 2001:1234:5678:9ABC::1, Click "Start to Ping"
    input text    id=ping_ipurl    2001:1234:5678:9ABC::1
    sleep    1
    input text    id=ping_times    3
    sleep    1
    click element    id=ping_btn
    sleep    10

Enter desination address: 8.8.8.8, Click "Start to Ping"
    input text    id=ping_ipurl    8.8.8.8
    sleep    1
    input text    id=ping_times    3
    sleep    1
    click element    id=ping_btn
    sleep    10

Enter desination address: IP Address of LAN PC, Click "Start to Ping"
    ${LAN_PC_IP}=    Get IP from host    lanhost
    input text    id=ping_ipurl    ${LAN_PC_IP}
    sleep    1
    input text    id=ping_times    3
    sleep    1
    click element    id=ping_btn
    sleep    10

Verify ping result should success
    ${ping_result}=    Get Text    id=ping_result
    Should Contain    ${ping_result}    ttl=
    Close Browser

Get IP from host
    [Arguments]    ${host}
    ${getIP}=    cli    ${host}    ifconfig ${DEVICES.${host}.interface} | grep "inet"
    @{getIP}=    Get Regexp Matches    ${getIP}    (\\d+\\.){3}\\d+
    ${getIP}=    Strip String    ${getIP}[0]
    [Return]    ${getIP}

Verify LAN IPV4 ping LAN client
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    ${get_lanIP}=    cli   lanhost    ifconfig ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=60
    ${get_lanIP}=    Fetch From Right  ${get_lanIP}    inet addr:
    ${get_lanIP}=    Fetch From Left    ${get_lanIP}    Bcast
    ${get_lanIP}=    Strip String    ${get_lanIP}
    sleep    2
    input_text    id=ping_ipurl    ${get_lanIP}
    sleep    2
    click element    id=ping_btn
    sleep    2
    ${message}=    Get Text    id=ping_result
    Should Contain    ${message}    ttl=
    sleep    2

Verify LAN IPV4 ping 8.8.8.8
    input_text    id=ping_ipurl    8.8.8.8
    sleep    2
    click element    id=ping_btn
    sleep    2
    ${message}=    Get Text    id=ping_result
    Should Contain    ${message}    ttl=
    sleep    2

Verify WAN IPV4 ping LAN client
    Select From List By Value    id=ping_iface    WAN1
    sleep    2
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface} -r    prompt=vagrant@lanhost    timeout=60
    sleep    4
    ${ping_result}=    cli   lanhost    echo '${DEVICES.lanhost.password}' | sudo -S dhclient ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=90
    ${get_lanIP}=    cli   lanhost    ifconfig ${DEVICES.lanhost.interface}    prompt=vagrant@lanhost    timeout=60
    ${get_lanIP}=    Fetch From Right  ${get_lanIP}    inet addr:
    ${get_lanIP}=    Fetch From Left    ${get_lanIP}    Bcast
    ${get_lanIP}=    Strip String    ${get_lanIP}
    sleep    2
    input_text    id=ping_ipurl    ${get_lanIP}
    sleep    2
    click element    id=ping_btn
    sleep    2
    ${message}=    Get Text    id=ping_result
    Should Contain    ${message}    ttl=
    sleep    2

Verify WAN IPV4 ping 8.8.8.8
    input_text    id=ping_ipurl    8.8.8.8
    sleep    2
    click element    id=ping_btn
    sleep    2
    ${message}=    Get Text    id=ping_result
    Should Contain    ${message}    ttl=
    sleep    2

Open Trace Route Diagnosis page
    click element    id=lang_mainmenu_management
    sleep    1
    click element    id=menu_management_tools
    sleep    1
    click element    id=tab_traceroute
    sleep    2

Verify LAN Trace Route Diagnosis
    input_text    id=traceroute_ipurl    8.8.8.8
    sleep    2
    click element    id=traceroute_btn
    sleep    20
    ${message}=    Get Text    id=traceroute_result
    Should Contain    ${message}    ms
    sleep    2
    input_text    id=traceroute_ipurl    www.google.com
    sleep    2
    click element    id=traceroute_btn
    sleep    20
    ${message}=    Get Text    id=traceroute_result
    Should Contain    ${message}    ms
    sleep    2

Verify WAN Trace Route Diagnosis
    Select From List By Value    id=traceroute_iface    WAN1
    sleep    2
    input_text    id=traceroute_ipurl    8.8.8.8
    sleep    2
    click element    id=traceroute_btn
    sleep    20
    ${message}=    Get Text    id=traceroute_result
    Should Contain    ${message}    ms
    sleep    2
    input_text    id=traceroute_ipurl    www.google.com
    sleep    2
    click element    id=traceroute_btn
    sleep    20
    ${message}=    Get Text    id=traceroute_result
    Should Contain    ${message}    ms
    sleep    2

Open DNS Diagnosis page
    click element    id=lang_mainmenu_management
    sleep    2
    click element    id=menu_management_tools
    sleep    2
    click element    id=tab_nslookup
    sleep    2


Verify LAN DNS lookup by URL Address
    input_text    id=nslookup_ipurl    www.google.com
    sleep    2
    click element    id=nslookup_btn
    sleep    20
    ${message}=    Get Text    id=nslookup_result
    Should Contain    ${message}    Non-authoritative answer:
    Should Contain    ${message}    Name: www.google.com
    sleep    2

Verify WAN DNS lookup by URL Address
    Open management page
    sleep    1
    click element    id=lang_submenu_management_tools
    sleep    2
    click element    id=lang_submenu_management_tools_nslookup
    sleep    2
    Select From List By Value    id=nslookup_iface    WAN1
    sleep    2
    input_text    id=nslookup_ipurl    www.google.com
    sleep    2
    click element    id=nslookup_btn
    sleep    20
    ${message}=    Get Text    id=nslookup_result
    Should Contain    ${message}    Non-authoritative answer:
    Should Contain    ${message}    Name: www.google.com
    sleep    2

Verify that DNS lookup by IP Address
    Open management page
    sleep    1
    click element    id=lang_submenu_management_tools
    sleep    2
    click element    id=lang_submenu_management_tools_nslookup
    sleep    2
    input_text    id=nslookup_ipurl    8.8.4.4
    sleep    2
    click element    id=nslookup_btn
    sleep    20
    ${message}=    Get Text    id=nslookup_result
    Should Contain    ${message}    Non-authoritative answer:
    Should Contain    ${message}    4.4.8.8.in-addr.arpa name = dns.google
    sleep    2
    Select From List By Value    id=nslookup_iface    WAN1
    sleep    2
    input_text    id=nslookup_ipurl    8.8.4.4
    sleep    2
    click element    id=nslookup_btn
    sleep    20
    ${message}=    Get Text    id=nslookup_result
    Should Contain    ${message}    Non-authoritative answer:
    Should Contain    ${message}    4.4.8.8.in-addr.arpa name = dns.google
    sleep    2

One-time Reboot schedule > one hour
    Open management page
    sleep    1
    click element    id=lang_submenu_management_reboot
    sleep    2
    click element    xpath=//*[@id="main-content"]/div/form/div[2]/div/div
    sleep    2
    Select From List By Value    id=auto_reboot    bootup
    sleep    2
    Select From List By Value    id=auto_reboot_bootup_hour    1
    sleep    2
    click element    id=lang_reboot_save_btn
    sleep    3600
    ${result}=    Console Command    \n
    ${result}=    Console Command    \n
    sleep    1
    ${login}=    cli    ${DEVICES.console.vendor}    root    timeout=30
    sleep    2
    ${getIP}=    cli    ${DEVICES.console.vendor}    5/4jp6t03qup3    timeout=30
    ${getIP}=    cli    ${DEVICES.console.vendor}    ifconfig br0 | grep "inet addr"    prompt=Mask:255.    timeout=30
    ${result}=    Console Command    \n
    ${result}=    Console Command    \n
    ${getIP}=    Fetch From Right  ${getIP}    inet addr:
    Should Contain    ${getIP}   Bcast

One-time Reboot schedule > one day
    Open management page
    sleep    1
    click element    id=lang_submenu_management_reboot
    sleep    2
    click element    xpath=//*[@id="main-content"]/div/form/div[2]/div/div
    sleep    2
    Select From List By Value    id=auto_reboot    bootup
    sleep    2
    Select From List By Value    id=auto_reboot_bootup_day    1
    sleep    2
    Select From List By Value    id=auto_reboot_bootup_hour    1
    sleep    2
    click element    id=lang_reboot_save_btn
    sleep    3600
    run keyword and ignore error    Close Browser
    sleep    2
    open browser    ${URL}
    sleep    3
    ${status}=  Run Keyword And Return Status     wait_until_element_is_visible    id=acnt_passwd    timeout=90
    Run Keyword If    '${status}' == 'True'    Fail

Reapeat Reboot schedule
    Open management page
    sleep    1
    click element    id=lang_submenu_management_reboot
    sleep    2
    click element    xpath=//*[@id="main-content"]/div/form/div[2]/div/div
    sleep    2
    Select From List By Value    id=auto_reboot    bootup
    sleep    2
    Select From List By Value    id=auto_reboot_bootup_day    1
    sleep    2
    Select From List By Value    id=auto_reboot_bootup_hour    1
    sleep    2
    click element    id=lang_reboot_save_btn
    sleep    3600
    run keyword and ignore error    Close Browser
    sleep    2
    open browser    ${URL}
    sleep    3
    ${status}=  Run Keyword And Return Status     wait_until_element_is_visible    id=acnt_passwd    timeout=90
    Run Keyword If    '${status}' == 'True'    Fail

Update Firmware with the wrong file
    Open management page
    sleep    1
    click element    id=submenu_management_settings
    sleep    2
    click element    id=lang_submenu_management_settings_fw_upgrade
    sleep    2
    run keyword and ignore error    Choose File    id=filename    ../../keyword/file.txt
    click_alert_ok_button

Restore Configuration from wrong File
    Open management page
    sleep    1
    click element    id=submenu_management_settings
    sleep    2
    click element    id=submenu-management-settings-backup
    sleep    2
    run keyword and ignore error    Choose File    id=lang_select    ../../keyword/file.txt
    click_alert_ok_button

Open management page
    click element    id=lang_mainmenu_management
    sleep    5

Open basic setup page
    click element    id=lang_mainmenu_basic_setting
    sleep    2
    wait_until_element_is_visible    id=wan_mode    timeout=5

Open status page
    click element    id=lang_mainmenu_status
    sleep    2
    wait_until_element_is_visible    id=ipv4type1    timeout=5

Open White label Web GUI
    [Tags]   @AUTHOR=Frank_Hung
    [Arguments]    ${URL}
    open browser    ${URL}
    sleep    3

Reset Default DUT > change password
    [Tags]    @AUTHOR=Frank_Hung
    Go to Reset to Default Page > change password
    Reset to Default DUT > change password

Go to Reset to Default Page > change password
    click element    id=lang_mainmenu_management
    sleep   2
    click element    id=lang_submenu_management_settings
    sleep    2
    click element    id=lang_submenu_management_settings_reset_dafault
    sleep    5

Reset to Default DUT > change password
    Wait until element is visible    xpath=//*[@class="col-xs-12"]/button
    sleep    1
    click element    xpath=//*[@class="col-xs-12"]/button
    sleep    2
    click_alert_ok_button
    sleep    300
    close browser
    sleep    2
    Open White label Web GUI    ${URL}
#------Login GUI if detect login button
    sleep    5
    Wait until element is visible    id=acnt_passwd    timeout=180
    input_text    id=acnt_passwd    12345678
    sleep    1
    click element    id=myButton
    sleep    5
    Wait until element is visible    id=lang_dev_info_name_title    timeout=30
    sleep    3
