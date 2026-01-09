*** Settings ***
Resource    ../base.robot
Library    OperatingSystem
Force Tags    @Function=Somke_Test    @AUTHOR=Frank_Hung    @FEATURE=Function
Resource    ../../keyword/kw_Basic_WAN.robot
Resource    ../../keyword/kw_Application.robot
*** Variables ***

*** Test Cases ***

Reset DUT
    [Tags]    @AUTHOR=Frank_Hung
    Login and Reset Default DUT        ${URL}    ${DUT_Password}

Case.FN23US006 Enable Anonymous Access
    [Tags]    @AUTHOR=Frank_Hung
    Go to Storage Service > User Accounts Page, Enable the Enable Anonymous Access option
    Verify the Current Account Table will add and display the "anonymous" user name
    Go to Storage Service > User Accounts Page, Disable the Enable Anonymous Access option
    Verify the Current Account Table will delete the "anonymous" user name

Case.FN23US007 Check Create process and GUI
    [Tags]    @AUTHOR=Frank_Hung
    User Accounts Page, Do not enter any values in all fields and click Apply Change, Verify An error message should be display
    Input User Name and click Apply Change, Verify error message should be displaye
    Input User Name, Password and Click Apply Change, Verify error message should be displaye
    Input User Name, Password, Confirm Password and Click Apply Change, Verify the account was successfully created and added to the table
    Add repeated User name again, Verify Cannot repeated user name

Case.FN23US008 Create a new User account
    [Tags]    @AUTHOR=Frank_Hung
    Go to Share Folder page, Check Owner Field, verify the Owner field will display the name of the created account
    Click Apply Change, verify the folder was successfully created and added to the table

Case.FN23US009 Delete a User account
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Delete a User account, Verify accout will be deleted to the table
    Go to Share Folder page, Check Owner Field, Verify the Owner field becomes empty
    Check Share Folder Table, Verify The Share folder will be deleted from the table

Case.FN23US010 Create Share Folder and Enable Samba Server
    [Tags]    @AUTHOR=Frank_Hung    testing2
    Login GUI    ${URL}    ${DUT_Password}
    Open User Accounts Page
    Input User Name, Password, Confirm Password and Click Apply Change, Verify the account was successfully created and added to the table
    Go to Share Folder page, Check Owner Field, verify the Owner field will display the name of the created account
    Click Apply Change, verify the folder was successfully created and added to the table
    Enable Samba Service on DUT
    Verify LAN PC can access USB Storage via Samba server

Case.FN23US011 Create Share Folder and Disable Samba Server
    [Tags]    @AUTHOR=Frank_Hung
    Disable Samba Service on DUT
    Verify LAN PC cannot access USB Storage via Samba server

Case.FN23US012 Delete Share Folder
    [Tags]    @AUTHOR=Frank_Hung
    Delete Share Folder, Verify The Share folder will be deleted from the table

Case.FN23US013 FTP > LAN PC Client Access
    [Tags]    @AUTHOR=Frank_Hung
    Go to Share Folder page, Check Owner Field, verify the Owner field will display the name of the created account
    Click Apply Change, verify the folder was successfully created and added to the table
    Enable FTP Service on DUT
    Verify LAN PC can access USB Storage via FTP

Case.FN23US014 FTP > WAN PC Client Access
    [Tags]    @AUTHOR=Frank_Hung
    Verify WAN PC can access USB Storage via FTP

Case.FN23US015 FTP > Download File From Server
    [Tags]    @AUTHOR=Frank_Hung
    Verify LAN PC should download file successful

Case.FN23US016 FTP > Upload File to Server
    [Tags]    @AUTHOR=Frank_Hung
    Verify LAN PC should Upload file successful

Case.FN23US017 FTP > Multi-client Access
    [Tags]    @AUTHOR=Frank_Hung
    Verify WAN PC can access USB Storage via FTP
    Verify LAN PC can access USB Storage via FTP

Case.FN23US019 FTP > Download large size file
    [Tags]    @AUTHOR=Frank_Hung
    Verify LAN PC can download 1 GigaBytes file from USB Storage via FTP

Case.FN23US021 FTP > Reboot DUT
    [Tags]    @AUTHOR=Frank_Hung
    Reboot DUT from GUI    ${URL}    ${DUT_Password}
    Verify LAN PC can access USB Storage via FTP

Case.FN23US022 FTP > Change LAN side IP
    [Tags]    @AUTHOR=Frank_Hung
    Change DUT LAN side IP and DHCP server IP
    LAN PC Renew IP
    Verify LAN PC can access USB Storage via FTP after chang LAN IP
    sleep    1
    [Teardown]    Change DUT LAN side IP to Default

Case.FN23US023 FTP > LAN PC Client Access
    [Tags]    @AUTHOR=Frank_Hung
    Enable Samba Service on DUT
    Verify LAN PC can access USB Storage via FTP

Case.FN23US024 FTP > WAN PC Client Access
    [Tags]    @AUTHOR=Frank_Hung
    Verify WAN PC can access USB Storage via FTP

**** comments ****

*** Keywords ***
