*** Settings ***
Library           Selenium2Library
Library           Collections

*** Test Cases ***
众邦银行
    #定义手机型号
    ${devname}    Create Dictionary    deviceName=Galaxy S5
    #${mobile_emulation}    Create Dictionary    mobileEmulation=${devname}
    #设置模拟器信息
    ${chromeoptions}=    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()    sys, selenium.webdriver.chrome.options
    # ${chromeoptions._experimental_options}    Set Variable    ${mobile_emulation}
    Call Method    ${chromeoptions}    add_experimental_option    mobileEmulation    ${devname}
    #以设置的模拟信息driver游览器
    Create Webdriver    Chrome    chrome_options=${chromeoptions}
    #打开H5相应的URL
    Go To    https://trade.5ifund.com:8443/app/zbank/dist/detail$485fbd.html?code=THS_20181122&type=2
    sleep    5s
    Maximize Browser Window
    Click Button    xpath=.//*[@id='app']/div/div/button[2]
    sleep    5s
    Input Text    xpath=//*[@id="app"]/div/section/p[1]/div/input    100
    Click Button    xpath=.//*[@id='app']/div/button
    Sleep    5s
    Input Text    xpath=//*[@id="app"]/div/div[2]/div[1]/section/div/p[2]/input    123456
    Click Button    xpath=//*[@id="app"]/div/div[2]/div[1]/section/div/button

蓝海银行
    phone    https://trade.5ifund.com:8443/app/zbank/dist/detail$485fbd.html?code=THS_20181122&type=2

普通模式测试
    Open Browser    https://www.baidu.com    chrome
    Maximize Browser Window
    Input Text    kw    ss
    Click Element    su    #点击搜索框
    sleep    3
    Click Element    xpath=.//*[@id='1']/h3/a[1]    #选择第一个页面
    #获取窗口的title
    ${titles2}    Get Window Titles
    ${titles2}    Get From List    ${titles}    1
    ${titles1}    Get From List    ${titles}    0
    Log    ${titles}
    log    ${titles2}
    log    ${titles1}
    #切换到第二个窗口
    Select Window    title=${titles2}
    #切换回第一个窗口，即搜索页面的那个窗口
    Select Window    title=${sleeptitles1}

钱包测试
    phone    https://trade.5ifund.com:8443/app/tc/dist/wallet.html#/
    Sleep    3s
    Input Text    xpath=/html/body/div[1]/p[2]/input    100110014090
    Input Password    xpath=/html/body/div[1]/p[3]/input    12345678
    Click Button    xpath=/html/body/div[1]/button[1]
    Sleep    5s
    ${aaa}=     Get Text    xpath=//*[@id="app"]/section/div/div/div/section[2]/header/h1
    log    {aaa}
    log    ok
    Should Be Equal    ${aaa}    35983.98

值获取
    phone    https://www.baidu.com
    Sleep    3s
    ${a}=    Get Value    xpath=//*[@id="index-bn"]
    log     ${a}
    Comment    Should Be Equal    ${a}    '百度一下‘
    log    heool

1
    ${a}=    Set Variable    1
    ${b}=    Set Variable    hello
    log    ${a}
    log    ${b}

*** Keywords ***
phone
    [Arguments]    @{address}
    [Documentation]    让网页以手机的模式来启动
    #定义手机型号
    ${devname}    Create Dictionary    deviceName=Galaxy S5
    #${mobile_emulation}    Create Dictionary    mobileEmulation=${devname}
    #设置模拟器信息
    ${chromeoptions}=    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()    sys, selenium.webdriver.chrome.options
    # ${chromeoptions._experimental_options}    Set Variable    ${mobile_emulation}
    Call Method    ${chromeoptions}    add_experimental_option    mobileEmulation    ${devname}
    #以设置的模拟信息driver游览器
    Create Webdriver    Chrome    chrome_options=${chromeoptions}
    #打开H5相应的URL
    Go To    @{address}
    sleep    5s
