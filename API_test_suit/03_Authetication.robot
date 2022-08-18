*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary
Library           os
Library           Collections

*** Variables ***
${base_url}       https://reqres.in/
${base_url2}      https://certtransaction.elementexpress.com
${bearertoken}    E4F284BFADA11D01A52508ED7B92FFD7EE0905659F5DED06A4B73FC7739B48A287648801

*** Test Cases ***
BasicAuthTest
    ${auth}=    create list    Admintest    admin123
    create session    API_testing    ${base_url}    auth=${auth}
    ${response}=    get on session    API_testing    url=/authentication/CheckForAuthentication
    log to console    ${response.content}

BearerAuthTest
    create session    bearertoken    ${base_url2}
    ${header}    create dictionary    Authorization=${bearertoken}    Content-Type=text/xml
    ${req_body}=    get file
    ${post_req}=    post request    bearertoken    /    data=${req_body}    hearders=${header}
