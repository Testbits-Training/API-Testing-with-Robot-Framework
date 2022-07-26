*** Settings ***
Test Setup        create session    API_testing    ${base_url}
Library           RequestsLibrary
Library           JSONLibrary
Library           os
Library           Collections

*** Variables ***
${base_url}       https://reqres.in/

*** Test Cases ***
Get Request and Validation single user
    ${get_respond}=    get on session    API_testing    url=/api/users/2
    ${json_respond}=    set variable    ${get_respond.json()}
    @{fn_json_data}    get value from json    ${json_respond}    data.first_name
    log to console    @{fn_json_data}
    should be equal    @{fn_json_data}    Janet

Get Request and Validation list users
    ${get_respond_11}=    get on session    API_testing    url=/api/users?page=2
    ${json_respond}=    to json    ${get_respond_11.content}
    ${json_value}=    get value from json    ${json_respond}    $.data[0].email
    log to console    ${json_value[0]}
    should be equal    ${json_value[0]}    michael.lawson@reqres.in

Post request student
    ${body2}=    create dictionary    name=morpheus    job=leader
    ${header2}=    create dictionary    Content-Type=application/json
    ${post_response2}=    Post Request    API_testing    url=/api/users    data=${body2}    headers=${header2}
    log to console    ${post_response2.status_code}
    log to console    ${post_response2.content}
    ${status_code2}    convert to string    ${post_response2.status_code}
    #If those user already exist, status code is 200
    should be equal    ${status_code2}    201

Put request student
    ${body3}=    create dictionary    name=morpheus    job=leaderExecutive
    ${header3}=    create dictionary    Content-Type=application/json
    ${put_response3}=    Put request    API_testing    /api/users/2    data=${body3}    headers=${header3}
    log to console    ${put_response3.status_code}
    log to console    ${put_response3.content}
    ${status_code3}    convert to string    ${put_response3.status_code}
    should be equal    ${status_code3}    200
    ${body3}    convert to string    ${put_response3.content}
    should contain    ${body3}    leaderExecutive

Delete request student
    ${delete_response4}=    delete request    API_testing    url=/api/users/2
    log to console    ${delete_response4.status_code}
    ${status_code4}    convert to string    ${delete_response4.status_code}
    should be equal    ${status_code4}    204

Header Validation
    ${get_header}=    get on session    API testing    url=/api/users/2
    log to console    ${get_header.headers}
