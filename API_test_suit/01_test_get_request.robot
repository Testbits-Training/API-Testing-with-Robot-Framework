*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections

*** Variables ***
${base_url}       https://reqres.in/

*** Test Cases ***
Get Request Single User
    create session    API_testing    ${base_url}
    ${get_respond}=    get on session    API_testing    url=/api/users/2
    log to console    ${get_respond.status_code}
    log to console    ${get_respond.content}
    log to console    ${get_respond.headers}
    ${status_code}    convert to string    ${get_respond.status_code}
    should be equal    ${status_code}    200
    ${body}    convert to string    ${get_respond.content}
    should contain    ${body}    Janet
    #${hearder_contenttypevalue}=    get from dictionary    ${get_respond.headers}    Content-Type
    #should be equal    ${hearder_contenttypevalue}    application/json; charset=utf-8
