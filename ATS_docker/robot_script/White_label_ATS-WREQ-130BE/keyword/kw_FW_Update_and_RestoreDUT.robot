*** Settings ***
#Resource    ./base.robot

*** Variables ***

*** Keywords ***
Use Wireless PC, restore a wrong config file on DUT, verify GUI show error message
    cli   wifi_client    Xvfb :88 -screen 0 1024x768x16 & export DISPLAY=:88
    cli   wifi_client    export PATH=$PATH:/home/gemtek/
    ${result}=    cli   wifi_client    robot white_restore_config_wrong.robot    timeout=300
    log    ${result}
    Should Not Contain    ${result}    FAIL
    sleep    10
    ${ping_result}=    Run    ping -c 4 192.168.1.1
    Should Contain    ${ping_result}    ttl=

Restore a wrong config file on DUT, verify GUI show error message
    Login GUI    ${URL}    ${DUT_Password}
    Open Backup Restore Page
    Choose a wrong Fail from GUI and click Update on GUI than GUI show error mesage

Verify DUT WiFi setting can be resotred
    [Arguments]    ${ssid_5G_1}
    Open WLAN Basic Config Page
    execute javascript    window.scrollTo(0,400)
    sleep    2
    ${get_ssid}=    Get Element Attribute   id=5g_ssid    value
    Should Be Equal    ${get_ssid}    ${ssid_5G_1}
    Close Browser

Use Wireless PC, restore DUT settings from GUI
    cli   wifi_client    Xvfb :88 -screen 0 1024x768x16 & export DISPLAY=:88
    cli   wifi_client    export PATH=$PATH:/home/gemtek/
    ${result}=    cli   wifi_client    robot white_restore_config.robot    timeout=300
    log    ${result}
    Should Not Contain    ${result}    FAIL

Restore DUT settings from GUI
    Login GUI    ${URL}    ${DUT_Password}
    Open Backup Restore Page
    Choose Fail from GUI and click Update on GUI

Choose a wrong Fail from GUI and click Update on GUI than GUI show error mesage
    Choose File    id=restore_file_path    /home/vagrant/Downloads/wrong_config.bin
    sleep    2
    click element    id=lang_update
    sleep    4
    ${message}=    Handle Alert
    Should Contain    ${message}    We couldn't restore your settings
    sleep    2
    Close Browser

Choose Fail from GUI and click Update on GUI
    Choose File    id=restore_file_path    /home/vagrant/Downloads/config.bin
    sleep    2
    click element    id=lang_update
    sleep    12
    Close Browser

Use Wireless PC, save DUT Current Settings, and check Config file can be saved
    cli   wifi_client    Xvfb :88 -screen 0 1024x768x16 & export DISPLAY=:88
    cli   wifi_client    export PATH=$PATH:/home/gemtek/
    ${result}=    cli   wifi_client    robot white_backup_config.robot    timeout=300
    log    ${result}
    Should Not Contain    ${result}    FAIL

Save DUT Current Settings, and check Config file can be saved
    Remove File    /home/vagrant/Downloads/config.bin
    Login GUI    ${URL}    ${DUT_Password}
    Open Backup Restore Page
    Click Save Button on Backup Config
    OperatingSystem.File Should Exist    /home/vagrant/Downloads/config.bin

Click Save Button on Backup Config
    click element    id=lang_save
    sleep    4
    Close Browser

Open Backup Restore Page
    click element    id=lang_mainmenu_management
    sleep    2
    click element    id=lang_submenu_management_settings
    sleep    2
    click element    id=tab_backup
    sleep    2
    Wait until element is visible    id=lang_save
    sleep    1

Get Firemware Version
    ${result}=    Run    cat /workspace/tests/White_label_ATS-WREQ-130BE/last_FW_path.txt
    log    ${result}
    @{result}=    Get Regexp Matches    ${result}    \\d+\.\\d+\.\\d+\.\\d+
    ${result}=    Strip String    ${result}[0]
    log    ${result}
    Set Suite Variable    ${Expect_FW_Version}    ${result}

Verify Firmware Update Success
    ${Expect_FW_Version}=    Run    cat /workspace/tests/White_label_ATS-WREQ-130BE/last_FW_path.txt
    log    ${Expect_FW_Version}
    @{Expect_FW_Version}=    Get Regexp Matches    ${Expect_FW_Version}    \\d+\.\\d+\.\\d+\.\\d+
    ${Expect_FW_Version}=    Strip String    ${Expect_FW_Version}[0]
    log    ${Expect_FW_Version}
    Wait Until Keyword Succeeds    3x    2s    Retry Verify Firmware Update Success    ${Expect_FW_Version}

Retry Verify Firmware Update Success
    [Arguments]    ${Expect_FW_Version}
    Login GUI    ${URL}    ${DUT_Password}
    sleep    6
    ${result}=    Get Text    xpath=//*[@id="dashboard_system_swversion"]
    Should Be Equal    ${result}    ${Expect_FW_Version}
    sleep    2
    [Teardown]    Close Browser

Get Firemware Update Path
    ${result}=    Run    cat /workspace/tests/White_label_ATS-WREQ-130BE/last_FW_path.txt
    log    ${result}
    Set Suite Variable    ${Path_for_FW_Update}    ${result}

Update Firmware from Update Software Page
    ${Path_for_FW_Update}=    Run    cat /workspace/tests/White_label_ATS-WREQ-130BE/last_FW_path.txt
    log    ${Path_for_FW_Update}
    Login GUI    ${URL}    ${DUT_Password}
    Open Update Software Page
    Update Firmware from GUI    ${Path_for_FW_Update}
    sleep    30
    ${result}=    Get Text    id=loading_message
    Should Not Be Empty    id=loading_message
    sleep    220
    Wait until element is visible    id=acnt_passwd    timeout=60
    sleep    2
    Close Browser

Update a wrong Firmware from GUI, verify DUT cannot updated and an error message appears
    [Arguments]    ${other_regions_FW}
    Login GUI    ${URL}    ${DUT_Password}
    Open Update Software Page
    Update Firmware from GUI    ${other_regions_FW}
    Verify GUI show Firmware updated error message

Verify GUI show Firmware updated error message
    sleep    12
    ${message}=    Handle Alert
    Should Contain    ${message}    fail
    sleep    2
    Close Browser

Update Firmware from GUI
    [Arguments]    ${FW}
    Choose File    id=filename    ${FW}
    sleep    2
    click element    id=lang_manual_update_btn
    sleep    12

Open Update Software Page
    click element    id=lang_mainmenu_management
    sleep    2
    click element    id=lang_submenu_management_settings
    sleep    2
    click element    id=tab_fw_upgrade
    sleep    2
    Wait until element is visible    id=current_fw_version
    sleep    1

LAN PC Renew IP
    [Tags]    @AUTHOR=Frank_Hung
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S route del default    prompt=vagrant@lanhost
    sleep    3
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S route del default    prompt=vagrant@lanhost
    sleep    3
    Wait Until Keyword Succeeds    3x    2s    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S route del default    prompt=vagrant@lanhost
    sleep    3
    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   echo '${DEVICES.lanhost.password}' | sudo -S sudo dhclient ${DEVICES.lanhost.interface} -r
    Wait Until Keyword Succeeds    3x    2s    cli   lanhost   echo '${DEVICES.lanhost.password}' | sudo -S sudo dhclient ${DEVICES.lanhost.interface}&
    sleep    10
    cli    lanhost    echo '${DEVICES.lanhost.password}' | sudo -S echo nameserver 8.8.8.8 > /etc/resolv.conf    prompt=vagrant@lanhost
    sleep    2

Get DUT WAN IP
    Wait Until Keyword Succeeds    4x    4s    retry Get DUT WAN IP

retry Get DUT WAN IP
    Login GUI    ${URL}    ${DUT_Password}
    ${result}=    Get Text    id=status_ip
    sleep    1
    Close Browser
    Should Not Contain    ${result}    0.0.0.0
    [Return]    ${result}

Open QoS Page
    click element    xpath=/html/body/div[1]/ul/li[4]/a/span
    sleep    2
    click element    xpath=/html/body/div[1]/div/div[1]/div/div[1]/div/h4/a[2]/span
    sleep    2
    Wait until element is visible    id=sel_qos_bw
    sleep    1