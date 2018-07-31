*** Settings ***
Suite Setup
Resource          ../resource.txt

*** Variables ***
@{win_titles}
${xpath_num_organism}    //div[@id="box-organism"]/label

*** Test Cases ***
valid_query
    [Documentation]    Use sample sequence to query 2 databases
    [Setup]    Open and Max Browser    ${url}    ${browser}
    Go To    ${url}
    Choose Database    # Send sample query
    Click Element    xpath=//*/span[contains(@class, "load-example-seq")]
    Mouse Over    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "ceratitis-capitata")]
    Search and Confirm Submitted
    Wait Results
    Sleep    10s
    [Teardown]    Close All Browsers

no_hits_query
    [Documentation]    Use 'abc123' to query 2 databases and confirm no hits
    [Setup]    Open and Max Browser    ${url}    ${browser}
    Go To    ${url}
    Set Selenium Speed    .1 seconds
    Choose Database    # Send sample query
    Input Text    id=query-textarea    abc123
    Mouse Over    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "ceratitis-capitata")]
    Search
    Wait Until Page Contains    Invalid Query    timeout=30s
    [Teardown]    Close All Browsers

upload_file
    [Documentation]    Query by uploading sample file
    [Setup]    Open and Max Browser    ${url}    ${browser}
    Go To    ${url}
    Choose Database    # Send sample query
    Choose File    xpath=//input[@name="query-file" and @class="query-file"]    ${CURDIR}${/}sample.fa
    Mouse Over    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "ceratitis-capitata")]
    Search
    Wait Results
    Sleep    10s
   [Teardown]    Close All Browsers

*** Keywords ***

Choose Database
    Select CheckBox    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "anoplophora-glabripennis")]
    Select CheckBox    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "ceratitis-capitata")]

Search
    Click Button    id=hmmer_submit

Search and Confirm Submitted
    Search
    Wait Until Page Contains    Query Submitted

Wait Results
    [Documentation]
    Wait Until Element is Visible    hmmer-success    timeout=90s
    Should Not Have JS Errors
