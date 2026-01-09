*** Settings ***
#Resource    ./base.robot

*** Variables ***

*** Keywords ***
Use telnet to enter command qos-stat, verify there are no four obvious options
    ${result} =    cli    DUT_LAN_Telnet    \n    prompt=root@
    ${result} =    cli    DUT_LAN_Telnet    qos-stat    prompt=#    prompt=root@
    Should Not Contain    ${result}    high
    Should Not Contain    ${result}    medium
    Should Not Contain    ${result}    normal
    Should Not Contain    ${result}    low

Use telnet to enter command qos-stat, verify there are four obvious options
    ${result} =    cli    DUT_LAN_Telnet    \n    prompt=root@
    ${result} =    cli    DUT_LAN_Telnet    qos-stat    prompt=#    prompt=root@
    Should Contain    ${result}    high
    Should Contain    ${result}    medium
    Should Contain    ${result}    normal
    Should Contain    ${result}    low

Use console command qos-stat, verify there are no four obvious options
    ${result}=    cli    ${DEVICES.console.vendor}    \n    prompt=login:
    sleep    3
    ${result}=    cli    ${DEVICES.console.vendor}    root\n    prompt=Password:    timeout=10
    sleep    3
    ${result}=    cli    ${DEVICES.console.vendor}    5/4jp6t03qup3\n    prompt=#
    sleep    3
    ${result}=    cli    ${DEVICES.console.vendor}    qos-stat    prompt=#
    log    ${result}
    sleep    1
    Should Not Contain    ${result}    high
    Should Not Contain    ${result}    medium
    Should Not Contain    ${result}    normal
    Should Not Contain    ${result}    low
    [Teardown]    cli    ${DEVICES.console.vendor}    login    prompt=login:

Use console command qos-stat, verify there are four obvious options
    ${result}=    cli    ${DEVICES.console.vendor}    \n    prompt=login:
    sleep    3
    ${result}=    cli    ${DEVICES.console.vendor}    root\n    prompt=Password:    timeout=10
    sleep    3
    ${result}=    cli    ${DEVICES.console.vendor}    5/4jp6t03qup3\n    prompt=#
    sleep    3
    ${result}=    cli    ${DEVICES.console.vendor}    \n    prompt=#
    sleep    1
    ${result}=    cli    ${DEVICES.console.vendor}    \n    prompt=#
    sleep    1
    ${result}=    cli    ${DEVICES.console.vendor}    qos-stat    prompt=#
    log    ${result}
    sleep    1
    Should Contain    ${result}    high
    Should Contain    ${result}    medium
    Should Contain    ${result}    normal
    Should Contain    ${result}    low
    [Teardown]    cli    ${DEVICES.console.vendor}    login    prompt=login:

Verify the UDP throughput, bandwidth occupy rate: High (55) > Medium (75) > Normal (95) > Low (115)
    ${udp_55port_thoughput}=    cli    wanhost    cat log55udp.txt | grep "0.0-10"
    ${udp_55port_thoughput} =  Fetch From Right  ${udp_55port_thoughput}    Bytes
    ${udp_55port_thoughput} =  Fetch From Left    ${udp_55port_thoughput}    Mbits
    ${udp_55port_thoughput} =  Strip String    ${udp_55port_thoughput}

    ${udp_75port_thoughput}=    cli    wanhost    cat log75udp.txt | grep "0.0-10"
    ${udp_75port_thoughput} =  Fetch From Right  ${udp_75port_thoughput}    Bytes
    ${udp_75port_thoughput} =  Fetch From Left    ${udp_75port_thoughput}    Mbits
    ${udp_75port_thoughput} =  Strip String    ${udp_75port_thoughput}

    ${udp_95port_thoughput}=    cli    wanhost    cat log95udp.txt | grep "0.0-10"
    ${udp_95port_thoughput} =  Fetch From Right  ${udp_95port_thoughput}    Bytes
    ${udp_95port_thoughput} =  Fetch From Left    ${udp_95port_thoughput}    Mbits
    ${udp_95port_thoughput} =  Strip String    ${udp_95port_thoughput}

    ${udp_115port_thoughput}=    cli    wanhost    cat log115udp.txt | grep "0.0-10"
    ${udp_115port_thoughput} =  Fetch From Right  ${udp_115port_thoughput}    Bytes
    ${udp_115port_thoughput} =  Fetch From Left    ${udp_115port_thoughput}    Mbits
    ${udp_115port_thoughput} =  Strip String    ${udp_115port_thoughput}

    ${udp_55port_thoughput}=    Convert To Number    ${udp_55port_thoughput}
    ${udp_75port_thoughput}=    Convert To Number    ${udp_75port_thoughput}
    ${udp_95port_thoughput}=    Convert To Number    ${udp_95port_thoughput}
    ${udp_115port_thoughput}=    Convert To Number    ${udp_115port_thoughput}

    ${throughput55-75}=    Evaluate    ${udp_55port_thoughput}-${udp_75port_thoughput}
    Should Be True    ${throughput55-75}>5
    ${throughput75-95}=    Evaluate    ${udp_75port_thoughput}-${udp_95port_thoughput}
    Should Be True    ${throughput75-95}>5
    ${throughput95-115}=    Evaluate    ${udp_95port_thoughput}-${udp_115port_thoughput}
    Should Be True    ${throughput95-115}>5

Create 4 rules and save, UDP Port 50-60 (High), UDP Port 70-80 (Medium), UDP Port 90-100 (Normal), UDP Port 110-120 (Low)
    input_text    id=inp_qos_name    High
    sleep    1
    input_text    id=inp_qos_port1_start    50
    sleep    1
    input_text    id=inp_qos_port1_end    60
    sleep    1
    Select From List By Value    id=sel_qos_proto1    2
    sleep    1
    Select From List By Value    id=sel_qos_prio    3
    sleep    1
    click element    id=btn_qos_add
    sleep    2

    input_text    id=inp_qos_name    Medium
    sleep    1
    input_text    id=inp_qos_port1_start    70
    sleep    1
    input_text    id=inp_qos_port1_end    80
    sleep    1
    Select From List By Value    id=sel_qos_proto1    2
    sleep    1
    Select From List By Value    id=sel_qos_prio    2
    sleep    1
    click element    id=btn_qos_add
    sleep    2

    input_text    id=inp_qos_name    Normal
    sleep    1
    input_text    id=inp_qos_port1_start    90
    sleep    1
    input_text    id=inp_qos_port1_end    100
    sleep    1
    Select From List By Value    id=sel_qos_proto1    2
    sleep    1
    Select From List By Value    id=sel_qos_prio    1
    sleep    1
    click element    id=btn_qos_add
    sleep    2

    input_text    id=inp_qos_name    Low
    sleep    1
    input_text    id=inp_qos_port1_start    110
    sleep    1
    input_text    id=inp_qos_port1_end    120
    sleep    1
    Select From List By Value    id=sel_qos_proto1    2
    sleep    1
    Select From List By Value    id=sel_qos_prio    0
    sleep    1
    click element    id=btn_qos_add
    sleep    2

    click element    xpath=//*[@id="main-content"]/div/div[2]/button[1]
    sleep    30
    Close Browser

Verify the throughput, bandwidth occupy rate: High (55) > Medium (75) > Normal (95) > Low (115)
    ${tcp_55port_thoughput}=    cli    wanhost    cat log55tcp.txt | grep "receiver"
    ${tcp_55port_thoughput} =  Fetch From Right  ${tcp_55port_thoughput}    Bytes
    ${tcp_55port_thoughput} =  Fetch From Left    ${tcp_55port_thoughput}    Mbits
    ${tcp_55port_thoughput} =  Strip String    ${tcp_55port_thoughput}

    ${tcp_75port_thoughput}=    cli    wanhost    cat log75tcp.txt | grep "receiver"
    ${tcp_75port_thoughput} =  Fetch From Right  ${tcp_75port_thoughput}    Bytes
    ${tcp_75port_thoughput} =  Fetch From Left    ${tcp_75port_thoughput}    Mbits
    ${tcp_75port_thoughput} =  Strip String    ${tcp_75port_thoughput}

    ${tcp_95port_thoughput}=    cli    wanhost    cat log95tcp.txt | grep "receiver"
    ${tcp_95port_thoughput} =  Fetch From Right  ${tcp_95port_thoughput}    Bytes
    ${tcp_95port_thoughput} =  Fetch From Left    ${tcp_95port_thoughput}    Mbits
    ${tcp_95port_thoughput} =  Strip String    ${tcp_95port_thoughput}

    ${tcp_115port_thoughput}=    cli    wanhost    cat log115tcp.txt | grep "receiver"
    ${tcp_115port_thoughput} =  Fetch From Right  ${tcp_115port_thoughput}    Bytes
    ${tcp_115port_thoughput} =  Fetch From Left    ${tcp_115port_thoughput}    Mbits
    ${tcp_115port_thoughput} =  Strip String    ${tcp_115port_thoughput}

    ${tcp_55port_thoughput}=    Convert To Number    ${tcp_55port_thoughput}
    ${tcp_75port_thoughput}=    Convert To Number    ${tcp_75port_thoughput}
    ${tcp_95port_thoughput}=    Convert To Number    ${tcp_95port_thoughput}
    ${tcp_115port_thoughput}=    Convert To Number    ${tcp_115port_thoughput}

    ${throughput55-75}=    Evaluate    ${tcp_55port_thoughput}-${tcp_75port_thoughput}
    Should Be True    ${throughput55-75}>5
    ${throughput75-95}=    Evaluate    ${tcp_75port_thoughput}-${tcp_95port_thoughput}
    Should Be True    ${throughput75-95}>5
    ${throughput95-115}=    Evaluate    ${tcp_95port_thoughput}-${tcp_115port_thoughput}
    Should Be True    ${throughput95-115}>5

Use Iperf, LAN PC send 4 traffics (UDP Port 55,75,95,115) to WAN PC
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S killall iperf
    sleep    10
    cli    wanhost    rm log*.txt
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S iperf -s -p 55 -u -i 1 > log55udp.txt&
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S iperf -s -p 75 -u -i 1 > log75udp.txt&
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S iperf -s -p 95 -u -i 1 > log95udp.txt&
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S iperf -s -p 115 -u -i 1 > log115udp.txt&
    sleep    1

    cli    lanhost    ./iperf_udp_55_75_95_115.sh    prompt=iperf test done    timeout=80
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S killall iperf
    sleep    1

Use Iperf3, LAN PC send 4 traffics (Port 55,75,95,115) to WAN PC
    WAN PC Renew IP
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S killall iperf3
    sleep    10
    cli    wanhost    rm log*.txt
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S iperf3 -s -p 55 > log55tcp.txt&
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S iperf3 -s -p 75 > log75tcp.txt&
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S iperf3 -s -p 95 > log95tcp.txt&
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S iperf3 -s -p 115 > log115tcp.txt&
    sleep    1

    cli    lanhost    ./iperf3_tcp_55_75_95_115.sh    prompt=iperf test done    timeout=80
    sleep    1
    cli    wanhost    echo '${DEVICES.wanhost.password}' | sudo -S killall iperf3
    sleep    1


Create 4 rules and save, TCP Port 50-60 (High), TCP Port 70-80 (Medium), TCP Port 90-100 (Normal), TCP Port 110-120 (Low)
    input_text    id=inp_qos_name    High
    sleep    1
    input_text    id=inp_qos_port1_start    50
    sleep    1
    input_text    id=inp_qos_port1_end    60
    sleep    1
    Select From List By Value    id=sel_qos_proto1    1
    sleep    1
    Select From List By Value    id=sel_qos_prio    3
    sleep    1
    click element    id=btn_qos_add
    sleep    2

    input_text    id=inp_qos_name    Medium
    sleep    1
    input_text    id=inp_qos_port1_start    70
    sleep    1
    input_text    id=inp_qos_port1_end    80
    sleep    1
    Select From List By Value    id=sel_qos_proto1    1
    sleep    1
    Select From List By Value    id=sel_qos_prio    2
    sleep    1
    click element    id=btn_qos_add
    sleep    2

    input_text    id=inp_qos_name    Normal
    sleep    1
    input_text    id=inp_qos_port1_start    90
    sleep    1
    input_text    id=inp_qos_port1_end    100
    sleep    1
    Select From List By Value    id=sel_qos_proto1    1
    sleep    1
    Select From List By Value    id=sel_qos_prio    1
    sleep    1
    click element    id=btn_qos_add
    sleep    2

    input_text    id=inp_qos_name    Low
    sleep    1
    input_text    id=inp_qos_port1_start    110
    sleep    1
    input_text    id=inp_qos_port1_end    120
    sleep    1
    Select From List By Value    id=sel_qos_proto1    1
    sleep    1
    Select From List By Value    id=sel_qos_prio    0
    sleep    1
    click element    id=btn_qos_add
    sleep    2

    click element    xpath=//*[@id="main-content"]/div/div[2]/button[1]
    sleep    30
    Close Browser

Select Category: Application
    Select From List By Value    id=sel_qos_cat    0
    sleep    1

Select Bandwidth: Manual 51200 Kbps
    Select From List By Value    id=sel_qos_bw    1
    sleep    1
    Select From List By Value    id=sel_qos_unit_up    0
    sleep    1
    Select From List By Value    id=sel_qos_unit_down    0
    sleep    1
    input_text    id=inp_qos_uplink    51200
    sleep    1
    input_text    id=inp_qos_downlink    51200
    sleep    1
    click element    xpath=//*[@id="main-content"]/div/div[2]/button[1]
    sleep    30
    Close Browser

Select Bandwidth: Manual 20 MBps
    Select From List By Value    id=sel_qos_bw    1
    sleep    1
    Select From List By Value    id=sel_qos_unit_up    1
    sleep    1
    Select From List By Value    id=sel_qos_unit_down    1
    sleep    1
    input_text    id=inp_qos_uplink    20
    sleep    1
    input_text    id=inp_qos_downlink    20
    sleep    1
    click element    xpath=//*[@id="main-content"]/div/div[2]/button[1]
    sleep    30
    Close Browser

Select Bandwidth: Auto
    Select From List By Value    id=sel_qos_bw    1
    sleep    1
    input_text    id=inp_qos_uplink    5000
    sleep    1
    input_text    id=inp_qos_downlink    5000
    sleep    1
    Select From List By Value    id=sel_qos_bw    0
    sleep    1

Open QoS Page, disable the Internet Access Priority
    Login GUI    ${URL}    ${DUT_Password}
    Open QoS Page
    ${enable_or_disable}=    get_element_attribute    xpath=//*[@id="main-content"]/div/form/div[1]/div/div    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='el-switch is-checked'    click element    xpath=//*[@id="main-content"]/div/form/div[1]/div/div
    sleep    2
    click element    xpath=//*[@id="main-content"]/div/div[2]/button[1]
    sleep    30
    Close Browser

Open QoS Page, enable the Internet Access Priority
    Login GUI    ${URL}    ${DUT_Password}
    Open QoS Page
    ${enable_or_disable}=    get_element_attribute    xpath=//*[@id="main-content"]/div/form/div[1]/div/div    class
    log    ${enable_or_disable}
    sleep    2
    Run Keyword If      '${enable_or_disable}'=='el-switch'    click element    xpath=//*[@id="main-content"]/div/form/div[1]/div/div
    sleep    2

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