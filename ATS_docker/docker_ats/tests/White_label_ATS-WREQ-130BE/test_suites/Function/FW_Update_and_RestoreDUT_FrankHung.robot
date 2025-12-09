*** Settings ***
Resource    ../base.robot
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN_FrankHung.robot
Resource    ../../keyword/kw_Basic_WiFi_FrankHung.robot
Resource    ../../keyword/kw_FW_Update_and_RestoreDUT_FrankHung.robot
Resource    ../../keyword/kw_testlink_FrankHung.robot
#Suite Setup    Open Web GUI    ${URL}
#Suite Setup    Open Web GUI and Reboot Wifi_Client    ${URL}
#Suite Setup    Open Web GUI and Reset to Default    ${URL}    ${DUT_Password}
#Suite Teardown    Login and Reset Default DUT        ${URL}    ${DUT_Password}

*** Variables ***

*** Test Cases ***
#Reboot Wifi_Client
#    [Tags]    @AUTHOR=Frank_Hung
#    Reboot Wifi_Client_1 and Wifi_Client_2

#Detect GUI with Model Name
#    [Tags]
#    ${gui_type}     run keyword and return status    Page Should Contain Text    WSR-1166DHP
#    ${gui_type}    Convert to String    ${gui_type}
#    Should Contain    ${gui_type}    True

#Reboot from Consloe
#    [Tags]    @AUTHOR=Frank_Hung
#    Reboot DUT from Console

Create SSID Name for auto test
    [Tags]    @AUTHOR=Frank_Hung    testing2
    ${result}=    Generate Random String    4    [NUMBERS]

    ${ssid_5G_1}=    Catenate    SEPARATOR=    5G_0123456789    ${result}

    Set Suite Variable    ${ssid_5G_1}    ${ssid_5G_1}
    Set Suite Variable    ${wifi_password}    ghijGHIJK/

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

G-CPE-179 : Update Firmware with the wrong file
    [Tags]    @AUTHOR=Frank_Hung
    Update a wrong Firmware from GUI, verify DUT cannot updated and an error message appears    ${other_regions_FW}
    [Teardown]    upload result to testlink    G-CPE-179


G-CPE-178 : Manual update firmware
    [Tags]    @AUTHOR=Frank_Hung    regressionTag    testing2
    Update Firmware from Update Software Page
    Verify Firmware Update Success
    [Teardown]    upload result to testlink    G-CPE-178

G-CPE-178-1 : Manual update firmware new
    [Tags]    @AUTHOR=Frank_Hung    regressionTag    testing2
    Update Firmware from Update Software Page
    Verify Firmware Update Success
    #[Teardown]    upload result to testlink    G-CPE-178

G-CPE-178-2 : Manual update firmware old
    [Tags]    @AUTHOR=Frank_Hung    regressionTag    testing2
    Update Firmware from Update Software Page
    Verify Firmware Update Success
    #[Teardown]    upload result to testlink    G-CPE-178



G-CPE-175 : Save Current Settings
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ${ssid_5G_1}    ${wifi_password}
    Save DUT Current Settings, and check Config file can be saved
    [Teardown]    upload result to testlink    G-CPE-175

G-CPE-176 : Restore Configuration from Backup File
    [Tags]    @AUTHOR=Frank_Hung
    Change WiFi 5GHz SSID to "0123456789_5G_xxxx" and click "Save"    ssid11223344    11223344
    Restore DUT settings from GUI
    sleep    240
    Verify DUT WiFi setting can be resotred    ${ssid_5G_1}
    [Teardown]    upload result to testlink    G-CPE-176

G-CPE-177 : Restore Configuration from wrong File
    [Tags]    @AUTHOR=Frank_Hung
    Restore a wrong config file on DUT, verify GUI show error message
    [Teardown]    upload result to testlink    G-CPE-177


**** comments ****

























*** Keywords ***
Update Firmware than Downgrade Firmware
    Upgrade Firmware
    sleep    40
    Downgrade Firmware
    sleep    40

Upgrade Firmware
    Update Firmware from Update Software Page    ${Path_for_FW_Update}
    Verify Firmware Update Success    ${Expect_FW_Version}


Downgrade Firmware
    Update Firmware from Update Software Page    ${Path_for_FW_Downgrade}
    Verify Firmware Update Success    ${Expect_FW_Version_Downgrade}

