
import datetime
import time

import pymysql
import requests
from lxml import etree
import json
from queue import Queue
import threading
from requests.exceptions import RequestException
from retrying import retry


from selenium.common.exceptions import WebDriverException

from retrying import retry
import datetime
import re
import time

import pymysql
import requests
from lxml import etree
from requests.exceptions import RequestException
from lxml import etree
from selenium import webdriver

def selenium_headless(url):
    print(url)

    ch_options = webdriver.ChromeOptions()
    # 为Chrome配置无头模式
    ch_options.add_argument("--headless")
    ch_options.add_argument('--no-sandbox')
    ch_options.add_argument('--disable-gpu')
    ch_options.add_argument('--disable-dev-shm-usage')
    # 在启动浏览器时加入配置
    driver = webdriver.Chrome(options=ch_options)

    driver.get(url)

    time.sleep(0.1)
    current_url = driver.current_url
    print(current_url)
    html = driver.page_source
    print(html)
    driver.quit()

url = "http://jond.co.kr"
selenium_headless(url)


