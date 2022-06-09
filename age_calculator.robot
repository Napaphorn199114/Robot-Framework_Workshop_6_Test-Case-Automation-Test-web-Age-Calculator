*** Settings ***
Library    Selenium2Library

*** Variables ***
${url}    http://qa-engineer-exercise.azurewebsites.net/
${browser}    Chrome
${Calculate Button}    css=body > div > main > form > div:nth-child(2) > input
${Home Button}    //a[@class="navbar-brand"]
${Input}    id=Birthday
${Display Result}    //h1[@class="display-4"]


*** Keywords ***
Calculate Button
    Click Element    ${Calculate Button}
Home Button
    Click Element    ${Home Button}



*** Test Cases ***

Open Browser
    Open Browser    ${url}    ${browser}
    Maximize Browser Window  #ขยายเต็มจอ
    Set Selenium Speed    0.3    #ทำให้เปิดหน้าเว็บช้าลง

Age_01 User input valid birthday should work fine
    Input Text    ${Input}    02/02/2010                                       #input Ex.02/02/2010
    Calculate Button                                                           #Calculate Button
    ${result}    Get Text    ${Display Result}                                 #result เก็บค่า ที่แสดงบนจอ
    Should Contain    ${result}    You're 12                                   #เปรียบเทียบผลลัพธ์  ...recheck
    Page Should Contain    You're 12                                           # หน้านี้ต้องเป็น You're 12 ...recheck
    Should Be Equal    ${result}    You're 12                                  #เปรียบเทียบผลลัพธ์  ...recheck
    Log To Console    \n${result}\n
    Home Button                                                                # กลับหน้า Home

Age_02 Verify content on the page should display correctly
    ${title name}    Get Title
    Should Contain    ${title name}    Age Calculator Demo                     #เปรียบเทียบ title name
    Log To Console    \n${title name}\n
    Page Should Contain    Enter Your Birthday
    Page Should Contain    Your birthday won't be stored or shared with anyone.
    Page Should Contain Element    ${Calculate Button}

Age_03 The customer put birthday with TH language
    Input Text    ${Input}    1-มี.ค.-10
    Calculate Button
    ${result}    Get Text    ${Display Result}                                 #result เก็บค่า ที่แสดงบนจอ
    Should Contain    ${result}    The string '1-มี.ค.-10' was not recognized as a valid DateTime. There is an unknown word starting at index '2'.
    Home Button

Age_04 The customer put birthday with invalid more than a day should error
    Input Text    ${Input}    32/01/2010
    Calculate Button
    ${result}    Get Text    ${Display Result}                                 #result เก็บค่า ที่แสดงบนจอ
    Should Contain    ${result}    String '32/01/2010' was not recognized as a valid DateTime.
    Home Button   

Age_05 The customer put birthday with invalid deduct day should error
    Input Text    ${Input}    -1/01/2010
    Calculate Button
    ${result}    Get Text    ${Display Result}                                 #result เก็บค่า ที่แสดงบนจอ
    Should Contain    ${result}    String '-1/01/2010' was not recognized as a valid DateTime.
    Home Button

Age_06 The customer put birthday with a valid day should work fine
    Input Text    ${Input}    31/01/2010
    Calculate Button
    ${result}    Get Text    ${Display Result}                                 #result เก็บค่า ที่แสดงบนจอ
    Should Contain    ${result}    You're 12
    Home Button

Age_07 The customer put birthday with invalid month should error
    Input Text    ${Input}    01/13/2010
    Calculate Button
    ${result}    Get Text    ${Display Result}                                 #result เก็บค่า ที่แสดงบนจอ
    Should Contain    ${result}    String '01/13/2010' was not recognized as a valid DateTime.
    Home Button

Age_08 The customer put birthday with invalid deduction month should error
    Input Text    ${Input}    1/-99/2010
    Calculate Button
    ${result}    Get Text    ${Display Result}                                 #result เก็บค่า ที่แสดงบนจอ
    Should Contain    ${result}    String '1/-99/2010' was not recognized as a valid DateTime.
    Home Button

Age_09 The customer put birthday with a valid month should work fine
    Input Text    ${Input}    12/12/2012
    Calculate Button
    ${result}    Get Text    ${Display Result}                                 #result เก็บค่า ที่แสดงบนจอ
    Should Contain    ${result}    You're 9
    Home Button

Age_10 The customer put birthday with the invalid year should error
    Input Text    ${Input}    12/12/2030
    Calculate Button
    ${result}    Get Text    ${Display Result}                                 #result เก็บค่า ที่แสดงบนจอ
    Should Contain    ${result}    String '12/12/2030' was not recognized as a valid DateTime.
    Home Button
    #Age_10 FAIL web is show result You're -9 