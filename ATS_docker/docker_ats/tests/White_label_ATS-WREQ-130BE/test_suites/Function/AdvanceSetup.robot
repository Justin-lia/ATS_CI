*** Settings ***
Resource    ../base.robot
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN.robot
Resource    ../../keyword/kw_AdvanceSetup.robot
Resource    ../../keyword/kw_testlink.robot

*** Variables ***

*** Test Cases ***

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Login and Reset Default DUT        ${URL}    ${DUT_Password}
    Get DUT WAN IP

G-CPE-297 : Verify Remote Management Access
    [Tags]    @AUTHOR=Frank_Hung
    Enable Service control on DUT, create a rule accept WAN access for http
    Verify WAN PC use http Can access DUT's WebUI
    Verify WAN PC use https Can access DUT's WebUI
    Delete an ACL Rule
    [Teardown]    upload result to testlink    G-CPE-297

G-CPE-298 : Verify Add rule in Service Ctrl deny Management Access
    [Tags]    @AUTHOR=Frank_Hung
    Enable Service control on DUT, create a rule deny WAN access for http
    Verify WAN PC use http Cannot access DUT's WebUI
    Verify WAN PC use https Cannot access DUT's WebUI
    Delete an ACL Rule
    [Teardown]    upload result to testlink    G-CPE-298

G-CPE-299 : Verify SSH access by LAN IP from LAN side
    [Tags]    @AUTHOR=Frank_Hung    regressionTag
    Enable SSH Service
    Create ACL SSH rule cannot be in Disable state
    Verify LAN PC can access DUT LAN IP by SSH
    Delete an ACL Rule
    [Teardown]    upload result to testlink    G-CPE-299

G-CPE-300 : Verify SSH access by WAN IP from LAN side
    [Tags]    @AUTHOR=Frank_Hung
    Create ACL SSH rule cannot be in Disable state, select LAN for Access Control
    Verify LAN PC can access DUT WAN IP by SSH
    Delete an ACL Rule
    [Teardown]    upload result to testlink    G-CPE-300

G-CPE-301 : Verify SSH access by WAN IP from WAN side
    [Tags]    @AUTHOR=Frank_Hung
    Create ACL SSH rule cannot be in Disable state, select WAN for Access Control, Source IP is WAN PC IP
    Verify WAN PC can access DUT WAN IP by SSH
    Delete an ACL Rule
    [Teardown]    upload result to testlink    G-CPE-301

**** comments ****

Case.FN23SV001 Verify Telnet access by LAN IP from LAN side
    [Tags]    @AUTHOR=Frank_Hung
    Enable Telent Service
    Create ACL TELNET rule cannot be in Disable state
    Verify LAN PC can access DUT by Telent

Case.FN23SV002 Verify Telnet access by WAN IP from LAN side
    [Tags]    @AUTHOR=Frank_Hung
    Create ACL TELNET rule cannot be in Disable state, select WAN for Access Control
    Verify LAN PC can access DUT WAN IP by Telent

Case.FN23SV003 Verify Telnet access by WAN IP from WAN side
    [Tags]    @AUTHOR=Frank_Hung
    Create ACL TELNET rule cannot be in Disable state, select WAN for Access Control, Source IP is WAN PC IP
    Verify WAN PC can access DUT WAN IP by Telent

*** Keywords ***
