*** Settings ***
Library    SeleniumLibrary

Suite Setup     Open Browser     https://www.amazon.com     Chrome
Suite Teardown   Close Browser


*** Test Cases ***

Book search from Amazon website
    [Documentation]     This test case searches a book from Amazon website
    Open Amazon website
    Search books    Exploratory testing
    Verify Search Results Text    Exploratory testing
    Verify book title found    Explore It!: Reduce Risk and Increase Confidence with Exploratory Testing
    Scroll to Footer
    Verify Get To Know Us Text
    Hover Over Back to Top button
    Click Back to Top button
    

*** Keywords *** 
Open Amazon website
    Go To   https://www.amazon.com

Search books
    [Arguments]    ${search_term}
    Input Text      id=twotabsearchtextbox     ${search_term}
    Press Keys      id=twotabsearchtextbox     RETURN

Verify Search Results Text
    [Arguments]    ${search_term}
    ${page_contains_results}=    Run Keyword And Return Status    Wait Until Page Contains    results for "${search_term}"
    ${results_element_exists}=    Run Keyword And Return Status    Page Should Contain    results for "${search_term}"
    IF    ${page_contains_results}==True and ${results_element_exists}==True
        Log    Search results for "${search_term}" found
    ELSE
        Fail    Search results for "${search_term}" not found
    END

Verify book title found
    [Arguments]    ${book_title}
    ${elements}=    Get WebElements    xpath=//*[contains(text(), '${book_title}')]
    ${element_count}=    Get Length    ${elements}
    IF    ${element_count} > 0
        Scroll Element Into View    ${elements}[0]
        Capture Page Screenshot
    ELSE    
        Fail    Book: '${book_title}' not found
    END


Scroll to Footer
    Scroll Element Into View     xpath=//*[@id="navFooter"]

Verify Get To Know Us Text
    ${page_contains_get_to_know_us}=    Run Keyword And Return Status    Wait Until Page Contains    Get to Know Us
    ${get_to_know_us_element_exists}=    Run Keyword And Return Status    Page Should Contain    Get to Know Us
    Run Keyword If    '${get_to_know_us_element_exists}' == 'True'    Log    Get to Know Us text found    ELSE    Log    ERROR: Get to Know Us text not found


Hover Over Back to Top button
    Mouse Over    xpath=//*[@id="navBackToTop"]

Click Back to Top button
    Click Element    xpath=//*[@id="navBackToTop"]


