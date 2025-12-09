*** Settings ***


*** Variables ***


*** Keywords ***
upload result to testlink
    [Arguments]    ${testcaseexternalid}
    No Operation
#    Run Keyword If Test Passed    Keyword for upload result to testlink    ${testcaseexternalid}    p
#    Run Keyword If Test Failed    Keyword for upload result to testlink    ${testcaseexternalid}    f

Keyword for upload result to testlink
    [Arguments]    ${testcaseexternalid}    ${test_result}
    pytestlink.open_testlink_connection    testlink_url=${testlink_url}    testlink_key=${testlink_key}
    ${result}=    pytestlink.upload_result_to_testlink    testcaseexternalid=${testcaseexternalid}    platformid=${platformid}    testplanid=${testplanid}    buildid=${buildid}    test_result=${test_result}
    [Return]    ${result}

