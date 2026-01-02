*** Settings ***
Library    Process
Library    OperatingSystem
Library    SerialLibrary
Library    SeleniumLibrary
Library    SSHLibrary
Library     String
Library     BuiltIn
Resource    ../../keyword/Variable.robot
Resource    ../base.robot
#Library     telnet_case.py

*** Test Cases ***
Other test enable sshd
	Log		Enable controller SSH 		INFO
	Enable controller SSH 

*** Keywords ***

Login GUI
    [Arguments]    ${DUT_IP}
    Open browser    http://${DUT_IP}    
    sleep    3
    Input Text    xpath=//*[@id="acnt_username"]    admin
    sleep    1
    Input Text    xpath=//*[@id="acnt_passwd"]    admin
    sleep    1
    Click Element    xpath=//*[@id="myButton"]
    sleep    30
    Wait Until Element Is Visible    xpath=//*[@id="menu_dashboard"]    timeout=60
    Execute Javascript    document.body.style.zoom='0.5'
    sleep    1

Enable Client wired Network
    ${output}=    Run    echo ${Client_PASSWORD} | /sbin/ifconfig eth-lan up
    ${output}=    Run    echo ${Client_PASSWORD} | dhclient eth-lan -r
    ${output}=    Run    echo ${Client_PASSWORD} | ifconfig eth-lan 192.168.1.199 netmask 255.255.255.0
    sleep    60
    # ${output}=    Run    echo ${Client_PASSWORD} | sudo -S dhclient eth-lan
    ${output}=    Run    ping 192.168.1.1 -c 4
    Should Contain    ${output}    ttl=
	
Check Wizard
    Login Wizard GUI    ${HOST}
    ${result}=  Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[@id="lang_have_read_and_agree"]    timeout=10
    Run Keyword If    '${result}'=='True'    Setup Wizard
    Close All Browsers

Login Wizard GUI
    [Arguments]    ${DUT_IP}
    Open browser    http://${DUT_IP}    
    sleep    3
    Input Text    xpath=//*[@id="acnt_username"]    admin
    sleep    1
    Input Text    xpath=//*[@id="acnt_passwd"]    admin
    sleep    1
    Click Element    xpath=//*[@id="myButton"]
    sleep    8

Setup Wizard
    [Tags]    Wizard
#    Login Wizard GUI    ${HOST}
    Wait Until Keyword Succeeds    3x    10s    Retry Setup Wizard
    Close All Browsers   

#Setup Wizard
#	Wait Until Keyword Succeeds    3x    10s    Retry Setup Wizard    

Retry Setup Wizard
#    Run Keyword And Ignore Error    Close All Browsers
    Login Wizard GUI    ${HOST}
    Execute Javascript    document.body.style.zoom='0.5'
    Click Element    xpath=//*[@id="lang_have_read_and_agree"]
    sleep    5
    Click Element    xpath=//*[@id="ml-agree"]
    sleep    5
    Click Element    xpath=//*[@id="router-mode-card"]
    Click Element    xpath=//*[@id="ml-next"]
    sleep    5
    Click Element    xpath=//*[@id="ml-next"]
    sleep    5
    Click Element    xpath=//*[@id="ml-next"]
    sleep    5
    Click Element    xpath=//*[@id="switch_layout_enable_mesh_btn"]
    sleep    5
    Click Element    xpath=//*[@id="ml-next"]
    sleep    5
    Click Element    xpath=//*[@id="ml-next"]
    sleep    5
    Input Text    xpath=//*[@id="new_pwd"]    admin
    Input Text    xpath=//*[@id="confirm_pwd"]    admin
    Click Element    xpath=//*[@id="ml-next"]
    sleep    5
    Click Element    xpath=//*[@id="ml-apply"]
    sleep    180
    Click Element    xpath=//*[@id="btn-redirect"]
    sleep    5
    Wait Until Element Is Visible    xpath=//*[@id="acnt_username"]    timeout=60
    sleep    150

Default Controller    
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers
	

Enable controller SSH 
    Wait Until Keyword Succeeds    3x    10s    Retry Enable controller SSH 

Retry Enable controller SSH 
    Run Keyword And Ignore Error    Close All Browsers   
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_adv_setting"]
    sleep    5
    Click Element    xpath=//*[@id="menu_adv_setting_ssh"]
    sleep    15
    ${status}=    Get Element Attribute    id=ssh_enabled    value
    Run Keyword If    '${status}' == '0'    Click ssh button

Click ssh button    
    Click Element    xpath=//*[@id="switch_layout_ssh_enabled"]
    sleep    5
    Click Element    xpath=//*[@id="apply"]
    sleep    5
    Handle Alert
    sleep    30
    Close All Browsers