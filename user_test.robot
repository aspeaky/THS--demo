*** Settings ***
Resource          model.robot
Library           requests
Library           RequestsLibrary
Library           json
Library           Collections
Library           DateTime

*** Test Cases ***
test1
    [Setup]    start
    testfor    5
    ${c}    add    3    5
    log    ${c}
    Comment    end
    ${aa}=    Create List    a    b    c
    ${a}=    Get Length    ${aa}
    Should Contain    ${aa}    a
    ${dingkaizhai}    Set Variable    112
    Should Be Equal    ${dingkaizhai}    112
    [Teardown]    end

formal_定期理财_2.0
    Create Session    dqlc    http://fund.10jqka.com.cn/publicapi
    ${resp}=    Get Request    dqlc    /huaweiFundList/dqlc.txt
    ${dict}    Set Variable    ${resp.json()}
    ${time-normal}    Evaluate    datetime.date.today()-datetime.timedelta(days=1)    datetime
    ${time-QIDD}    Evaluate    datetime.date.today()-datetime.timedelta(days=2)    datetime
    ${time-normal}    Convert To String    ${time-normal}
    log    定期理财
    ${other}    Create List
    ${normal-find}=    Create List
    : FOR    ${one}    IN    @{dict}
    \    Run Keyword If    '${one['date']}'==''    Remove Values From List    ${dict}    ${one}
    \    Run Keyword If    '${time-normal}'=='${one['date']}'    Insert Into List    ${normal-find}    0    ${one}
    \    Run Keyword If    '${time-normal}'!='${one['date']}'    Insert Into List    ${other}    0    ${one}
    \    Comment    ${EMPTY}
    \    ...    ELSE    Set List Value    ${M}    ${one}
    ${other-length}    Get Length    ${other}
    : FOR    ${var}    IN    @{other}
    \    log    ${var['fundCode']}
    \    log    ${var['date']}
    : FOR    ${one}    IN    @{normal-find}
    \    Should Be Equal    ${one['date']}    ${time-normal}
    log    ${other-length}
    Comment    ${one['date']} is string and ${time-normal}is date
    ${other-length}    Convert To String    ${other-length}
    Should Be Equal    ${other-length}    20

formal_货币型_2.0
    Create Session    dqlc    http://fund.10jqka.com.cn/publicapi
    ${resp}=    Get Request    dqlc    /huaweiFundList/hbx.txt
    ${dict}    Set Variable    ${resp.json()}
    ${time-normal}    Evaluate    datetime.date.today()-datetime.timedelta(days=1)    datetime
    ${time-QIDD}    Evaluate    datetime.date.today()-datetime.timedelta(days=2)    datetime
    ${time-normal}    Convert To String    ${time-normal}
    log    货币型
    ${other}    Create List
    ${normal-find}=    Create List
    : FOR    ${one}    IN    @{dict}
    \    Run Keyword If    '${one['date']}'==''    Remove Values From List    ${dict}    ${one}
    \    Run Keyword If    '${time-normal}'=='${one['date']}'    Insert Into List    ${normal-find}    0    ${one}
    \    Run Keyword If    '${time-normal}'!='${one['date']}'    Insert Into List    ${other}    0    ${one}
    \    Comment    ${EMPTY}
    \    ...    ELSE    Set List Value    ${M}    ${one}
    ${other-length}    Get Length    ${other}
    : FOR    ${var}    IN    @{other}
    \    log    ${var['fundCode']}
    \    log    ${var['date']}
    : FOR    ${one}    IN    @{normal-find}
    \    Should Be Equal    ${one['date']}    ${time-normal}
    log    ${other-length}
    Comment    ${one['date']} is string and ${time-normal}is date
    ${other-length}    Convert To String    ${other-length}
    Should Be Equal    ${other-length}    22

formal_余下所有基金_2.0
    Create Session    dqlc    http://fund.10jqka.com.cn/publicapi
    ${resp}=    Get Request    dqlc    /huaweiFundList/all.txt
    ${dict}    Set Variable    ${resp.json()}
    ${time-normal}    Evaluate    datetime.date.today()-datetime.timedelta(days=1)    datetime
    Comment    QDII减2天，定开债减7天，封闭式减3天
    ${time-QDII}    Evaluate    datetime.date.today()-datetime.timedelta(days=2)    datetime
    ${time-closed}    Evaluate    datetime.date.today()-datetime.timedelta(days=3)    datetime
    ${time-dingkaizhai}    Evaluate    datetime.date.today()-datetime.timedelta(days=7)    datetime
    ${time-normal}    Convert To String    ${time-normal}
    log    余下所有基金
    ${other}    Create List
    ${normal-find}=    Create List
    ${normal-closed}    Create List
    ${normal-dingkaizhai}    Create List
    ${normal-QDII}    Create List
    : FOR    ${one}    IN    @{dict}
    \    Run Keyword If    '${one['date']}'==''    Remove Values From List    ${dict}    ${one}
    \    Run Keyword If    '${time-normal}'=='${one['date']}'    Insert Into List    ${normal-find}    0    ${one}
    \    Run Keyword If    '${time-normal}'!='${one['date']}'    Insert Into List    ${other}    0    ${one}
    \    Comment    ${EMPTY}
    \    ...    ELSE    Set List Value    ${M}    ${one}
    : FOR    ${one}    IN    @{other}
    \    Run Keyword If    '${time-QDII}'=='${one['date']}'    Insert Into List    ${normal-QDII}    0    ${one}
    \    Run Keyword If    '${time-QDII}'=='${one['date']}'    Remove Values From List    ${other}    ${one}
    \    Run Keyword If    '${time-closed}'=='${one['date']}'    Insert Into List    ${normal-closed}    0    ${one}
    \    Run Keyword If    '${time-closed}'=='${one['date']}'    Remove Values From List    ${other}    ${one}
    \    Run Keyword If    '${time-dingkaizhai}'=='${one['date']}'    Insert Into List    ${normal-dingkaizhai}    0    ${one}
    \    Run Keyword If    '${time-dingkaizhai}'=='${one['date']}'    Remove Values From List    ${other}    ${one}
    ${other-length}    Get Length    ${other}
    ${normal-closed-length}    Get Length    ${normal-closed}
    ${normal-QDII-length}    Get Length    ${normal-QDII}
    ${normal-dingkaizhai-length}    Get Length    ${normal-dingkaizhai}
    : FOR    ${var}    IN    @{other}
    \    log    ${var['fundCode']}
    \    log    ${var['date']}
    Comment    :FOR    ${one}    IN    @{normal-find}
    Comment    \    Should Be Equal    ${one['date']}    ${time-normal}
    Comment    \    log    ${other-length}
    Comment    ${one['date']} is string and ${time-normal}is date
    : FOR    ${var}    IN    @{normal-QDII}
    \    log    ${var['fundCode']}
    \    log    ${var['date']}
    ${other-length}    Convert To String    ${other-length}
    ${normal-closed-length}    Convert To String    ${normal-closed-length}
    ${normal-QDII-length}    Convert To String    ${normal-QDII-length}
    ${normal-dingkaizhai-length}    Convert To String    ${normal-dingkaizhai-length}
    Should Be Equal    ${other-length}    846
    Should Be Equal    ${normal-closed-length}    28
    Should Be Equal    ${normal-QDII-length}    222
    Should Be Equal    ${normal-dingkaizhai-length}    2

*** Keywords ***
start
    log    the cese is start

end
    log    the case is end
    ${log}=    Set Variable    ${TEST_MESSAGE}
    ${xinxi}=    Set Variable    ${TEST_STATUS}
    ${message}    Catenate    ${log}    ${xinxi}
    log    ${xinxi}
    log    okko
    ${data}    Create Dictionary    title=爱基金行情接口自动化    id=whw is best    mails=luchendong@myhexin.com,xuanqianping@myhexin.com,wengjianxiang@myhexin.com,liuwei@myhexin.com,shaoxuli@myhexin.com    content=${message}
    ${resp}    requests.Post    http://testfund.10jqka.com.cn/nodetest/notice/sendspecialmail    ${data}    #headers=${header}
