*** Settings ***
Library           JSONLibrary
Library           os
Library           Collections

*** Test Cases ***
Testcase1
    ${jsonfile}=    load json from file    ${CURDIR}\\json_file.json
    ${get_email}=    Get Value From Json    ${jsonfile}    $.data.email
    log to console    ${get_email[0]}
    should be equal    ${get_email[0]}    janet.weaver@reqres.in

Testcase2
    ${jsonfile}=    load json from file    ${CURDIR}\\json_list.json
    ${get_email}=    Get Value From Json    ${jsonfile}    $.data[1].email
    log to console    ${get_email[0]}
    should be equal    ${get_email[0]}    janet.weaver@reqres.in
