*** Settings ***
#Resource    ./base.robot
Variables    ../config/topology/Myvariable.yaml
*** Variables ***

*** Keywords ***
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

