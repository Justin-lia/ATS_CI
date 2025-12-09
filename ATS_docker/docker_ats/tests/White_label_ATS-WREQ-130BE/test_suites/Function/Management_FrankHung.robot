*** Settings ***
#Test Setup       Open Browseras Login Page
#Test Teardown    Close Browser
#Suite Setup    Turn OFF LAN PC Network Interface
#Suite Setup    Open Web GUI    ${URL_AP/WB}
#Suite Teardown    Close Browser
Force Tags    @Function=Somke_Test    @AUTHOR=FrankHung    @FEATURE=Function
Resource    ../base.robot
Resource    ../../keyword/kw_Basic_WAN_FrankHung.robot
Resource    ../../keyword/kw_Management_FrankHung.robot
Resource    ../../keyword/kw_testlink_FrankHung.robot
#Resource    ../../keyword/white_label_Variable_Yannis.robot
Resource    ../../keyword/Variable.robot
Library           Collections
Library           DateTime
Library           String
Library           OperatingSystem
#Library           AutoItLibrary

*** Test Cases ***


Default DUT
    [Tags]    @AUTHOR=FrankHung
    Run    echo 'vagrant' | sudo -S netplan apply
    sleep    4
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

G-CPE-290 : Access Control Passwords admin account
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Account Managementment page
    Change the admin's password    admin    12345678
    Reboot the DUT
    Login to DUT with new password than set admin's password to admin
    [Teardown]    upload result to testlink    G-CPE-290

G-CPE-291 : Access Control_Passwords_admin account with incorrect old password
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Account Managementment page
    Change the admin's password with incorrect old password
    Verify the password can not be change and an error message appears
    [Teardown]    upload result to testlink    G-CPE-291

G-CPE-292 : Confirm whether the password meets the restrictions
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Account Managementment page
    Change the admin's password with correct old password
    Enter New Password include other special character or wron format
    Verify password can not be change and an error message appears
    [Teardown]    upload result to testlink    G-CPE-292

G-CPE-293 : Dfault time zone
     [Tags]    @AUTHOR=FrankHung    consoleTag
    Config DUT system time zone to (GTM+8) from GUI
    Verify on DUT console, DUT default system time(GMT+8) should match current time(GMT+8)
    [Teardown]    upload result to testlink    G-CPE-293

G-CPE-294 : Change time zone
    [Tags]    @AUTHOR=FrankHung    consoleTag
    Set DUT Time zone to GTM+10 on NTP Page
    Verify on DUT console, DUT default system time(GMT+10) should match current time(GMT+10)
    [Teardown]    upload result to testlink    G-CPE-294

G-CPE-182 : Protocol type: IPv4, Interface LAN, Verify that ping without Internet Connection
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Ping Diagnosis page
    On GUI Select Interface LAN
    Enter desination address: IP Address of LAN PC, Click "Start to Ping"
    Verify ping result should success
    [Teardown]    upload result to testlink    G-CPE-182

G-CPE-183 : Protocol type: IPv4, Interface LAN Verify that ping destination by IP Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Ping Diagnosis page
    On GUI Select Interface LAN
    Enter desination address: 8.8.8.8, Click "Start to Ping"
    Verify ping result should success
    [Teardown]    upload result to testlink    G-CPE-183

G-CPE-184 : Protocol type: IPv4, Interface WAN Verify that ping without Internet Connection
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Ping Diagnosis page
    On GUI Select Interface WAN
    Enter desination address: IP Address of LAN PC, Click "Start to Ping"
    Verify ping result should success
    [Teardown]    upload result to testlink    G-CPE-184

G-CPE-185 : Protocol type: IPv4, Interface WAN Verify that ping destination by IP Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Ping Diagnosis page
    On GUI Select Interface WAN
    Enter desination address: 8.8.8.8, Click "Start to Ping"
    Verify ping result should success
    [Teardown]    upload result to testlink    G-CPE-185

G-CPE-186 : Protocol type: IPv6, Interface LAN/WLAN Verify that ping without Internet Connection
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Ping Diagnosis page
    On GUI Select Interface LAN
    On GUI Select Protocol IPv6
    Enter desination address: 2001:1234:5678:9ABC::1, Click "Start to Ping"
    Verify ping result should success
    [Teardown]    upload result to testlink    G-CPE-186

G-CPE-187 : Protocol type: IPv6, Interface LAN/WLAN Verify that ping destination by IP Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Ping Diagnosis page
    On GUI Select Interface WAN
    On GUI Select Protocol IPv6
    Enter desination address: 2001:1234:5678:9ABC::1, Click "Start to Ping"
    Verify ping result should success
    [Teardown]    upload result to testlink    G-CPE-187

G-CPE-188 : Protocol type: IPv4, Interface LAN Verify that traceroute
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Trace Route Diagnosis page
    Setup [Interface Selection] to LAN
    Input 8.8.8.8 to [Target Address]
    Click "Start to Traceroute" Button and Verify Result is [traceroute to 8.8.8.8]
    [Teardown]    upload result to testlink    G-CPE-188


G-CPE-189 : Protocol type: IPv4, Interface WAN Verify that traceroute
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Trace Route Diagnosis page
    Setup [Interface Selection] to WAN
    Input www.google.com to [Target Address]
    Click "Start to Traceroute" Button and Verify Result is traceroute to www.google.com
    [Teardown]    upload result to testlink    G-CPE-189

G-CPE-190 : Protocol type: IPv6, Interface LAN Verify that traceroute
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Trace Route Diagnosis page
    Setup [Interface Selection] to LAN
    Select Protocol Type to IPv6
    Input 2001:1234:5678:9ABC::1 to [Target Address]
    Click "Start to Traceroute" Button and Verify Result is traceroute to 2001:1234:5678:9ABC::1
    [Teardown]    upload result to testlink    G-CPE-190

G-CPE-191 : Protocol type: IPv6, Interface WAN Verify that traceroute
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Trace Route Diagnosis page
    Setup [Interface Selection] to WAN
    Select Protocol Type to IPv6
    Input 2001:1234:5678:9ABC::1 to [Target Address]
    Click "Start to Traceroute" Button and Verify Result is traceroute to 2001:1234:5678:9ABC::1
    [Teardown]    upload result to testlink    G-CPE-191

G-CPE-192 : Protocol type: IPv4, Interface LAN Verify that DNS lookup by URL Address
    [Tags]    @AUTHOR=FrankHung    testing2
    Login GUI    ${URL}    ${DUT_Password}
    Open DNS Diagnosis page
    Setup [Interface Selection] to LAN on DNS Diagnosis Page
    Input www.google.com to [Target Address] on DNS Diagnosis Page
    Click "Start" Button and Verify Result is Return a IP represents to URL
    [Teardown]    upload result to testlink    G-CPE-192

G-CPE-193 : Protocol type: IPv4, Interface WAN Verify that DNS lookup by URL Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open DNS Diagnosis page
    Setup [Interface Selection] to WAN on DNS Diagnosis Page
    Input www.google.com to [Target Address] on DNS Diagnosis Page
    Click "Start" Button and Verify Result is Return a IP represents to URL
    [Teardown]    upload result to testlink    G-CPE-193

G-CPE-194 : Protocol type: IPv4, Interface LAN Verify that DNS lookup by IP Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open DNS Diagnosis page
    Setup [Interface Selection] to LAN on DNS Diagnosis Page
    Input 8.8.8.8 to [Target Address] on DNS Diagnosis Page
    Click "Start" Button and Verify Result is Return 8.8.8.8.in-addr.arpa name = dns.google
    [Teardown]    upload result to testlink    G-CPE-194

G-CPE-195 : Protocol type: IPv4, Interface WAN Verify that DNS lookup by IP Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open DNS Diagnosis page
    Setup [Interface Selection] to WAN on DNS Diagnosis Page
    Input 8.8.8.8 to [Target Address] on DNS Diagnosis Page
    Click "Start" Button and Verify Result is Return 8.8.8.8.in-addr.arpa name = dns.google
    [Teardown]    upload result to testlink    G-CPE-195


G-CPE-196 : Protocol type: IPv6, Interface LAN Verify that DNS lookup by URL Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open DNS Diagnosis page
    Setup [Interface Selection] to LAN on DNS Diagnosis Page
    Select Protocol Type to IPv6 on DNS Diagnosis page
    Input www.google.com to [Target Address] on DNS Diagnosis Page
    Click "Start" Button and Verify Return a IP represents to URL
    [Teardown]    upload result to testlink    G-CPE-196

G-CPE-197 : Protocol type: IPv6, Interface WAN Verify that DNS lookup by URL Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open DNS Diagnosis page
    Setup [Interface Selection] to WAN on DNS Diagnosis Page
    Select Protocol Type to IPv6 on DNS Diagnosis page
    Input www.google.com to [Target Address] on DNS Diagnosis Page
    Click "Start" Button and Verify Return a IP represents to URL
    [Teardown]    upload result to testlink    G-CPE-197

G-CPE-198 : Protocol type: IPv6, Interface LAN Verify that DNS lookup by IP Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open DNS Diagnosis page
    Setup [Interface Selection] to LAN on DNS Diagnosis Page
    Select Protocol Type to IPv6 on DNS Diagnosis page
    Input 2001:4860:4860::8888 to [Target Address] on DNS Diagnosis Page
    Click "Start" Button and Verify Return a URL represents to IP
    [Teardown]    upload result to testlink    G-CPE-198

G-CPE-199 : Protocol type: IPv6, Interface WAN Verify that DNS lookup by IP Address
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open DNS Diagnosis page
    Setup [Interface Selection] to WAN on DNS Diagnosis Page
    Select Protocol Type to IPv6 on DNS Diagnosis page
    Input 2001:4860:4860::8888 to [Target Address] on DNS Diagnosis Page
    Click "Start" Button and Verify Return a URL represents to IP
    [Teardown]    upload result to testlink    G-CPE-199

G-CPE-284 : Reboot Device
    [Tags]    @AUTHOR=FrankHung
    Login GUI    ${URL}    ${DUT_Password}
    Open Reboot Page
    Click Reboot Button
    Verify GUI show Rebooting message
    LAN PC ping DUT LAN IP should ping Fail
    [Teardown]    upload result to testlink and Wait 180 seconds, Verify GUI show Login Page    G-CPE-284





***Keywords***
upload result to testlink and Wait 180 seconds, Verify GUI show Login Page
    [Arguments]    ${testCaseID}
    upload result to testlink    ${testCaseID}
    Wait 180 seconds, Verify GUI show Login Page
