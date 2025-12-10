*** Settings ***
Resource    ../base.robot
Library    Selenium2Library
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN.robot
Resource    ../../keyword/kw_HomePage.robot
Resource    ../../keyword/kw_testlink.robot

*** Variables ***

*** Test Cases ***

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

G-CPE-272 : Internet Status
    [Tags]    @AUTHOR=Frank_Hung
    Login GUI    ${URL}    ${DUT_Password}
    Verify Internet Status should be up
    [Teardown]    upload result to testlink    G-CPE-272

G-CPE-275 : Internet Address
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Internet Address should be 172.16.11.x
    [Teardown]    upload result to testlink    G-CPE-275

G-CPE-273 : Online device list
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Number of Online device lists should greater than 1
    [Teardown]    upload result to testlink    G-CPE-273

G-CPE-274 : Protocol
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Default Protocol of WAN Port should be DHCP
    Setup WAN mode to Static IP mode
    Verify the Protocol of WAN Port should be Static
    Setup WAN mode to PPPoE mode
    Verify the Protocol of WAN Port should be PPPoE
    [Teardown]    upload result to testlink    G-CPE-274

G-CPE-276 : Primary DNS
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Primary DNS should be 168.95.1.1
    [Teardown]    upload result to testlink    G-CPE-276

G-CPE-277 : Secondary DNS
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Setup WAN mode to Static IP mode
    Verify the Secondary DNS should be 8.8.8.8
    [Teardown]    upload result to testlink    G-CPE-277

G-CPE-278 : MacAddress
    [Tags]    @AUTHOR=Frank_Hung
    Verify the MacAddress should not be Empty
    [Teardown]    upload result to testlink    G-CPE-278

G-CPE-267 : Manufacture
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Manufacturer should be Gemtek Technology Co.
    [Teardown]    upload result to testlink    G-CPE-267

G-CPE-268 : Serial Number
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Serial Number should Not be Empty
    [Teardown]    upload result to testlink    G-CPE-268

G-CPE-269 : Firmware Version
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Firmware Version should Not be Empty
    [Teardown]    upload result to testlink    G-CPE-269

G-CPE-270 : Model Name
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Model Name should be    ${Product_Name}
    [Teardown]    upload result to testlink    G-CPE-270

G-CPE-271 : Hardware Version
    [Tags]    @AUTHOR=Frank_Hung
    Verify the Hardware Version should Not be Empty
    [Teardown]    upload result to testlink    G-CPE-271

G-CPE-279 : WAN interface
    [Tags]    @AUTHOR=Frank_Hung
    Verify the WAN Port should be Active
    [Teardown]    upload result to testlink    G-CPE-279

G-CPE-280 : LAN interface 1
    [Tags]    @AUTHOR=Frank_Hung
    Verify the LAN1 Port should be Inactive
    [Teardown]    upload result to testlink    G-CPE-280

G-CPE-281 : LAN interface 2
    [Tags]    @AUTHOR=Frank_Hung
    Verify the LAN2 Port should be Inactive
    [Teardown]    upload result to testlink    G-CPE-281

G-CPE-282 : LAN interface 3
    [Tags]    @AUTHOR=Frank_Hung
    Verify the LAN3 Port should be Active
    [Teardown]    upload result to testlink    G-CPE-282

G-CPE-283 : LAN interface 4
    [Tags]    @AUTHOR=Frank_Hung
    Verify the LAN4 Port should be Active
    Close Browser
    [Teardown]    upload result to testlink    G-CPE-283

*** Keywords ***
