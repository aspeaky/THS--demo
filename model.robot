*** Keywords ***
testfor
    [Arguments]    ${times}
    : FOR    ${i}    IN RANGE    ${times}
    \    log    ${i}

add
    [Arguments]    ${a}    ${b}
    ${c}    Evaluate    ${a}+${b}
    [Return]    ${c}

Test_Setup
