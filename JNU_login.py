def JNU_login(user, password):
    """
    自动登录暨南大学教务处
    :param user: 学号
    :param password: 密码
    :return: 在手动验证码之后，会自动弹出一个登录后的浏览器界面
    """
    from os import environ
    from selenium import webdriver
    chromedriver = "/usr/local/bin/chromedriver"
    environ['webdriver.chrome.driver'] = chromedriver
    driver = webdriver.Chrome(chromedriver)
    driver.get('https://jwxt.jnu.edu.cn/')
    driver.implicitly_wait(3)
    account = driver.find_element_by_xpath('//*[@id="txtYHBS"]')
    passwd = driver.find_element_by_xpath('//*[@id="txtYHMM"]')
    account.send_keys(user)
    passwd.send_keys(password)
    valid = driver.find_element_by_xpath('//*[@id="txtFJM"]')
    ma = input(">请自行输入验证码：")
    valid.send_keys(ma)
    login = driver.find_element_by_xpath('//*[@id="btnLogin"]')
    login.click()
    driver.close()

