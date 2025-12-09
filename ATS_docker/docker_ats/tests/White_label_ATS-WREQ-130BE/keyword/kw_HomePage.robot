*** Settings ***
#Resource    ./base.robot
Variables    ../config/topology/Myvariable.yaml
*** Variables ***

*** Keywords ***
Verify Internet Status should be up
    Wait Until Keyword Succeeds    3x    60s    retry Verify Internet Status should be up

retry Verify Internet Status should be up
    Reload Page
    sleep    10
    ${result}=    Get Text    id=internet_downup_status
    Should Be Equal    ${result}    Up

Verify the Number of Online device lists should greater than 1
    Wait Until Keyword Succeeds    3x    60s    retry Verify the Number of Online device lists should greater than 1

retry Verify the Number of Online device lists should greater than 1
    Reload Page
    sleep    10
    ${result}=    Get Text    id=online_device_count
    ${result}=    Convert To Integer    ${result}
    Should Be True  ${result} > 1

Verify the Protocol of WAN Port should be PPPoE
    Login GUI    ${URL}    ${DUT_Password}
    ${result}=    Get Text    id=dashboard_internet_protocol
    Should Be Equal    ${result}    PPPoE

Verify the Protocol of WAN Port should be Static
    Login GUI    ${URL}    ${DUT_Password}
    ${result}=    Get Text    id=dashboard_internet_protocol
    Should Be Equal    ${result}    STATIC
    Close Browser

Verify the Default Protocol of WAN Port should be DHCP
    ${result}=    Get Text    id=dashboard_internet_protocol
    Should Be Equal    ${result}    DHCP
    Close Browser

Verify the Internet Address should be 172.16.11.x
    Wait Until Keyword Succeeds    3x    60s    retry Verify the Internet Address should be 172.16.11.x

retry Verify the Internet Address should be 172.16.11.x
    Reload Page
    sleep    10
    ${result}=    Get Text    id=dashboard_internet_address
    Should Contain    ${result}    172.16.11.

Verify the Primary DNS should be 168.95.1.1
    ${result}=    Get Text    id=dashboard_internet_dns1
    Should Contain Any    ${result}    168.95.1.1    10.5.161.254
    Close Browser

Verify the Secondary DNS should be 8.8.8.8
    Login GUI    ${URL}    ${DUT_Password}
    ${result}=    Get Text    id=dashboard_internet_dns2
    Should Contain    ${result}    8.8.8.8

Verify the MacAddress should not be Empty
    ${result}=    Get Text    id=dashboard_internet_macaddress
    Should Not Be Empty    ${result}

Verify the Manufacturer should be Gemtek Technology Co.
    ${result}=    Get Text    id=dashboard_system_mfg
    Should Be Equal    ${result}    Gemtek Technology Co.

Verify the Serial Number should Not be Empty
    ${result}=    Get Text    id=dashboard_system_sn
    Should Not Be Empty    ${result}

Verify the Firmware Version should Not be Empty
    ${result}=    Get Text    id=dashboard_system_swversion
    Should Not Be Empty    ${result}

Verify the Model Name should be
    [Arguments]    ${model_name}
    ${result}=    Get Text    id=dashboard_system_modelname
    Should Be Equal    ${result}    ${model_name}

Verify the Hardware Version should Not be Empty
    ${result}=    Get Text    id=dashboard_system_hwversion
    Should Not Be Empty    ${result}

Verify the WAN Port should be Active
    IF    '${Product_Name}'=='WREQ-130BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[5]/div/img    src
        Should Contain    ${status}    img/icons/icon-1/ico-ethernet-port-active.svg
    ELSE IF    '${Product_Name}'=='WRTQ-409BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[5]/div/img    src
        Should Contain    ${status}    ethernet-port-active.svg
    END

Verify the LAN1 Port should be Inactive
    IF    '${Product_Name}'=='WREQ-130BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[1]/div/img    src
        Should Contain    ${status}    img/icons/icon-1/ico-ethernet-port-inactive.svg
    ELSE IF    '${Product_Name}'=='WRTQ-409BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[1]/div/img    src
        Should Contain    ${status}    ethernet-port-active.svg
    END


Verify the LAN2 Port should be Inactive
    IF    '${Product_Name}'=='WREQ-130BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[2]/div/img    src
        Should Contain    ${status}    img/icons/icon-1/ico-ethernet-port-inactive
    ELSE IF    '${Product_Name}'=='WRTQ-409BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[2]/div/img    src
        Should Contain    ${status}    ethernet-port-active.svg
    END




Verify the LAN3 Port should be Active
    IF    '${Product_Name}'=='WREQ-130BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[3]/div/img    src
        Should Contain    ${status}    img/icons/icon-1/ico-ethernet-port-active
    ELSE IF    '${Product_Name}'=='WRTQ-409BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[3]/div/img    src
        Should Contain    ${status}    ethernet-port-inactive
    END




Verify the LAN4 Port should be Active
    IF    '${Product_Name}'=='WREQ-130BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[4]/div/img    src
        Should Contain    ${status}    img/icons/icon-1/ico-ethernet-port-active
    ELSE IF    '${Product_Name}'=='WRTQ-409BE'
        ${status}=    Get Element Attribute    xpath=//*[@id="eth_port_zone"]/div[4]/div/img    src
        Should Contain    ${status}    ethernet-port-inactive
    END
















Verify LAN PC and Wireless PC can be Rename from Tagret Devices on GUI
    [Arguments]    ${LAN_PC_MAC}    ${Wireless_PC_MAC}
    Select From List By Value    id=restrict_internet_access    ${LAN_PC_MAC}
    sleep    1
    click element    id=lang_pc_rename_title
    sleep    2
    input text    id=dev_new_name    LAN_PC_Edited
    sleep    1
    click element    id=leafConfirm
    sleep    4

    Select From List By Value    id=restrict_internet_access    ${Wireless_PC_MAC}
    sleep    1
    click element    id=lang_pc_rename_title
    sleep    2
    input text    id=dev_new_name    Wireless_PC_Edited
    sleep    1
    click element    id=leafConfirm
    sleep    4

    Select From List By Label    id=restrict_internet_access    LAN_PC_Edited
    Select From List By Label    id=restrict_internet_access    Wireless_PC_Edited
    Close Browser










Add LAN PC and Wireless PC to Target Devices on GUI
    [Arguments]    ${LAN_PC_MAC}    ${Wireless_PC_MAC}
    Select From List By Value    id=dev_list    ${LAN_PC_MAC}
    sleep    1
    Click element    id=lang_pc_add_title
    sleep    2
    Select From List By Value    id=dev_list    ${Wireless_PC_MAC}
    sleep    1
    Click element    id=lang_pc_add_title
    sleep    1

Verify LAN PC and Wireless PC can be Remove from Tagret Devices on GUI
    [Arguments]    ${LAN_PC_MAC}    ${Wireless_PC_MAC}
    Select From List By Value    id=restrict_internet_access    ${LAN_PC_MAC}
    sleep    1
    Click element    id=lang_pc_reomve_title
    sleep    1
    Select From List By Value    id=restrict_internet_access    ${Wireless_PC_MAC}
    sleep    1
    Click element    id=lang_pc_reomve_title
    sleep    1

    ${result}=    Get Selected List Values    id=restrict_internet_access
    Should Not Contain    ${result}    ${LAN_PC_MAC}
    Should Not Contain    ${result}    ${Wireless_PC_MAC}



Verify DUT can discover LAN PC and Wireless PC on Parental Control GUI
    [Arguments]    ${LAN_PC_MAC}    ${Wireless_PC_MAC}
    Login GUI    ${URL}    ${DUT_Password}
    click element    id=lang_mainmenu_adv_setting
    sleep    2
    click element    id=menu_adv_setting_parental_control
    sleep    2
    Wait until element is visible    id=switch_layout_pc_enabled
    sleep    1
    Select From List By Value    id=dev_list    ${LAN_PC_MAC}
    sleep    1
    Select From List By Value    id=dev_list    ${Wireless_PC_MAC}
    sleep    1




Setting DUT WiFi interface MAC from console
    Run    echo "vagrant" | sudo -S chmod 777 /dev/ttyUSB0
    cli    DUT_serial_port    uci set wireless.wifi0.macaddr='${WPS_bssid_2G}' && uci commit && wifi    prompt=#
    sleep    240
    cli    DUT_serial_port    uci set wireless.wifi1.macaddr='${WPS_bssid_5G}' && uci commit && wifi    prompt=#
    sleep    240

