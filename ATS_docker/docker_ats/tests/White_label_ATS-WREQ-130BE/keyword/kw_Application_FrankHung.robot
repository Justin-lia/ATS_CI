*** Settings ***
#Resource    ./base.robot

*** Variables ***

*** Keywords ***
Change DUT LAN side IP to Default
    Login GUI    http://192.168.2.1/login.html    ${DUT_Password}
    Open IPv4 Configuration Page
    input_text    id=ip    192.168.1.1
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=apply
    sleep    120
    Close Browser
    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} 192.168.1.51 netmask 255.255.255.0
    Run    echo 'vagrant' | sudo -S ip route add 192.168.1.0/24 via 0.0.0.0 dev ${ATS_to_DUT_Interface}
    ${result}=    Run    ping -c 4 192.168.1.1
    Should Contain    ${result}    ttl

#LAN PC Renew IP
#    [Tags]    @AUTHOR=Frank_Hung
#    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S route del default    prompt=vagrant@lanhost
#    sleep    3
#    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S route del default    prompt=vagrant@lanhost
#    sleep    3
#    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S route del default    prompt=vagrant@lanhost
#    sleep    3
#    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   echo '${DEVICES.lanhost.password}' | sudo -S sudo dhclient ${DEVICES.lanhost.interface} -r
#    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   echo '${DEVICES.lanhost.password}' | sudo -S sudo dhclient ${DEVICES.lanhost.interface}&
#    sleep    10
#    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S echo nameserver 8.8.8.8 > /etc/resolv.conf    prompt=vagrant@lanhost
#    sleep    2

Change DUT LAN side IP and DHCP server IP
    Login GUI    ${URL}    ${DUT_Password}
    Open IPv4 Configuration Page
    input_text    id=ip    192.168.2.1
    sleep    1
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    id=apply
    sleep    120
    Close Browser
    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} 192.168.2.51 netmask 255.255.255.0
    Run    echo 'vagrant' | sudo -S ip route add 192.168.2.0/24 via 0.0.0.0 dev ${ATS_to_DUT_Interface}
    ${result}=    Run    ping -c 4 192.168.2.1
    Should Contain    ${result}    ttl

Open IPv4 Configuration Page
    click element    id=lang_mainmenu_basic_setting
    sleep    2
    click element    id=menu_basic_setting_lan
    sleep    2
    click element    id=tab_lan4
    sleep    2
    Wait until element is visible    id=ip
    sleep    1

Reboot DUT from GUI
    [Arguments]    ${URL}    ${DUT_Password}
    Login GUI    ${URL}    ${DUT_Password}
    Open Auto Reboot Configuration Page
    click element    id=lang_reboot_btn_title
    sleep    240
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} down
#    sleep    2
#    Run    echo 'vagrant' | sudo -S ifconfig ${ATS_to_DUT_Interface} up
#    sleep    4
    Close Browser
    Login GUI    ${URL}    ${DUT_Password}
    Close Browser

Verify LAN PC can download 1 GigaBytes file from USB Storage via FTP
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S rm test_1G.txt
    sleep    2
    cli    lanhost    echo "get test_1G.txt"|lftp -u user1,user1 192.168.1.1&
    sleep    2
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S killall lftp
    cli    lanhost    \n
    ${result}=    cli    lanhost    ls test_1G*
    Should not Contain    ${result}    No such file or directory
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S rm test_1G.txt


Verify LAN PC should Upload file successful
    ${result}=    cli    lanhost     echo "1234567890" > ~/ftp_test.txt    prompt=vagrant@lanhost
    ${result}=    cli    lanhost     echo "put ftp_test.txt" | lftp -u user1,user1 192.168.1.1    prompt=vagrant@lanhost
    Should Not Contain    ${result}    fail
    ${result}=    cli    lanhost     echo "ls" | lftp -u user1,user1 192.168.1.1    prompt=vagrant@lanhost
    Should Contain    ${result}    ftp_test.txt
    Should Not Contain    ${result}    fail

Verify LAN PC should download file successful
    ${result}=    cli    lanhost     echo "1234567890" > ~/ftp_test.txt    prompt=vagrant@lanhost
    ${result}=    cli    lanhost     echo "put ftp_test.txt" | lftp -u user1,user1 192.168.1.1    prompt=vagrant@lanhost
    Should Not Contain    ${result}    fail
    ${result}=    cli    lanhost     echo "ls" | lftp -u user1,user1 192.168.1.1    prompt=vagrant@lanhost
    Should Contain    ${result}    ftp_test.txt
    Should Not Contain    ${result}    fail
    ${result}=    cli    lanhost     rm ~/ftp_test.txt    prompt=vagrant@lanhost
    ${result}=    cli    lanhost     echo "get ftp_test.txt" | lftp -u user1,user1 192.168.1.1    prompt=vagrant@lanhost
    Should Not Contain    ${result}    fail


Verify WAN PC can access USB Storage via FTP
    ${DUT_WAN_IP}=    Get DUT WAN IP
    ${result}=    cli    wanhost     echo "1234567890" > ~/ftp_test.txt    prompt=vagrant@WAN-host
    ${result}=    cli    wanhost     echo "put ftp_test.txt" | lftp -u user1,user1 ${DUT_WAN_IP}    prompt=vagrant@WAN-host
    Should Not Contain    ${result}    fail
    ${result}=    cli    wanhost     echo "ls" | lftp -u user1,user1 ${DUT_WAN_IP}    prompt=vagrant@WAN-host
    Should Contain    ${result}    ftp_test.txt
    Should Not Contain    ${result}    fail
    ${result}=    cli    wanhost     rm ~/ftp_test.txt    prompt=vagrant@WAN-host
    ${result}=    cli    wanhost     echo "get ftp_test.txt" | lftp -u user1,user1 ${DUT_WAN_IP}    prompt=vagrant@WAN-host
    Should Not Contain    ${result}    fail



Get DUT WAN IP
    Wait Until Keyword Succeeds    4x    4s    retry Get DUT WAN IP

retry Get DUT WAN IP
    Login GUI    ${URL}    ${DUT_Password}
    ${result}=    Get Text    id=dashboard_internet_address
    sleep    1
    Close Browser
    Should Not Contain    ${result}    0.0.0.0
    [Return]    ${result}


Verify LAN PC can access USB Storage via FTP after chang LAN IP
    LAN PC Renew IP
    ${result}=    cli    lanhost     echo "1234567890" > ~/ftp_test.txt    prompt=vagrant@lanhost
    ${result}=    cli    lanhost     echo "put ftp_test.txt" | lftp -u user1,user1 192.168.2.1    prompt=vagrant@lanhost
    Should Not Contain    ${result}    fail
    ${result}=    cli    lanhost     echo "ls" | lftp -u user1,user1 192.168.2.1    prompt=vagrant@lanhost
    Should Contain    ${result}    ftp_test.txt
    Should Not Contain    ${result}    fail

Verify LAN PC can access USB Storage via FTP
    ${result}=    cli    lanhost     echo "1234567890" > ~/ftp_test.txt    prompt=vagrant@lanhost
    ${result}=    cli    lanhost     echo "put ftp_test.txt" | lftp -u user1,user1 192.168.1.1    prompt=vagrant@lanhost
    Should Not Contain    ${result}    fail
    ${result}=    cli    lanhost     echo "ls" | lftp -u user1,user1 192.168.1.1    prompt=vagrant@lanhost
    Should Contain    ${result}    ftp_test.txt
    Should Not Contain    ${result}    fail

Open Auto Reboot Configuration Page
    click element    id=lang_mainmenu_management
    sleep    2
    click element    id=lang_submenu_management_reboot
    sleep    2
    Wait until element is visible    id=switch_layout_auto_reboot_update
    sleep    1

Open FTP Service Page
    click element    id=menu_application_item
    sleep    2
    click element    id=lang_submenu_application_storage
    sleep    2
    click element    id=tab_ftp
    sleep    2
    Wait until element is visible    id=ftp_folder
    sleep    1

Enable FTP Service on DUT
    Login GUI    ${URL}    ${DUT_Password}
    Open FTP Service Page
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_ftp_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_ftp_enable
    sleep    2
    Select From List By Value    id=ftp_folder    /tmp/sda1
    sleep    1
    click element    id=apply
    sleep    30
    Close Browser


Delete Share Folder, Verify The Share folder will be deleted from the table
    Login GUI    ${URL}    ${DUT_Password}
    Open Share Folder Page
    sleep    4
    click element    xpath=//*[@id="permission_table_id_0"]/td[5]/button/img
    sleep    10
    Element Should Not be visible    xpath=//*[@id="permission_table_id_0"]/td[5]/button/img
    sleep    2
    Close Browser

Verify LAN PC cannot access USB Storage via Samba server
    cli    lanhost    smbclient //192.168.1.1/user1 -U user1%user1    prompt=Error NT_STATUS_CONNECTION_REFUSED

Disable Samba Service on DUT
    Login GUI    ${URL}    ${DUT_Password}
    Open Samba Server Page
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_samba_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal checked'    click element    id=switch_layout_samba_enable
    sleep    2
    click element    id=apply
    sleep    30
    Close Browser

Open Samba Server Page
    click element    id=menu_application
    sleep    2
    click element    id=lang_submenu_application_storage
    sleep    2
    click element    id=tab_samba
    sleep    2
    Wait until element is visible    id=switch_layout_samba_enable
    sleep    1

Verify WAN PC can access USB Storage via Samba server
    ${DUT_WAN_IP}=    Get DUT WAN IP
    ${result}=    cli    wanhost     echo "1234567890" > ~/smba_test.txt    prompt=vagrant@
    ${result}=    cli    wanhost     echo "put smba_test.txt" | smbclient //${DUT_WAN_IP}/user1 -U user1%user1    prompt=vagrant@
    Should Not Contain    ${result}    NT_STATUS_ACCESS_DENIED
    ${result}=    cli    wanhost     echo "ls" | smbclient //${DUT_WAN_IP}/user1 -U user1%user1    prompt=vagrant@
    Should Contain    ${result}    smba_test.txt

Verify LAN PC can access USB Storage via Samba server
    LAN PC Renew IP
    ${result}=    cli    lanhost     echo "1234567890" > ~/smba_test.txt    prompt=vagrant@lanhost
    ${result}=    cli    lanhost     echo "put smba_test.txt" | smbclient //192.168.1.1/user1 -U user1%user1    prompt=vagrant@lanhost
    Should Not Contain    ${result}    NT_STATUS_ACCESS_DENIED
    ${result}=    cli    lanhost     echo "ls" | smbclient //192.168.1.1/user1 -U user1%user1    prompt=vagrant@lanhost
    Should Contain    ${result}    smba_test.txt

Enable Samba Service on DUT
    Login GUI    ${URL}    ${DUT_Password}
    Open Samba Server Page
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_samba_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_samba_enable
    sleep    2
    click element    id=apply
    sleep    30
    Close Browser

Check Share Folder Table, Verify The Share folder will be deleted from the table
    Element Should Not be visible    xpath=//*[@id="permission_table"]/tr/td[1]
    sleep    2
    Close Browser

Go to Share Folder page, Check Owner Field, Verify the Owner field becomes empty
    Open Share Folder Page
    Execute JavaScript    window.scrollTo(0, 0)
    sleep    2
    ${status}    run keyword and return status    Get Selected List Label    id=folder_owner
    Run Keyword if      ${status}!=False    Fail    Owner Field is Not empty

Delete a User account, Verify accout will be deleted to the table
    Login GUI    ${URL}    ${DUT_Password}
    Open User Accounts Page
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    click element    xpath=//*[@id="account_table_id_0"]/td[3]/button/img
    sleep    10
    Element Should Not be visible    xpath=//*[@id="account_table_id_0"]/td[3]/button/img
    sleep    2

Click Apply Change, verify the folder was successfully created and added to the table
    Change Permission to    1        #1 is read and write
    sleep    1
    click element    id=apply
    sleep    6
    ${result}=    Get Text    xpath=//*[@id="permission_table"]/tr/td[1]
    Should Contain    ${result}    user1
    Close Browser

Change Permission to
    [Arguments]    ${target}
    Select From List By Value    id=folder_permission    ${target}
    sleep    1

Go to Share Folder page, Check Owner Field, verify the Owner field will display the name of the created account
    Login GUI    ${URL}    ${DUT_Password}
    Open Share Folder Page
    sleep    4
    ${text}=    Get Selected List Label    id=folder_owner
    Should Contain    ${text}    user1

Add repeated User name again, Verify Cannot repeated user name
    input_text    id=storage_username    user1
    sleep    1
    input_text    id=storage_pw    user1
    sleep    1
    input_text    id=storage_pw_confirm    user1
    sleep    1
    click element    id=apply
    sleep    2
    Handle Alert
    sleep    2
    Close Browser

Input User Name, Password, Confirm Password and Click Apply Change, Verify the account was successfully created and added to the table
    input_text    id=storage_username    user1
    sleep    1
    input_text    id=storage_pw    user1
    sleep    1
    input_text    id=storage_pw_confirm    user1
    sleep    1
    click element    id=apply
    sleep    10
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    sleep    2
    ${result}=    Get Text    xpath=//*[@id="account_table_id_0"]/td[2]
    Should Contain    ${result}    user1

Input User Name, Password and Click Apply Change, Verify error message should be displaye
    input_text    id=storage_username    user1
    sleep    1
    input_text    id=storage_pw    user1
    sleep    1
    click element    id=apply
    sleep    2
    Handle Alert
    sleep    2


Input User Name and click Apply Change, Verify error message should be displaye
    input_text    id=storage_username    user1
    sleep    1
    click element    id=apply
    sleep    2
    Handle Alert
    sleep    2

User Accounts Page, Do not enter any values in all fields and click Apply Change, Verify An error message should be display
    Login GUI    ${URL}    ${DUT_Password}
    Open User Accounts Page
    click element    id=apply
    sleep    2
    Handle Alert
    sleep    2

Verify the Current Account Table will delete the "anonymous" user name
    Login GUI    ${URL}    ${DUT_Password}
    Open User Accounts Page
    Element Should Not be visible    xpath=//*[@id="account_table"]/tr/td[2]
    sleep    2
    Close Browser


Go to Storage Service > User Accounts Page, Disable the Enable Anonymous Access option
    Login GUI    ${URL}    ${DUT_Password}
    Open User Accounts Page
    Disable the Enable Anonymous Access option

Verify the Current Account Table will add and display the "anonymous" user name
    Login GUI    ${URL}    ${DUT_Password}
    Open User Accounts Page
    Element Should be visible    xpath=//*[@id="account_table"]/tr/td[2]
    sleep    2
    Close Browser

Go to Storage Service > User Accounts Page, Enable the Enable Anonymous Access option
    Login GUI    ${URL}    ${DUT_Password}
    Open User Accounts Page
    Enable the Enable Anonymous Access option

Enable the Enable Anonymous Access option
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_annonymous_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal'    click element    id=switch_layout_annonymous_enable
    sleep    30
    Close Browser

Disable the Enable Anonymous Access option
    ${enable_or_disable}=    get_element_attribute    id=switch_layout_annonymous_enable    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='switch hidden-dom-removal checked'    click element    id=switch_layout_annonymous_enable
    sleep    30
    Close Browser

Open Share Folder Page
    Execute JavaScript    window.scrollTo(0, 0)
    click element    id=menu_application
    sleep    2
    ${enable_or_disable}=    get_element_attribute    id=menu_application_item    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='sidebarItem'    click element    id=menu_application_item
    sleep    2
    click element    id=lang_submenu_application_storage
    sleep    2
    click element    id=tab_share_floder
    sleep    2
    Wait until element is visible    id=folder_permission
    sleep    1

Open User Accounts Page
    click element    id=menu_application
    sleep    2
    click element    id=lang_submenu_application_storage
    sleep    2
    click element    id=tab_storage_account
    sleep    2
    Wait until element is visible    id=storage_username
    sleep    1

