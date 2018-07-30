*** Settings ***
Suite Setup
Resource          ../resource.txt

*** Variables ***
@{win_titles}
${xpath_num_organism}    //div[@id="box-organism"]/label

*** Test Cases ***
valid_query
    [Documentation]    Use sample sequence to query 2 databases and confirm the jbrowse link works
    [Setup]    Open and Max Browser    ${url}    ${browser}
    Go To    ${url}
    Choose Database    # Send sample query
    Click Element    xpath=//*/span[contains(@class, "load-nucleotide")]
    Mouse Over    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "ceratitis-capitata")]
    Search and Confirm
    Wait Results
    Click Element    //*[@id="results-table"]/tbody/tr[1]/td[1]/a    # Click JBrowse btn and comfirm
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
    Search and Confirm
    Wait Until Page Contains    No Hits Found    timeout=30s
    [Teardown]    Close All Browsers

upload_file
    [Documentation]    Query by uploading sample file
    [Setup]    Open and Max Browser    ${url}    ${browser}
    Go To    ${url}
    Choose Database    # Send sample query
    Choose File    xpath=//input[@name="query-file" and @class="query-file"]    ${CURDIR}${/}sample.txt
    Mouse Over    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "ceratitis-capitata")]
    Search and Confirm
    Wait Results
    Click Element    //*[@id="results-table"]/tbody/tr[3]/td[1]/a    # Click JBrowse btn and comfirm
    Sleep    10s
   [Teardown]    Close All Browsers

test_back_button
    [Documentation]    Click back button of browser after querying, and the organisms should be displayed normally (check the number of organism labels)
    [Setup]    Open and Max Browser    ${url}    ${browser}
    Go To    ${url}
    ${total_organism}=     Get Matching Xpath Count    ${xpath_num_organism}
    Choose Database    # Send sample query
    Click Element    xpath=//*/span[contains(@class, "load-nucleotide")]
    Mouse Over    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "ceratitis-capitata")]
    Search and Confirm
    Wait Results
    Go Back
    Sleep    2s
    Xpath Should Match X Times    ${xpath_num_organism}    ${total_organism}
    [Teardown]    Close All Browsers

*** Keywords ***
Confirm Jbrowse
    Wait Until Element is Visible    xpath=//*[@id="label_BLAST+ Results"]
    Wait Until Element is Visible    xpath=//*[@id="track_BLAST+ Results"]//div[@class="feature-name"]

Choose Database
    Select CheckBox    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "anoplophora-glabripennis")]
    Select CheckBox    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "ceratitis-capitata")]

Search and Confirm
    Click Button    xpath=//*/div[@id="buttons"]/input[contains(@value, "Search")]
    Wait Until Page Contains    Query Submitted

Wait Results
    [Documentation]
    Wait Until Element is Visible    xpath=//*[@id="results-table_info" and contains(., "entries")]    timeout=90s
    Should Not Have JS Errors
