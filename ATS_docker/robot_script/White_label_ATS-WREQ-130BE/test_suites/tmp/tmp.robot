
#Enable Client wired Network 
#    Enable Client wired Network

#Check Wizard
#    [Tags]    Wizard
#    Check Wizard

Default Controller    
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers

#Setup Wizard
#    [Tags]    Wizard
#    Login Wizard GUI    ${HOST}
#    Setup Wizard
#    Close All Browsers   

Check Controller FW 
    Check DUT FW   ${HOST}

Check Mesh Agent is online
    [Tags]    Agent
    Enable the switch port connected to the agent
    sleep    300
    Get agent ip

Check Agent FW 
    Check DUT FW   ${Agent_IP}

Set the DUT channel to be scannable
    [Tags]    6G    channel
    Set DUT 5G and 6G channel to be scannable
    
Enable SSh
    Enable SSH
    Enable Agent SSH
   
Get Agent all SSID and BSSID
    [Tags]	Agent
    SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    
Get Router all SSID,password and BSSID
    SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID
    SSH To Controller And Get default wifi password

Disable Client wired Network and Reset WiFi Interface
    Disable Client wired Network
    Reset WiFi Interface

No.1 Connect to Common SSID 2G controller
    [Tags]    2G
    Modify WPA Supplicant wpa3 Config    ${2G_SSID}    ${2G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_SSID_BSSID}    
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_SSID_BSSID}

No.2 Connect to Common SSID 5G controller
    [Tags]    5G
    Modify WPA Supplicant wpa3 Config    ${5G_SSID}    ${5G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_SSID_BSSID}

No.3 Connect to Common SSID 6G controller
    [Tags]    6G
    Modify WPA Supplicant wpa3 Config    ${6G_SSID}    ${6G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_SSID_BSSID}

No.4 Connect to Common SSID 2G agent
    [Tags]    Agent    2G
    Modify WPA Supplicant wpa3 Config    ${2G_Agent_SSID}    ${2G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_SSID_BSSID}

No.5 Connect to Common SSID 5G agent
    [Tags]    Agent    5G
    Modify WPA Supplicant wpa3 Config    ${5G_Agent_SSID}    ${5G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_SSID_BSSID}

No.6 Connect to Common SSID 6G agent
    [Tags]    Agent    6G
    Modify WPA Supplicant wpa3 Config    ${6G_Agent_SSID}    ${6G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_SSID_BSSID}

Change common/MLO SSID ,Authentication and Key
    Enable Client wired Network
    Login GUI    ${HOST}
    Change common/MLO SSID, Authentication and Key
    Close All Browsers

Get Agent all SSID and BSSID 
    [Tags]    Agent
    Get agent ip 
    SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    
Get Router all SSID and BSSID 
    SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID

Disable Client wired Network and Reset WiFi Interface 
    Disable Client wired Network
    Reset WiFi Interface

No.7 Connect to Common SSID 2G controller
    [Tags]    2G
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${2G_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${2G_SSID_BSSID}   
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_SSID_BSSID}  

No.8 Connect to Common SSID 5G controller
    [Tags]    5G
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${5G_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${5G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_SSID_BSSID}
    
No.9 Connect to Common SSID 6G controller
    [Tags]    6G
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${6G_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${6G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_SSID_BSSID}

No.10 Connect to Common SSID 2G agent
    [Tags]    Agent    2G
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${2G_Agent_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${2G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_SSID_BSSID}

No.11 Connect to Common SSID 5G agent
    [Tags]    Agent    5G
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${5G_Agent_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${5G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_SSID_BSSID}
    
No.12 Connect to Common SSID 6G agent
    [Tags]    Agent    6G
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${6G_Agent_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${6G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_SSID_BSSID}

No.13 Change to wireless onboarding
    [Tags]    Agent
    Disable the switch port connected to the agent
    sleep    300
    Enable Client wired Network
    Check agent is wireless onboarding
    [Teardown]    Restore to ethernet onbording 

Enable Client wired Network
    [Tags]    MLO
    Enable Client wired Network

Default Agent
    [Tags]	Agent    MLO
    Get agent ip 
    Login GUI    ${Agent_IP}
    Defalut DUT/Agent and No wait setup
    Close All Browsers  

Disable the switch port connected to the agent
    [Tags]	Agent    MLO
    Disable the switch port connected to the agent

Default Controller
    [Tags]    MLO
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers  

#Setup Wizard
#    [Tags]    Wizard    MLO
#    Login Wizard GUI    ${HOST}
#    Setup Wizard
#    Close All Browsers   

Enable MLO
    [Tags]    MLO
    Login GUI    ${HOST}
    Enable MLO
    Close All Browsers 

Enable the switch port connected to the agent
    [Tags]	Agent    MLO
    Enable the switch port connected to the agent
    sleep    300

Enable SSh
    [Tags]    MLO
    Enable SSH
    Get agent ip 
    Enable Agent SSH
   
Set the DUT channel to be scannable
    [Tags]    6G    MLO    channel
    Set DUT 5G and 6G channel to be scannable

Get Agent all SSID and BSSID
    [Tags]    Agent    MLO
    SSH To Enable Mesh Agent And Get all MLO SSID and BSSID
    
Get Router all SSID,password and BSSID
    [Tags]    MLO
    SSH To Enable Mesh Router And Get all MLO SSID and BSSID
    SSH To Controller And Get default wifi password

Disable Client wired Network and Reset WiFi Interface
    [Tags]    MLO
    Disable Client wired Network
    Reset WiFi Interface

No.14 Connect 2G MLO SSID controller
    [Tags]    2G    MLO
    Modify WPA Supplicant wpa3 Config    ${2G_SSID}    ${2G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_SSID_BSSID}   
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_SSID_BSSID}    

No.15 Connect 5G MLO SSID controller
    [Tags]    5G    MLO
    Modify WPA Supplicant wpa3 Config    ${5G_SSID}    ${5G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_SSID_BSSID}

No.16 Connect 6G MLO SSID controller
    [Tags]    6G    MLO
    Modify WPA Supplicant wpa3 Config    ${6G_SSID}    ${6G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_SSID_BSSID}

No.17 Connect 2G MLO SSID agent
    [Tags]    Agent    2G    MLO
    Modify WPA Supplicant wpa3 Config    ${2G_Agent_SSID}    ${2G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_SSID_BSSID}
    
No.18 Connect 5G MLO SSID agent
    [Tags]    Agent    5G    MLO
    Modify WPA Supplicant wpa3 Config    ${5G_Agent_SSID}    ${5G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_SSID_BSSID}

No.19 Connect 6G MLO SSID agent
    [Tags]    Agent    6G    MLO
    Modify WPA Supplicant wpa3 Config    ${6G_Agent_SSID}    ${6G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_SSID_BSSID}

Change common/MLO SSID, Authentication and Key > MLO
    [Tags]    MLO
    Enable Client wired Network
    
    Login GUI    ${HOST}
    Change common/MLO SSID, Authentication and Key
    Close All Browsers

Get Agent all SSID and BSSID
    [Tags]    Agent    MLO
    Get agent ip 
    SSH To Enable Mesh Agent And Get all MLO SSID and BSSID
    
Get Router all SSID and BSSID
    [Tags]    MLO
    SSH To Enable Mesh Router And Get all MLO SSID and BSSID

Disable Client wired Network and Reset WiFi Interface
    [Tags]    MLO
    Disable Client wired Network
    Reset WiFi Interface

No.20 Connect 2G MLO SSID controller
    [Tags]    2G    MLO
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${2G_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${2G_SSID_BSSID}     
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_SSID_BSSID}

No.21 Connect 5G MLO SSID controller
    [Tags]    5G    MLO
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${5G_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${5G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_SSID_BSSID}

No.22 Connect 6G MLO SSID controller
    [Tags]    6G    MLO
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${6G_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${6G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_SSID_BSSID}

No.23 Connect 2G MLO SSID agent
    [Tags]    Agent    2G    MLO
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${2G_Agent_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${2G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_SSID_BSSID}

No.24 Connect 5G MLO SSID agent
    [Tags]    Agent    5G    MLO
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${5G_Agent_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${5G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_SSID_BSSID}

No.25 Connect 6G MLO SSID agent
    [Tags]    Agent    6G    MLO
    Modify WPA Supplicant wpa3 Config    ${Changed_SSID}    ${6G_Agent_SSID_BSSID}    ${Changed_PSK}
    Connect to ssid and ping controller and agent    ${6G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_SSID_BSSID}

No.26 Change to wireless onboarding
    [Tags]    Agent
    Disable the switch port connected to the agent
    sleep    300
    Enable Client wired Network
    Check agent is wireless onboarding
    [Teardown]    Restore to ethernet onbording

Enable Client wired Network
    Enable Client wired Network

Default Agent
    [Tags]	Agent
    Get agent ip 
    Login GUI    ${Agent_IP}
    Defalut DUT/Agent and No wait setup
    Close All Browsers  

Disable the switch port connected to the agent
    [Tags]	Agent
    Disable the switch port connected to the agent

Default Controller
    Login GUI    ${HOST}
    Defalut DUT/Agent and Wait setup
    Close All Browsers  

Setup Wizard
    [Tags]    Wizard
    Login Wizard GUI    ${HOST}
    Setup Wizard
    Close All Browsers   

Disable MLO and common ssid
    Login GUI    ${HOST}
    Disable MLO and common ssid
    Close All Browsers   

Enable the switch port connected to the agent
    [Tags]	Agent
    Enable the switch port connected to the agent
    sleep    300

Enable SSh
    Enable SSH
    Get agent ip 
    Enable Agent SSH

Set the DUT channel to be scannable
    [Tags]    6G    channel
    Set DUT 5G and 6G channel to be scannable

Get Agent all SSID and BSSID
    [Tags]    Agent
    SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    
Get Router all SSID,password and BSSID
    SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID
    SSH To Controller And Get default wifi password

Disable Client wired Network and Reset WiFi Interface
    Disable Client wired Network
    Reset WiFi Interface

No.27 Connect 2G SSID controller
    [Tags]    2G
    Modify WPA Supplicant wpa3 Config    ${2G_SSID}    ${2G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_SSID_BSSID}        
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_SSID_BSSID}

No.28 Connect 5G SSID controller
    [Tags]    5G
    Modify WPA Supplicant wpa3 Config    ${5G_SSID}    ${5G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_SSID_BSSID}

No.29 Connect 6G SSID controller
    [Tags]    6G
    Modify WPA Supplicant wpa3 Config    ${6G_SSID}    ${6G_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_SSID_BSSID}

No.30 Connect 2G SSID agent
    [Tags]    Agent    2G
    Modify WPA Supplicant wpa3 Config    ${2G_Agent_SSID}    ${2G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${2G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_SSID_BSSID}

No.31 Connect 5G SSID agent
    [Tags]    Agent    5G
    Modify WPA Supplicant wpa3 Config    ${5G_Agent_SSID}    ${5G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${5G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_SSID_BSSID}

No.32 Connect 6G SSID agent
    [Tags]    Agent    6G
    Modify WPA Supplicant wpa3 Config    ${6G_Agent_SSID}    ${6G_Agent_SSID_BSSID}    ${Default_PSK}
    Connect to ssid and ping controller and agent    ${6G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_SSID_BSSID}

Change SSID ,Authentication and Key
    Enable Client wired Network

    Login GUI    ${HOST}
    Change SSID, Authentication and Key
    Close All Browsers

Get Agent all SSID and BSSID
    [Tags]    Agent
    Get agent ip 
    SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    
Get Router all SSID and BSSID
    SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID

Disable Client wired Network and Reset WiFi Interface
    Disable Client wired Network
    Reset WiFi Interface

No.33 Connect 2G SSID controller
    [Tags]    2G
    Modify WPA Supplicant wpa3 Config    ${Changed_2G_SSID}    ${2G_SSID_BSSID}    ${Changed_SSID_PSK}
    Connect to ssid and ping controller and agent    ${2G_SSID_BSSID}     
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_SSID_BSSID}

No.34 Connect 5G SSID controller
    [Tags]    5G
    Modify WPA Supplicant wpa3 Config    ${Changed_5G_SSID}    ${5G_SSID_BSSID}    ${Changed_SSID_PSK}
    Connect to ssid and ping controller and agent    ${5G_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_SSID_BSSID}

No.35 Connect 6G SSID controller
    [Tags]    6G
    Modify WPA Supplicant wpa3 Config    ${Changed_6G_SSID}    ${6G_SSID_BSSID}    ${Changed_SSID_PSK}
    Connect to ssid and ping controller and agent    ${6G_SSID_BSSID}  
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_SSID_BSSID}

No.36 Connect 2G SSID agent
    [Tags]    Agent    2G
    Modify WPA Supplicant wpa3 Config    ${Changed_2G_SSID}    ${2G_Agent_SSID_BSSID}    ${Changed_SSID_PSK}
    Connect to ssid and ping controller and agent    ${2G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${2G_Agent_SSID_BSSID}

No.37 Connect 5G SSID agent
    [Tags]    Agent    5G
    Modify WPA Supplicant wpa3 Config    ${Changed_5G_SSID}    ${5G_Agent_SSID_BSSID}    ${Changed_SSID_PSK}
    Connect to ssid and ping controller and agent    ${5G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${5G_Agent_SSID_BSSID}

No.38 Connect 6G SSID agent
    [Tags]    Agent    6G    
    Modify WPA Supplicant wpa3 Config    ${Changed_6G_SSID}    ${6G_Agent_SSID_BSSID}    ${Changed_SSID_PSK}
    Connect to ssid and ping controller and agent    ${6G_Agent_SSID_BSSID} 
    [Teardown]    Run Keyword If    '${TEST STATUS}' == 'FAIL'    Check SSID can be scan    ${6G_Agent_SSID_BSSID}

No.39 Change to wireless onboarding
    [Tags]    Agent
    Disable the switch port connected to the agent
    sleep    300
    Enable Client wired Network
    Check agent is wireless onboarding
    [Teardown]    Restore to ethernet onbording

Enable Client wired Network
    Enable Client wired Network

Default Agent and disable switch port
    Default Agent and disable switch port



Defalut DUT/Agent and No wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    5
    Click Element    xpath=//*[@id="menu_management_settings"]
    sleep    5
    Click Element    xpath=//*[@id="lang_restore_btn"]
    sleep    5
    Click Element    xpath=//*[@id="confirm_dialog_confirmed"]
    sleep    3

Defalut DUT/Agent and Wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    5
    Click Element    xpath=//*[@id="menu_management_settings"]
    sleep    5
    Click Element    xpath=//*[@id="lang_restore_btn"]
    sleep    5
    Click Element    xpath=//*[@id="confirm_dialog_confirmed"]
    sleep    300

Defalut DUT and Wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    5
    Click Element    xpath=//*[@id="menu_management_settings"]
    sleep    5
    Click Element    xpath=//*[@id="lang_restore_btn"]
    sleep    5
    Click Element    xpath=//*[@id="confirm_dialog_confirmed"]
    sleep    300


Check DUT FW 
    [Arguments]    ${DUT_IP}
    Login GUI    ${DUT_IP}
    ${text} =    Get Text    xpath=//*[@id="dashboard_system_swversion"]
    Log    ${text}
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
    
Check Wizard
    Login Wizard GUI    ${HOST}
    ${result}=  Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[@id="lang_have_read_and_agree"]    timeout=10
    Run Keyword If    '${result}'=='True'    Setup Wizard
    Close All Browsers

Setup Wizard
    Wait Until Keyword Succeeds    3x    10s    Retry Setup Wizard

Retry Setup Wizard
    Run Keyword And Ignore Error    Close All Browsers
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
    sleep    120

Restore to ethernet onbording
    Enable the switch port connected to the agent
    sleep    300

Disable the switch port connected to the agent
    ${banner}=    Open Telnet Connection    ${Switch_HOST}    ${Switch_PORT}
    Log To Console    \n--- BANNER ---\n${banner}\n
    ${out}=    telnet_command    ethctl eth0 phy-power down
    Log To Console    \n--- IFCONFIG ---\n${out}\n
    telnet_exec_command

Enable the switch port connected to the agent
    ${banner}=    Open Telnet Connection    ${Switch_HOST}    ${Switch_PORT}
    Log To Console    \n--- BANNER ---\n${banner}\n
    ${out}=    telnet_command    ethctl eth0 phy-power up
    ${out1}=    telnet_command    ethctl eth0 media-type auto
    Log To Console    \n--- IFCONFIG ---\n${out}\n
    Log To Console    \n--- IFCONFIG ---\n${out1}\n
    telnet_exec_command

Disable the switch port connected to the controller
    ${banner}=    Open Telnet Connection    ${Switch_HOST}    ${Switch_PORT}
    Log To Console    \n--- BANNER ---\n${banner}\n
    ${out}=    telnet_command    ethctl eth3 phy-power down
    Log To Console    \n--- IFCONFIG ---\n${out}\n
    telnet_exec_command

Enable the switch port connected to the controller
    ${banner}=    Open Telnet Connection    ${Switch_HOST}    ${Switch_PORT}
    Log To Console    \n--- BANNER ---\n${banner}\n
    ${out}=    telnet_command    ethctl eth3 phy-power up
    ${out1}=    telnet_command    ethctl eth3 media-type auto
    Log To Console    \n--- IFCONFIG ---\n${out}\n
    Log To Console    \n--- IFCONFIG ---\n${out1}\n
    telnet_exec_command

Reboot Agent and No wait setup
    Click Element    xpath=//*[@id="menu_management"]
    sleep    5
    Click Element    xpath=//*[@id="menu_management_reboot"]
    sleep    5
    Click Element    xpath=//*[@id="lang_reboot_btn_title"]
    sleep    3

Release and renew ip on client
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S dhclient -r
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S dhclient

Disable Client wired Network
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S /sbin/ifconfig enp1s0 down

Enable Client wired Network
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S /sbin/ifconfig enp1s0 up
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager start
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S dhclient enp1s0 -r
    ${output}=    Run    echo ${Client_PASSWORD} | sudo -S ifconfig enp1s0 192.168.1.199 netmask 255.255.255.0
    sleep    60
    # ${output}=    Run    echo ${Client_PASSWORD} | sudo -S dhclient enp1s0
    ${output}=    Run    ping 192.168.1.1 -c 4
    Should Contain    ${output}    ttl=
    
Modify WPA Supplicant Config
    [Arguments]    ${SSID}    ${BSSID}    ${PSK}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${ORIG_CONF} ${TMP_CONF}    shell=True
    ${content}=    OperatingSystem.Get File    ${TMP_CONF}
    ${content}=    Replace String Using Regexp    ${content}    ssid=".*?"    ssid="${SSID}"
    ${content}=    Replace String Using Regexp    ${content}    bssid=.*    bssid=${BSSID}
    ${content}=    Replace String Using Regexp    ${content}    psk=".*?"    psk="${PSK}"
    Create File    ${TMP1_CONF}    ${content}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${TMP1_CONF} ${ORIG_CONF}    shell=True
    Log    ${ORIG_CONF}

Default Agent and disable switch port
    Wait Until Keyword Succeeds    3x    10s    Retry Default Agent and disable switch port

Retry Default Agent and disable switch port
    [Tags]	Agent
    Get agent ip
    Login GUI    ${Agent_IP}
    Defalut DUT/Agent and No wait setup
    Close All Browsers  
    Disable the switch port connected to the agent

Connect DUT SSID
    [Arguments]    ${SSID_mac}
    Wait Until Keyword Succeeds    3x    10s    Retry Connect DUT SSID    ${SSID_mac}

Retry Connect DUT SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S ip link set ${IFACE} up
    sleep    10
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_PATH} -D nl80211
    #Log To Console	${output}
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Sleep          3s

Change SSID, Authentication and Key
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Execute Javascript    document.body.style.zoom='0.2'
    Input Text    xpath=//*[@id="2g_ssid"]    ${Changed_2G_SSID}
    sleep    3
    Input Text    xpath=//*[@id="2g_wpa_key"]    ${Changed_SSID_PSK}
    sleep    3
    Select From List By Value    id=authtype_2g    wpa3
    Input Text    xpath=//*[@id="5g_ssid"]    ${Changed_5G_SSID}
    sleep    3
    Input Text    xpath=//*[@id="5g_wpa_key"]    ${Changed_SSID_PSK}
    sleep    3
    Select From List By Value    id=authtype_5g    wpa3
    Input Text    xpath=//*[@id="6g_ssid"]    ${Changed_6G_SSID}
    sleep    3
    Input Text    xpath=//*[@id="6g_wpa_key"]    ${Changed_SSID_PSK}
    sleep    3
    Select From List By Value    id=authtype_6g    wpa3
    Click Element    xpath=//*[@id="apply"]
    sleep    300

Modify WPA Supplicant wpa3 Config
    [Arguments]    ${SSID}    ${BSSID}    ${PSK}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${ORIG_wpa3_CONF} ${TMP_CONF}    shell=True
    ${content}=    OperatingSystem.Get File    ${TMP_CONF}
    ${content}=    Replace String Using Regexp    ${content}    ssid=".*?"    ssid="${SSID}"
    ${content}=    Replace String Using Regexp    ${content}    bssid=.*    bssid=${BSSID}
    ${content}=    Replace String Using Regexp    ${content}    psk=".*?"    psk="${PSK}"
    Create File    ${TMP1_wpa3_CONF}    ${content}
    Run Process    echo ${Client_PASSWORD} | sudo -S cp ${TMP1_wpa3_CONF} ${ORIG_wpa3_CONF}    shell=True
    Log    ${ORIG_wpa3_CONF}

Connect DUT wpa3 SSID
    [Arguments]    ${SSID_mac}
    Wait Until Keyword Succeeds    5x    10s    Retry Connect DUT wpa3 SSID    ${SSID_mac}

Retry Connect DUT wpa3 SSID
    [Arguments]    ${SSID_mac}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S service NetworkManager stop
    sleep    10
    ${output}=	Run    echo ${Client_PASSWORD} | sudo -S ip link set ${IFACE} up
    sleep    10
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo killall wpa_supplicant
    #Log To Console	${output}
    ${output}=	Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    ${output}=	Run    echo ${Client_PASSWORD} | sudo wpa_supplicant -B -i ${IFACE} -c ${conf_wpa3_PATH} -D nl80211
    #Log To Console	${output}
    Sleep          15
    ${output}=     Run    iw ${IFACE} link    
    Log            ${output}
    sleep   3
    Should Contain    ${output}    Connected to ${SSID_mac}
    #Run    echo ${Client_PASSWORD} | sudo dhclient ${IFACE}
    Run    echo ${Client_PASSWORD} | sudo ifconfig ${IFACE} 192.168.1.198 netmask 255.255.255.0
    Sleep          3

Connect to ssid and ping controller and agent
    [Arguments]    ${SSID_mac}
    Connect DUT wpa3 SSID    ${SSID_mac}
    ping controller
    ping agent
    
ping agent
    Wait Until Keyword Succeeds    3x    30s    Retry ping agent

ping controller 
    Wait Until Keyword Succeeds    3x    30s    Retry ping controller

Retry ping controller 
    ${output}=     Run    ifconfig ${IFACE}
    Should Contain    ${output}    192.168.1.
    # ${output}=    Run    ping 8.8.8.8 -c 4
    # Should Contain    ${output}    ttl=
    ${output}=    Run    ping -I ${IFACE} 192.168.1.1 -c 10
    Should Contain    ${output}    ttl=

Retry ping agent
    ${output}=     Run    ifconfig ${IFACE}
    Should Contain    ${output}    192.168.1.
    # ${output}=    Run    ping 8.8.8.8 -c 4
    # Should Contain    ${output}    ttl=
    ${output}=    Run    ping -I ${IFACE} ${Agent_IP} -c 10
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
    sleep    30
    Wait Until Element Is Visible    xpath=//*[@id="menu_dashboard"]    timeout=60
    Execute Javascript    document.body.style.zoom='0.5'
    sleep    1

Get agent ip
    Wait Until Keyword Succeeds    3x    10s    Retry Get agent ip

Retry Get agent ip
    Run Keyword And Ignore Error    Close All Browsers
    Login GUI    ${HOST} 
    Click Element    xpath=//*[@id="menu_status"]
    sleep    3
    Click Element    xpath=//*[@id="menu_status_wifiMesh"]
    sleep    20
    ${Agent_IP} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[2]
    sleep    3
    Set Suite Variable    ${Agent_IP}
    Close All Browsers

Check agent is wireless onboarding
    Login GUI    ${HOST} 
    Click Element    xpath=//*[@id="menu_status"]
    sleep    3
    Click Element    xpath=//*[@id="menu_status_wifiMesh"]
    sleep    20
    ${value} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[5]
    Should Contain    ${value}    WLAN
    Close All Browsers

SSH To Controller And Get default wifi password
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Controller And Get default wifi password

Retry SSH To Controller And Get default wifi password
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}
    ${Default_PSK} =    Execute Command    cat /etc/config/wireless | grep -m1 "option key" | awk -F 'option key ' '{print $2}' | tr -d "'"
    ${2G_Guest_SSID} =    Execute Command    iwconfig ath0 | grep 'ESSID' | awk -F 'ESSID:' '{print $2}' | tr -d '" '
    Set Suite Variable    ${Default_PSK}
    Log    Default SSID PSK: ${Default_PSK}
    Close Connection

Check SSID can be scan 
    [Arguments]    ${mac}
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5
    ${output}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -F -A 100 "BSS ${mac}"
    sleep    5

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

Enable Agent SSH 
    Wait Until Keyword Succeeds    3x    10s    Retry Enable Agent SSH

Retry Enable Agent SSH
    Run Keyword And Ignore Error    Close All Browsers
    Login GUI    ${Agent_IP}
    Click Element    xpath=//*[@id="menu_adv_setting"]
    sleep    5
    Click Element    xpath=//*[@id="menu_adv_setting_ssh"]
    sleep    15
    Click Element    xpath=//*[@id="switch_layout_ssh_enabled"]
    sleep    5
    Click Element    xpath=//*[@id="apply"]
    sleep    5
    Handle Alert
    sleep    30
    Close All Browsers  

Set DUT 5G and 6G channel to be scannable
    Wait Until Keyword Succeeds    3x    10s    Retry Set DUT 5G and 6G channel to be scannable

Retry Set DUT 5G and 6G channel to be scannable
    Run Keyword And Ignore Error    Close All Browsers
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_adv_allinone"]
    sleep    3
    Execute Javascript    document.body.style.zoom='0.2'
    Select From List By Value    id=wifi_channel_select5    40
    Select From List By Value    id=wifi_channel_select6    1
    Click Element    xpath=//*[@id="apply"]
    sleep    180
    Close All Browsers

Enable MLO
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="switch_layout_MLO_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    180

Change common/MLO SSID, Authentication and Key
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Input Text    xpath=//*[@id="commong_ssid"]    ${Changed_SSID}
    sleep    3
    Input Text    xpath=//*[@id="commong_wpa_key"]    ${Changed_PSK}
    sleep    3
    Select From List By Value    id=authtype_commong    mixed3
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300
    
Set DUT 6G channel to 53
    Execute Javascript    document.body.style.zoom='0.2'
    sleep    5
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_adv_allinone"]
    sleep    3
    Select From List By Value    id=wifi_channel_select6    45
    Click Element    xpath=//*[@id="apply"]
    sleep    180

SSH To Enable Mesh Agent And Get all MLO SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Agent And Get all MLO SSID and BSSID

Retry SSH To Enable Mesh Agent And Get all MLO SSID and BSSID
    Open Connection    ${Agent_IP}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld4" | awk '/ssid/{print $2}'
    ${2G_Agent_SSID_BSSID} =    Execute Command    iw dev mld4 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_Agent_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld4 info | grep channel
    ${2G_Agent_SSID_BSSID}=    Convert To Lower Case    ${2G_Agent_SSID_BSSID}
    Set Suite Variable    ${2G_Agent_SSID}
    Set Suite Variable    ${2G_Agent_SSID_BSSID}

    ${5G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld2" | awk '/ssid/{print $2}'
    ${5G_Agent_SSID_BSSID} =    Execute Command    iw dev mld2 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_Agent_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld2 info | grep channel
    ${5G_Agent_SSID_BSSID}=    Convert To Lower Case    ${5G_Agent_SSID_BSSID}
    Set Suite Variable    ${5G_Agent_SSID}
    Set Suite Variable    ${5G_Agent_SSID_BSSID}

    ${6G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld2" | awk '/ssid/{print $2}'
    ${6G_Agent_SSID_BSSID} =    Execute Command    iw dev mld2 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_Agent_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld2 info | grep channel
    ${6G_Agent_SSID_BSSID}=    Convert To Lower Case    ${6G_Agent_SSID_BSSID}
    Set Suite Variable    ${6G_Agent_SSID}
    Set Suite Variable    ${6G_Agent_SSID_BSSID}

    Close Connection

SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID

Retry SSH To Enable Mesh Agent And Get all Common/disable common SSID and BSSID
    Open Connection    ${Agent_IP}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_Agent_SSID_BSSID} =    Execute Command    iw dev mld3 info | awk '/link 0:/{getline; print $2}'
    ${2G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld3" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${2G_Agent_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld3 info | grep channel
    ${2G_Agent_SSID_BSSID}=    Convert To Lower Case    ${2G_Agent_SSID_BSSID}
    Set Suite Variable    ${2G_Agent_SSID}
    Set Suite Variable    ${2G_Agent_SSID_BSSID}

    ${5G_Agent_SSID_BSSID} =    Execute Command    iw dev mld5 info | awk '/link 1:/{getline; print $2}'
    ${5G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld5" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${5G_Agent_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld5 info | grep channel
    ${5G_Agent_SSID_BSSID}=    Convert To Lower Case    ${5G_Agent_SSID_BSSID}
    Set Suite Variable    ${5G_Agent_SSID}
    Set Suite Variable    ${5G_Agent_SSID_BSSID}

    ${6G_Agent_SSID_BSSID} =    Execute Command    iw dev mld7 info | awk '/link 2:/{getline; print $2}'
    ${6G_Agent_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld7" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${6G_Agent_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld7 info | grep channel
    ${6G_Agent_SSID_BSSID}=    Convert To Lower Case    ${6G_Agent_SSID_BSSID}
    Set Suite Variable    ${6G_Agent_SSID}
    Set Suite Variable    ${6G_Agent_SSID_BSSID}

    Close Connection

Disable MLO and common ssid
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Wait Until Element Is Visible    xpath=//*[@id="switch_layout_single_ssid_enable"]    timeout=30
    Click Element    xpath=//*[@id="switch_layout_single_ssid_enable"]
    sleep    3
    Execute Javascript    document.body.style.zoom='0.2'
    sleep    5
    Click Element    xpath=//*[@id="apply"]
    sleep    180

SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID

Retry SSH To Enable Mesh Router And Get all Common/disable common SSID and BSSID
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_SSID_BSSID} =    Execute Command    iw dev mld0 info | awk '/link 0:/{getline; print $2}'
    ${2G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld0" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${2G_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld0 info | grep channel
    ${2G_SSID_BSSID}=    Convert To Lower Case    ${2G_SSID_BSSID}
    Set Suite Variable    ${2G_SSID}
    Set Suite Variable    ${2G_SSID_BSSID}

    ${5G_SSID_BSSID} =    Execute Command    iw dev mld2 info | awk '/link 1:/{getline; print $2}'
    ${5G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld2" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${5G_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld2 info | grep channel
    ${5G_SSID_BSSID}=    Convert To Lower Case    ${5G_SSID_BSSID}
    Set Suite Variable    ${5G_SSID}
    Set Suite Variable    ${5G_SSID_BSSID}

    ${6G_SSID_BSSID} =    Execute Command    iw dev mld4 info | awk '/link 2:/{getline; print $2}'
    ${6G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld4" | awk '/ssid/{print $2}'
    Should Not Be Equal    ${6G_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld4 info | grep channel
    ${6G_SSID_BSSID}=    Convert To Lower Case    ${6G_SSID_BSSID}
    Set Suite Variable    ${6G_SSID}
    Set Suite Variable    ${6G_SSID_BSSID}

    Close Connection

SSH To Enable Mesh Router And Get all MLO SSID and BSSID
    Wait Until Keyword Succeeds    3x    10s    Retry SSH To Enable Mesh Router And Get all MLO SSID and BSSID

Retry SSH To Enable Mesh Router And Get all MLO SSID and BSSID
    Open Connection    ${HOST}
    Login              ${USER}    ${SSH_PASSWORD}

    ${2G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld1" | awk '/ssid/{print $2}'
    ${2G_SSID_BSSID} =    Execute Command    iw dev mld2 info | awk '/link 0:/{getline; print $2}'
    Should Not Be Equal    ${2G_SSID_BSSID}    ${EMPTY}
    ${2G_channel} =    Execute Command    iw dev mld2 info | grep channel
    ${2G_SSID_BSSID}=    Convert To Lower Case    ${2G_SSID_BSSID}
    Set Suite Variable    ${2G_SSID}
    Set Suite Variable    ${2G_SSID_BSSID}

    ${5G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld1" | awk '/ssid/{print $2}'
    ${5G_SSID_BSSID} =    Execute Command    iw dev mld1 info | awk '/link 1:/{getline; print $2}'
    Should Not Be Equal    ${5G_SSID_BSSID}    ${EMPTY}
    ${5G_channel} =    Execute Command    iw dev mld1 info | grep channel
    ${5G_SSID_BSSID}=    Convert To Lower Case    ${5G_SSID_BSSID}
    Set Suite Variable    ${5G_SSID}
    Set Suite Variable    ${5G_SSID_BSSID}

    ${6G_SSID} =    Execute Command    iw dev | grep -A5 "Interface mld1" | awk '/ssid/{print $2}'
    ${6G_SSID_BSSID} =    Execute Command    iw dev mld1 info | awk '/link 2:/{getline; print $2}'
    Should Not Be Equal    ${6G_SSID_BSSID}    ${EMPTY}
    ${6G_channel} =    Execute Command    iw dev mld1 info | grep channel
    ${6G_SSID_BSSID}=    Convert To Lower Case    ${6G_SSID_BSSID}
    Set Suite Variable    ${6G_SSID}
    Set Suite Variable    ${6G_SSID_BSSID}

    Close Connection

Reset WiFi Interface
    Run    echo ${Client_PASSWORD} | sudo pkill -f wpa_supplicant || true
    Run    echo ${Client_PASSWORD} | sudo pkill -f dhclient || true
    Run    echo ${Client_PASSWORD} | sudo rm -rf /var/run/wpa_supplicant
    Run    echo ${Client_PASSWORD} | sudo ip link set ${IFACE} down
    Sleep    2s
    Run    echo ${Client_PASSWORD} | sudo ip addr flush dev ${IFACE}
    Run    echo ${Client_PASSWORD} | sudo ip link set ${IFACE} up
    Sleep    2s

Check Mesh connection status
    Click Element    xpath=//*[@id="menu_status"]
    sleep    3
    Click Element    xpath=//*[@id="menu_status_wifiMesh"]
    sleep    3
    ${Agent} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[1]
    sleep    3
    Should Contain    ${Agent}    WREQ-130BE-
    ${Type} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[5]
    sleep    3
    Should Contain    ${Type}    	ETHER
    ${Role} =    Get Text    xpath=//*[@id="Mesh_topology_table_id_1"]/td[6]
    sleep    3
    Should Contain    ${Role}    	Agent

Scan SSID on client 
    ${result}=    Run    echo ${Client_PASSWORD} | sudo iw dev ${IFACE} scan | grep -E 'SSID|BSS'
    Log To Console    ${result}
    Should Contain    ${result}   	${2G_SSID}    
    Should Contain    ${result}    	${2G_SSID_BSSID}
    Should Contain    ${result}   	${5G_SSID}    
    Should Contain    ${result}    	${5G_SSID_BSSID}
    Should Contain    ${result}   	${6G_SSID}    
    # Should Contain    ${result}    	${6G_SSID_BSSID}
    Should Contain    ${result}   	${2G_Agent_SSID}    
    Should Contain    ${result}    	${2G_Agent_SSID_BSSID}
    Should Contain    ${result}   	${5G_Agent_SSID}    
    Should Contain    ${result}    	${5G_Agent_SSID_BSSID}
    Should Contain    ${result}   	${6G_Agent_SSID}    
    # Should Contain    ${result}    	${6G_Agent_SSID_BSSID}
    
Disable Guest
    Login GUI    ${HOST}
    Click Element    xpath=//*[@id="menu_basic_setting"]
    sleep    3
    Click Element    xpath=//*[@id="menu_basic_setting_wlan"]
    sleep    3
    Click Element    xpath=//*[@id="tab_wifi_zone"]
    sleep    3
    Click Element    xpath=//*[@id="switch_layout_guest_enable"]
    sleep    3
    Click Element    xpath=//*[@id="apply"]
    sleep    300
    Close All Browsers   