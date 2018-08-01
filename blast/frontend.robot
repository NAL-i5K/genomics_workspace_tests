*** Settings ***
Suite Setup       Open and Max Browser    ${url}    ${browser}
Suite Teardown    Close All Browsers
Resource          ../resource.txt

*** Variables ***
${url}    ${url_prefix}/blast

*** Test Cases ***
organism_empty_false_check
    [Documentation]    After choosing organisms, mouse over on 'All organisms', sanity check will be triggered incorrectly
    Go To    ${url}
    Select CheckBox    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "anoplophora-glabripennis")]
    Select CheckBox    xpath=//*[@id="box-organism"]/*/div/input[contains(@organism, "ceratitis-capitata")]
    Mouse Over    xpath=//*[@id="box-organism"]/*/div[contains(@organism, "all")]
    Click Button    xpath=//*/div[@id="buttons"]/input[contains(@value, "Search")]
    Page Should Not Contain    Please choose the type of databases
    Page Should Contain    No sequence found!

uncheck_all_organisms
    [Documentation]    checking and unchecking "all organisms" should be done in at most 30 seconds in FF, otherwise indicates serious performance javascript issues
    Go To    ${url}
    Mouse Over    xpath=//*[@id="box-organism"]/*/div[contains(@organism, "all")]
    Click Element    class:all-organism-checkbox
    Click Element    class:all-organism-checkbox
    Click Element    class:all-organism-checkbox
    Click Element    class:all-organism-checkbox
