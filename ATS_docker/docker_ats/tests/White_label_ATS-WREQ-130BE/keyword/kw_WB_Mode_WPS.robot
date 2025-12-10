*** Settings ***


*** Variables ***
${WB_Mode_Device_Password}
${WB_Mode_URL}    http://172.16.0.24/

*** Keywords ***
Open [WPS Configuration] Page, Click [PBC] Button
    click element    id=lang_mainmenu_basic_setting
    sleep    2
    click element    id=lang_submenu_basic_setting_wlan
    sleep    2
    click element    id=lang_submenu_basic_setting_wlan_wifi_wps
    sleep    2
    Wait until element is visible    id=btn_pbc
    sleep    1
    click element    id=btn_pbc
    sleep    2

Reboot WB Mode Device from GUI
    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_ADMIN
    sleep    2
    click element    id=AT_ADMIN
    sleep    1
    click element    name=AT_init_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    id=id_rebootBtn
    sleep    1
    click element    id=id_rebootBtn
    sleep    120
    Close Browser

Disconnect WiFi Connection from WB Mode Device for test
    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    id=manual_setting
    sleep    1
    click element    id=manual_setting
    sleep    60
    input_text    id=id_SSID_INPUT    disconnect_xxxx
    sleep    1
    click element    id=decide
    sleep    60
    Close Browser

Disconnect WiFi Connection on WB Device
    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    id=manual_setting
    sleep    1
    click element    id=manual_setting
    sleep    40
    Wait until element is visible    id=id_SSID_INPUT
    sleep    1
    input_text    id=id_SSID_INPUT    disconnect
    sleep    1
    click element    id=decide
    sleep     60
    Close Browser

Retry Connect WPS PBC 5G on WB Mode Device Should be failed
    [Arguments]    ${URL}    ${DUT_Password}
    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #setting connect wps 5G only
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=EXEC_PBC
    sleep    1
    Select From List By Value   web     id=id_a_or_g    11a
    sleep    1
    click element    xpath=//*[@name="SUBMIT"]/div
    sleep    60
    Close Browser

    Login GUI    ${URL}    ${DUT_Password}    #Start WPS on DUT
    Open [WPS Configuration] Page, Click [PBC] Button
    Close Browser

    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #Start WPS on WB Mode Device
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=EXEC_PBC
    click element    name=EXEC_PBC
    sleep    160

    unselect_frame
    click element    id=AT_DIAG
    sleep    2
    click element    name=AT_diagnosis_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=ping_ipaddress
    sleep    2
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_1}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_2}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_3}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    ${text_all}=    Catenate    SEPARATOR=    ${text_1}    ${text_3}    ${text_3}
    should Not contain    ${text_all}    ttl
    sleep    2
    Close Browser

Retry Connect WPS-PIN 5G on WB Mode Device
    [Arguments]    ${URL}    ${DUT_Password}
    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #setting connect wps 5G only
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=EXEC_PBC
    sleep    1
    Select From List By Value   web     id=id_a_or_g    11a
    sleep    1
    click element    xpath=//*[@name="SUBMIT"]/div
    sleep    60
    click element    name=EXEC_PIN    #Start WPS-PIN on WB Mode Device
    sleep    30
    Wait until element is visible    xpath=//*[@id="id_main"]/table/tbody/tr/td/b/font
    sleep    2
    click element    xpath=//*[@id="id_search_show"]/input[6]
    sleep    30
    ${pin_code}=    Get Text    xpath=//*[@id="id_main"]/table/tbody/tr/td/b/font
    ${ssid}=    Get Text    xpath=//*[@id="id_search_show"]/table/tbody/tr[2]/td[2]/label
    ${last_four}=    Get Substring   ${ssid}   -1
    Run Keyword If    '${last_four}' == '3'    click element    xpath=//*[@id="id_search_show"]/input[6]
    Run Keyword If    '${last_four}' == '3'    sleep    30
    Run Keyword If    '${last_four}' == '3'    Wait until element is visible    xpath=//*[@id="id_main"]/table/tbody/tr/td/b/font
    Select Radio Button    nosave_apcli    1
    sleep    1
    click element    id=id_select_button
    sleep    2
    Close Browser

    Login GUI    ${URL}    ${DUT_Password}    #Start WPS on DUT
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]    #Open wps page
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wps_name
    sleep    2
    select_frame    id=content_main    #Enter pin code
    Wait until element is visible    id=id_ClientPin
    sleep    1
    input_text    id=id_ClientPin    ${pin_code}
    sleep    1
    click element    name=nosave_EnterPinBtn
    sleep    120
    Close Browser

    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #Check WPS-PIN Result
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    name=AT_diagnosis_name
    sleep    2
    click element    name=AT_diagnosis_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=ping_ipaddress
    sleep    2
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_1}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_2}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_3}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    ${text_all}=    Catenate    SEPARATOR=    ${text_1}    ${text_3}    ${text_3}
    should contain    ${text_all}    ttl
    sleep    2
    Close Browser



Disable Band Steering
    Login GUI    ${URL}     ${DUT_Password}
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]    #Open Band Steering page
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_BS_name
    sleep    2
    select_frame    id=content_main    #Enable Band Steering
    Wait until element is visible    id=id_band_steering_checkbox
    sleep    1
    Unselect Checkbox    id=id_band_steering_checkbox
    sleep    1
    Run Keyword And Ignore Error    Unselect Checkbox    id=id_band_steering_checkbox_wpa3
    sleep    1
    click element    xpath=//*[@name="nosave_SETUP_MULTI_SETTINGS"]/div[1]
    sleep    100
    Close Browser




Retry Connect WPS-PIN 2G on WB Mode Device
    [Arguments]    ${URL}    ${DUT_Password}
    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #setting connect wps 2G only
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=EXEC_PBC
    sleep    1
    Select From List By Value   web     id=id_a_or_g    11g
    sleep    1
    click element    xpath=//*[@name="SUBMIT"]/div
    sleep    60
    click element    name=EXEC_PIN    #Start WPS-PIN on WB Mode Device
    sleep    30
    Wait until element is visible    xpath=//*[@id="id_main"]/table/tbody/tr/td/b/font
    sleep    2
    click element    xpath=//*[@id="id_search_show"]/input[6]
    sleep    30
    ${pin_code}=    Get Text    xpath=//*[@id="id_main"]/table/tbody/tr/td/b/font
    ${ssid}=    Get Text    xpath=//*[@id="id_search_show"]/table/tbody/tr[2]/td[2]/label
    ${last_four}=    Get Substring   ${ssid}   -1
    Run Keyword If    '${last_four}' == '3'    click element    xpath=//*[@id="id_search_show"]/input[6]
    Run Keyword If    '${last_four}' == '3'    sleep    30
    Run Keyword If    '${last_four}' == '3'    Wait until element is visible    xpath=//*[@id="id_main"]/table/tbody/tr/td/b/font
    Select Radio Button    nosave_apcli    1
    sleep    1
    click element    id=id_select_button
    sleep    2
    Close Browser

    Login GUI    ${URL}    ${DUT_Password}    #Start WPS on DUT
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]    #Open wps page
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wps_name
    sleep    2
    select_frame    id=content_main    #Enter pin code
    Wait until element is visible    id=id_ClientPin
    sleep    1
    input_text    id=id_ClientPin    ${pin_code}
    sleep    1
    click element    name=nosave_EnterPinBtn
    sleep    120
    Close Browser

    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #Check WPS-PIN Result
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    name=AT_diagnosis_name
    sleep    2
    click element    name=AT_diagnosis_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=ping_ipaddress
    sleep    2
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_1}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_2}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_3}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    ${text_all}=    Catenate    SEPARATOR=    ${text_1}    ${text_3}    ${text_3}
    should contain    ${text_all}    ttl
    sleep    2
    Close Browser

Retry Connect WPS PBC 5G on WB Mode Device
    [Arguments]    ${URL}    ${DUT_Password}
    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #setting connect wps 5G only
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=EXEC_PBC
    sleep    1
    Select From List By Value   web     id=id_a_or_g    11a
    sleep    1
    click element    xpath=//*[@name="SUBMIT"]/div
    sleep    60
    Close Browser

    Login GUI    ${URL}    ${DUT_Password}    #Start WPS on DUT
    Click [AOSS/WPS] panel on [TOP] screen of DUT WebUI
    Close Browser

    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #Start WPS on WB Mode Device
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=EXEC_PBC
    click element    name=EXEC_PBC
    sleep    160

    unselect_frame
    click element    id=AT_DIAG
    sleep    2
    click element    name=AT_diagnosis_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=ping_ipaddress
    sleep    2
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_1}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_2}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_3}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    ${text_all}=    Catenate    SEPARATOR=    ${text_1}    ${text_3}    ${text_3}
    should contain    ${text_all}    ttl
    sleep    2
    Close Browser

Enable Band Steering and setting SSID to BandSteering-5G
    [Arguments]    ${URL}    ${DUT_Password}
    Login GUI    ${URL}     ${DUT_Password}
    Enable Band Steering and setting SSID to BandSteering-5G for Test

Enable Band Steering and setting SSID to BandSteering-5G for Test
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]    #Open Band Steering page
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_BS_name
    sleep    2
    select_frame    id=content_main    #Enable Band Steering
    Wait until element is visible    id=id_band_steering_checkbox
    sleep    1
    Select Checkbox    id=id_band_steering_checkbox
    sleep    1
    Run Keyword And Ignore Error    Select Checkbox    id=id_band_steering_checkbox_wpa3
    sleep    1
    Select Radio Button    nosave_usessid2    1
    sleep    1
    ${result}=    Generate Random String    4    [NUMBERS]
    ${ssid}=    Catenate    SEPARATOR=    BandSteering-5G    ${result}
    input_text    name=WIFISsid2_BS    ${ssid}
    sleep    1
    Select From List By Value   web     id=id_WIFIAuthType2    WPA2WPA3PSK
    sleep    1
    click element    name=nosave_SETUP_MULTI_SETTINGS
    sleep    100
    Close Browser

Retry Connect WPS PBC 2G on WB Mode Device
    [Arguments]    ${URL}    ${DUT_Password}
    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #setting connect wps 2G only
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=EXEC_PBC
    sleep    1
    Select From List By Value   web     id=id_a_or_g    11g
    sleep    1
    click element    xpath=//*[@name="SUBMIT"]/div
    sleep    60
    Close Browser

    Login GUI    ${URL}    ${DUT_Password}    #Start WPS on DUT
    Open [WPS Configuration] Page, Click [PBC] Button
    Close Browser

    Login GUI to WB Mode Device    ${WB_Mode_URL}     ${WB_Mode_Device_Password}    #Start WPS on WB Mode Device
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_wds_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=EXEC_PBC
    click element    name=EXEC_PBC
    sleep    160

    unselect_frame
    click element    id=AT_DIAG
    sleep    2
    click element    name=AT_diagnosis_name
    sleep    2
    select_frame    id=content_main
    Wait until element is visible    name=ping_ipaddress
    sleep    2
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_1}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_2}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    input_text    name=ping_ipaddress    172.16.11.1
    sleep    1
    click element    name=ping_exec
    sleep    10
    ${text_3}=    Get Text    xpath=/html/body/form[1]/table[3]/tbody/tr[2]/td
    sleep   1
    ${text_all}=    Catenate    SEPARATOR=    ${text_1}    ${text_3}    ${text_3}
    should contain    ${text_all}    ttl
    sleep    2
    Close Browser

Enable Band Steering and setting SSID to BandSteering-2G
    [Arguments]    ${URL}    ${DUT_Password}
    Login GUI    ${URL}     ${DUT_Password}
    Enable Band Steering and setting SSID to BandSteering-2G for Test

Enable Band Steering and setting SSID to BandSteering-2G for Test
    click element    xpath=//*[@id="panel_ADVANCED"]/div[2]    #Open Band Steering page
    Wait until element is visible    id=AT_WIRELESS
    sleep    2
    click element    id=AT_WIRELESS
    sleep    1
    click element    name=AT_BS_name
    sleep    2
    select_frame    id=content_main    #Enable Band Steering
    Wait until element is visible    id=id_band_steering_checkbox
    sleep    1
    Select Checkbox    id=id_band_steering_checkbox
    sleep    1
    Run Keyword And Ignore Error    Select Checkbox    id=id_band_steering_checkbox_wpa3
    sleep    1
    Select Radio Button    nosave_usessid2    1
    sleep    1
    ${result}=    Generate Random String    4    [NUMBERS]
    ${ssid}=    Catenate    SEPARATOR=    BandSteering-2G    ${result}
    input_text    name=WIFISsid2_BS    ${ssid}
    sleep    1
    Select From List By Value   web     id=id_WIFIAuthType2    WPA2WPA3PSK
    sleep    1
    click element    name=nosave_SETUP_MULTI_SETTINGS
    sleep    100
    Close Browser


Login GUI to WB Mode Device
    [Tags]   @AUTHOR=Frank_Hung
    [Arguments]    ${WB_Mode_URL}    ${WB_Mode_Device_Password}
    wait until keyword succeeds    4x    60s    Retry Login GUI to WB Mode Device    ${WB_Mode_URL}    ${WB_Mode_Device_Password}
    [Teardown]    Stop Test Fail Retry Login Fail for WB Mode

Stop Test Fail Retry Login Fail for WB Mode
    ${gui_type}     run keyword and return status    wait_until_element_is_visible    id=panel_ADVANCED    timeout=5
    Run Keyword if    ${gui_type}!=True    Fatal Error


Retry Login GUI to WB Mode Device
    [Tags]   @AUTHOR=Frank_Hung
    [Arguments]    ${URL}    ${DUT_Password}
    Open Web GUI    ${URL}
    sleep    5
    reload_page
    sleep    6
#------Login GUI if detect login button
    ${gui_type}     run keyword and return status    wait_until_element_is_visible    xpath=//*[@id="id_login"]    timeout=2
    Run Keyword if      ${gui_type}==True    input_text    id=id_nosave_Password    ${DUT_Password}
    Run Keyword if      ${gui_type}==True    sleep    2
    Run Keyword if      ${gui_type}==True    click element    xpath=//*[@id="id_login"]
    Run Keyword if      ${gui_type}==True    sleep    5

#------Click Home icon if not on Home Page
    wait_until_element_is_visible    id=panel_ADVANCED    timeout=20
    sleep    2
    run keyword and ignore error    unselect_frame
    sleep    2
    run keyword and ignore error    click element    xpath=//*[@class="statusIcon status_home"]
    wait_until_element_is_visible    id=panel_ADVANCED    timeout=20
    sleep    2













