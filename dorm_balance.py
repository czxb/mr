def dorm_balance(dormid = "T30332"):
    """
    查询暨南大学各个宿舍的账户余额
    :param dormid: 宿舍号，默认为我的宿舍，T30332
    :return: 宿舍的账户余额
    示例：
        dorm_balance("T30332")
        dorm_balance("T30333")
    """
    from selenium import webdriver
    from os import environ
    chromedriver = "/usr/local/bin/chromedriver"
    environ['webdriver.chrome.driver'] = chromedriver
    driver = webdriver.Chrome(chromedriver)
    driver.get('http://10.136.2.5/JNUWeb/')
    driver.implicitly_wait(3)
    account = driver.find_element_by_xpath('//*[@id="login-userName11"]')
    passwd = driver.find_element_by_xpath('//*[@id="login-password"]')
    account.send_keys(dormid)
    passwd.send_keys(dormid)
    login = driver.find_element_by_xpath('//*[@id="loginBtn"]')
    login.click()
    balance = driver.find_element_by_xpath('//*[@id="messagebox-1001-displayfield-inputEl"]/span[1]').text
    print(dormid, "宿舍的账户余额为：", balance)
    driver.close()
    return balance
