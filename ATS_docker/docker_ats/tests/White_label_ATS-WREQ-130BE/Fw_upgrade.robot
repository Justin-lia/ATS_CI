*** Settings ***
Library    Process
Library    OperatingSystem
Library    SerialLibrary
Library    SeleniumLibrary
Library    SSHLibrary
Library     String
*** Variables ***
#${HOST}    192.168.1.1
${HOST}    www.google.com
${UPLOAD_FILE_PATH}    
${FW_version}    
*** Test Cases ***
#Enable Client wired Network
#    Enable Client wired Network

#FW upgrade Agent 
#    [Tags]    agent
#    FW upgrade Agent

FW upgrade Controller
    [Tags]    controller
    FW upgrade Controller

*** Keywords ***
Check FW upgrade successful
    [Arguments]    ${DUT_IP}
    Login GUI    ${DUT_IP}
    ${text} =    Get Text    xpath=//*[@id="dashboard_system_swversion"]
    Should Contain    ${text}    ${FW_version}
    Close All Browsers

Retry FW upgrade Agent 
    Login GUI    ${HOST}
    Get agent ip
    Close All Browsers  
    Login GUI    ${Agent_IP}
    Fw upgrade
    Close All Browsers  
    Check FW upgrade successful    ${Agent_IP}


FW upgrade Agent
    Wait Until Keyword Succeeds    3x    10s    Retry FW upgrade Agent

Retry FW upgrade Controller
    Login GUI    ${HOST}
    Fw upgrade
    Close All Browsers  
    Check FW upgrade successful    ${HOST}

FW upgrade Controller
    Wait Until Keyword Succeeds    3x    10s    Retry FW upgrade Controller

Fw upgrade
    Click Element    xpath=//*[@id="menu_management"]
    sleep    3
    Click Element    xpath=//*[@id="menu_management_settings"]
    sleep    3
    Click Element    xpath=//*[@id="tab_fw_upgrade"]/a
    sleep    3
    Choose File    xpath=//*[@id="filename"]    ${UPLOAD_FILE_PATH}
    Click Element    xpath=//*[@id="Modify"]
    #sleep    300
    sleep    600


Enable Client wired Network
    ${output}=    Run    echo password | sudo -S /sbin/ifconfig enp1s0 up
    ${output}=    Run    echo password | sudo -S service NetworkManager start
    ${output}=    Run    echo password | sudo -S dhclient enp1s0 -r
    ${output}=    Run    echo password | sudo -S ifconfig enp1s0 192.168.1.199 netmask 255.255.255.0
    sleep    10
    # ${output}=    Run    echo password | sudo -S dhclient enp1s0
    ${output}=    Run    ping 192.168.1.1 -c 4
    Should Contain    ${output}    ttl=

Login GUI
    [Arguments]    ${DUT_IP}
    Open browser    http://${DUT_IP}    
    sleep    3
    Input Text    xpath=//*[@id="acnt_username"]    admin
    sleep    1
    Input Text    xpath=//*[@id="acnt_passwd"]    admin
    sleep    1
    Click Element    xpath=//*[@id="myButton"]
    sleep    15
    Wait Until Element Is Visible    xpath=//*[@id="menu_basic_setting"]    timeout=60
    Execute Javascript    document.body.style.zoom='0.5'
    sleep    1

Get agent ip
    Click Element    xpath=//*[@id="menu_status"]
    sleep    3
    Click Element    xpath=//*[@id="menu_status_wifiMesh"]
    sleep    20
    ${Agent_IP} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[2]
    sleep    3

    Set Suite Variable    ${Agent_IP}
