# 程振兴 2018年6月14日
"""
用于下载微信推文中的图片、动图等
需要的包有：
    urllib
    requests
    BeautifulSoup
    ssl
    time
    os         
    re
"""

def downpic(url, foldername = "下载结果"):
    """
    用于下载微信推文中的图片、动图等。
    :param url: 必填链接，指定需要下载图片的链接；
    :param foldername: 默认为"mytest"，可以不指定；
    :return: 无返回值，但是该程序运行之后会下载得到一个图片文件夹。
    示例：
        downpic("https://mp.weixin.qq.com/s/Pw3lzQpS7Lk8hXXse1TezA")
        downpic(url = "https://mp.weixin.qq.com/s?__biz=MzA5NjIzNjgxNw=="
              "&mid=2653071676&idx=5&sn=81cc83ae876b5012027086f469"
              "74d63a&chksm=8b652d42bc12a45412303e83813a8011b76b21"
              "6429a7ddaf5678b3d305deb8259d9367fa4e83&mpshare=1&sce"
              "ne=1&srcid=06148NGZ2TXpPnSmkmQ9ynCc#rd", foldername = 'mytest')
    """
    # 第一个包是根据文件链接下载文件的
    from urllib.request import urlretrieve
    # 第二个包是打开链接的
    from urllib.request import urlopen
    # BeautifulSoup包是解析网页结构的
    from bs4 import BeautifulSoup
    # ssl包用于全局取消证书验证。
    import ssl
    ssl._create_default_https_context = ssl._create_unverified_context
    # time包用于生成动图字符串（用时间作为字符串）
    import time
    # re包用于正则表达式
    import re
    # 创建文件夹
    import os
    print("开始爬取=============================================>")
    def mkdir(path):
        folder = os.path.exists(path)
        if not folder:  # 判断是否存在文件夹如果不存在则创建为文件夹
            os.makedirs(path)  # makedirs 创建文件时如果路径不存在会创建这个路径
            print("---  创建新文件夹...  ---")
            print("---  创建完成  ---")
        else:
            print("---  文件夹已存在！ ---")
    # 创建文件夹的名称
    file = foldername
    # 创建文件夹
    mkdir(file)
    # 纪录下当前的工作目录的路径
    cwd = os.getcwd()
    # 设定刚刚创建的文件夹为工作目录
    os.chdir(file)
    # 开始获取图片链接
    html = urlopen(url)
    bsObj = BeautifulSoup(html, "html.parser")
    # 图片链接都在img标签中
    imagelocation = bsObj.findAll("img")
    # 创建一个list用于存储图片链接
    linklist = []
    for link in imagelocation:
        if 'fmt' in str(link):
            linklist.append(link.attrs['data-src'])
    # 下载图片
    i = 1
    for link in linklist:
        format = re.findall(r"fmt=(.*)", link)
        local_time = time.strftime("%Y%m%d%H%M%S", time.localtime())
        filename = local_time + '_' +str(i) + '.' + format[0]
        urlretrieve(link, filename)
        print("已下载完第%d张" % i )
        i = i + 1
    i = i - 1
    print("一共下载了%d张图片，下载已完成" % i)
    # 回到上一级工作目录
    os.chdir(cwd)

# downpic("https://mp.weixin.qq.com/s/Pw3lzQpS7Lk8hXXse1TezA")
# downpic(url = "https://mp.weixin.qq.com/s?__biz=MzA5NjIzNjgxNw=="
#               "&mid=2653071676&idx=5&sn=81cc83ae876b5012027086f469"
#               "74d63a&chksm=8b652d42bc12a45412303e83813a8011b76b21"
#               "6429a7ddaf5678b3d305deb8259d9367fa4e83&mpshare=1&sce"
#               "ne=1&srcid=06148NGZ2TXpPnSmkmQ9ynCc#rd", foldername = 'mytest')