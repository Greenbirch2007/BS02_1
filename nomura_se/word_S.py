#! -*- coding:utf-8 -*-
import datetime
import time

import pymysql
import requests
from lxml import etree
from selenium import webdriver
import pyautogui

import datetime
import re
import string
import time


# 读取页面文本
# 按照标题，保存整个文本





import csv
import datetime

import os
import re
import time
import sys
import xlrd
import pymysql
import xlrd
import requests
from requests.exceptions import RequestException
from lxml import etree
import  pandas  as pd

import pymysql

import csv
import datetime
import numpy as np


import os
import re
import time
import sys

sys.getfilesystemencoding()
import pymysql
import xlrd






def writerDt_csv(headers, rowsdata):
    # rowsdata列表中的数据元组,也可以是字典数据
    with open('sc_jsIndex.csv', 'w', newline='') as f:
        f_csv = csv.writer(f)
        f_csv.writerow(headers)
        f_csv.writerows(rowsdata)


def read_xlrd(excelFile):
    data = xlrd.open_workbook(excelFile)
    table = data.sheet_by_index(0)
    dataFile = []
    for rowNum in range(table.nrows):
        dataFile.append(table.row_values(rowNum))

    # # if 去掉表头
    # if rowNum > 0:

    return dataFile
driver = webdriver.Chrome()


def page_request(url):
    ''' 发送请求获取数据 '''
    driver.get(url)
    html = driver.page_source
    return html

def page_parse_(html):
    '''根据页面内容使用lxml解析数据, 获取段子列表'''



    element = etree.HTML(html)

    title = element.xpath('//*[@id="main"]/article/section/dl/dt/text()')
    type = element.xpath('//*[@id="main"]/article/section/dl/dd/i/text()')
    content = element.xpath('//*[@id="main"]/article/section/dl/dd/div/p/text()')
    for i1,i2,i3 in zip(title,type,content):

        big_list.append((i1,i2,i3))





def writerDt_csv(headers, rowsdata):
    # rowsdata列表中的数据元组,也可以是字典数据
    with open('sc_jsIndex.csv', 'w', newline='') as f:
        f_csv = csv.writer(f)
        f_csv.writerow(headers)
        f_csv.writerows(rowsdata)


def read_xlrd(excelFile):
    data = xlrd.open_workbook(excelFile)
    table = data.sheet_by_index(0)
    dataFile = []
    for rowNum in range(table.nrows):
        dataFile.append(table.row_values(rowNum))

    # # if 去掉表头
    # if rowNum > 0:

    return dataFile























def insertDB(content):
    connection = pymysql.connect(host='127.0.0.1', port=3306, user='root', password='123456', db='NOW_',
                                 charset='utf8mb4', cursorclass=pymysql.cursors.DictCursor)

    cursor = connection.cursor()
    try:


        cursor.executemany('insert into nomura_w (title,type_,content) values (%s,%s,%s)', content)
        connection.commit()
        connection.close()
        print('向MySQL中添加数据成功！')
    except TypeError :
        pass



if __name__ == '__main__':

    




    data = pd.read_excel("s.xlsx")
    data = data.values
    for item in data.tolist():
        big_list = []
        html = page_request(item[0])
        page_parse_(html)
        insertDB(big_list)












# title,type_,content

# create table nomura_w
# (id int not null primary key auto_increment,
# title text,
# type_ text,
#  content text)
# engine=InnoDB  charset=utf8;


# drop table YoMiKaKe;