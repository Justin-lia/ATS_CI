*** Settings ***
Library    Telnet
Library    SSHLibrary
Library    String

*** Variables ***

*** Keywords ***
Reference v6 Server setup, M bit 1
    Telnet.Open Connection    ${DEVICES.ciscoRouter.ip}    timeout=60    prompt=${DEVICES.ciscoRouter.prompt}     port=${DEVICES.ciscoRouter.port}
    Telnet.Login    ${DEVICES.ciscoRouter.user_name}    ${DEVICES.ciscoRouter.password}    login_prompt=${DEVICES.ciscoRouter.login_prompt}    password_prompt=${DEVICES.ciscoRouter.password_prompt}
    Telnet.Set Timeout    ${DEVICES.ciscoRouter.timeout}
    ${result}=    Telnet.Read
    sleep    2
    Telnet.Set Prompt    C1801>
    ${result}=    Telnet.Execute Command    \r
    log    ${result}
    Telnet.Set Prompt    Password:
    ${result}=    Telnet.Execute Command    enable
    log    ${result}
    Telnet.Set Prompt    C1801#
    ${result}=    Telnet.Execute Command    cisco1234567890
    log    ${result}
    Telnet.Set Prompt    C1801(config)#
    ${result}=    Telnet.Execute Command    config t
    log    ${result}
    Telnet.Set Prompt    C1801(config-if)#
    ${result}=    Telnet.Execute Command    interface GigabitEthernet0/0
    log    ${result}
    Telnet.Set Prompt    C1801(config-if)#
    ${result}=    Telnet.Execute Command    ipv6 nd managed-config-flag
    log    ${result}
    Telnet.Set Prompt    C1801#
    ${result}=    Telnet.Execute Command    end
    log    ${result}
    Telnet.Set Prompt    Press RETURN to get started
    ${result}=    Telnet.Execute Command    exit
    log    ${result}
    Telnet.Close All Connections
    sleep    2

Reference Clear Cisco Router Port
    [Tags]   @AUTHOR=Frank_Hung
    [Arguments]    ${Port_Number_Clear}
    wait until keyword succeeds    2x    3s    Reference Clear cisco port    ${Port_Number_Clear}


Reference Clear cisco port
    [Documentation]  Clear cisco port to prevent  Connection refused
    [Arguments]    ${cisco_line}
    Telnet.Open Connection    ${DEVICES.terminal_server.ip}    timeout=60    prompt=${DEVICES.terminal_server.prompt}     port=${DEVICES.terminal_server.port}
    Telnet.Login    ${DEVICES.terminal_server.user_name}    ${DEVICES.terminal_server.password}    login_prompt=${DEVICES.terminal_server.login_prompt}    password_prompt=${DEVICES.terminal_server.password_prompt}
    Telnet.Set Timeout    ${DEVICES.terminal_server.timeout}
    ${result}=    Telnet.Read

    Telnet.Set Prompt    Password:
    ${result}=    Telnet.Execute Command    enable
    log    ${result}

    Telnet.Set Prompt    ATS-TERMSERV#
    ${result}=    Telnet.Execute Command    lab
    log    ${result}

    Telnet.Set Prompt    [confirm]
    ${result}=    Telnet.Execute Command    clear line ${cisco_line}
    log    ${result}

    Telnet.Set Prompt    ATS-TERMSERV#
    ${result}=    Telnet.Execute Command    y
    log    ${result}

    Telnet.Set Prompt    ATS-TERMSERV#
    ${result}=    Telnet.Execute Command    exit
    log    ${result}

    Telnet.Close All Connections
    RETURN    ${result}



cli
    [Arguments]    ${Device}    ${Command}    @{other_agrs}
    log    ${other_agrs}
    ${other_agrs}=    Convert To String    ${other_agrs}
    ${other_agrs}=    Remove String    ${other_agrs}    [    ]
    ${prompt_arg}=    Fetch From Right    ${other_agrs}    prompt=
    ${prompt_arg}=    Fetch From left    ${prompt_arg}    '
    ${timeout_arg}=    Fetch From Right    ${other_agrs}    timeout=
    ${timeout_arg}=    Fetch From left    ${timeout_arg}    '
    ${result_1}=    Run Keyword If    '${DEVICES.${Device}.protocol}'=='telnet'    cli_telnet    ${Device}    ${Command}    ${timeout_arg}    ${prompt_arg}
    ${result_2}=    Run Keyword If    '${DEVICES.${Device}.protocol}'=='ssh'    cli_ssh    ${Device}    ${Command}    ${timeout_arg}    ${prompt_arg}
    ${result_3}=    Run Keyword If    '${DEVICES.${Device}.protocol}'=='serial'    cli_serial    ${Device}    ${Command}    ${timeout_arg}    ${prompt_arg}
    ${result}=     Catenate    SEPARATOR=    ${result_1}    ${result_2}    ${result_3}
    ${result}=    Remove String    ${result}    NoneNone
    log    ${result}
    RETURN    ${result}

cli_serial
    [Arguments]    ${Device}    ${Command}    ${timeout}    ${prompt}
    pyserial.open_serial_connection    port=${DEVICES.${Device}.comPort}    boud=${DEVICES.${Device}.baud_num}
    log    ${Command}
    ${result}=    pyserial.command_enter    \n
    sleep    1
    ${result}=    pyserial.read_all_data
    ${result}=    pyserial.command_enter    ${Command}
    log    ${prompt}
    ${result}=    pyserial.read_until_print_result    ${prompt}
    log    ${result}
    pyserial.close_Serial_Port
    RETURN    ${result}

cli_ssh
    [Arguments]    ${Device}    ${Command}    ${timeout}    ${prompt}
    SSHLibrary.Open Connection    ${DEVICES.${Device}.ip}    timeout=60    prompt=${DEVICES.${Device}.prompt}     port=${DEVICES.${Device}.port}
    SSHLibrary.Login    ${DEVICES.${Device}.user_name}    ${DEVICES.${Device}.password}    login_prompt=${DEVICES.${Device}.login_prompt}    password_prompt=${DEVICES.${Device}.password_prompt}
    Run Keyword If    '${prompt}'!=''    SSHLibrary.Set Client Configuration    prompt=${prompt}
    Run Keyword If    '${timeout}'!=''    SSHLibrary.Set Client Configuration    timeout=${timeout}

    #${result}=    SSHLibrary.Execute Command    ${Command}    timeout=${timeout}
    ${result}=    SSHLibrary.Write    ${Command}
    ${result}=    SSHLibrary.Read Until Prompt
    log    ${result}
    SSHLibrary.Close All Connections
    RETURN    ${result}

cli_telnet
    [Arguments]    ${Device}    ${Command}    ${timeout}    ${prompt}
    Telnet.Open Connection    ${DEVICES.${Device}.ip}    timeout=60    prompt=${DEVICES.${Device}.prompt}     port=${DEVICES.${Device}.port}
    ${login_result}=    Telnet.Login    ${DEVICES.${Device}.user_name}    ${DEVICES.${Device}.password}    login_prompt=${DEVICES.${Device}.login_prompt}    password_prompt=${DEVICES.${Device}.password_prompt}
    Run Keyword If    '${timeout}'==''    Telnet.Set Timeout    ${DEVICES.${Device}.timeout}
    Run Keyword If    '${timeout}'!=''    Telnet.Set Timeout    ${timeout}
    ${result}=    Telnet.Read
    log    ${timeout}
    log    ${prompt}
    Run Keyword If    '${prompt}'!=''    Telnet.Set Prompt    ${prompt}
    log    ${Command}
    ${result}=    Telnet.Write    ${Command}
    sleep    2
    ${result}=    Run Keyword And Ignore Error    Telnet.Read Until Prompt
    sleep    2
    ${result_2}=    Telnet.Read
    ${result} =   Catenate    ${result}   ${result_2}
    log    ${result}
    Telnet.Close Connection
    RETURN    ${result}
