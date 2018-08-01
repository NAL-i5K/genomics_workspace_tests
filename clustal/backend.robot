*** Settings ***
Suite Setup
Resource          ../resource.txt

*** Variables ***
${url}    ${url_prefix}/clustal

*** Test Cases ***
valid_query
    [Documentation]    Use sample sequence to run clustalo
    [Setup]    Open and Max Browser    ${url}    ${browser}
    Go To    ${url}
    Click Element    class=load-nucleotide
    Search and Confirm Submitted
    Wait Results
    Sleep    10s
    [Teardown]    Close All Browsers

upload_file
    [Documentation]    Query by uploading sample file
    [Setup]    Open and Max Browser    ${url}    ${browser}
    Go To    ${url}
    Choose File    xpath=//input[@name="query-file" and @class="query-file"]    ${CURDIR}${/}sample.fa
    Search
    Wait Results
    Sleep    10s
   [Teardown]    Close All Browsers

*** Keywords ***

Search
    Click Button    id=clustalo_submit

Search and Confirm Submitted
    Search
    Wait Until Page Contains    Query Submitted

Wait Results
    [Documentation]
    Wait Until Element is Visible    clustal-success    timeout=90s
    Should Not Have JS Errors
