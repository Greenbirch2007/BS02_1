#!/usr/bin/python

# -*- coding:utf8 -*-

# 
import time

import pyecharts.options as opts
from pyecharts.charts import Line
import os
import xlrd
import sys
from xlrd import xldate_as_tuple
import datetime

# 读取xlxs数据
# 数据处理整理
# 测试
# 可以部署到服务器上面！彻底解放人力！

"""
Gallery 使用 pyecharts 1.1.0
参考地址: https://www.echartsjs.com/examples/editor.html?c=line-log

目前无法实现的功能:

1、暂无
"""

from shutil import copyfile

# ! -*- coding:utf-8 -*-
import json
from flask import Flask, jsonify, render_template
from flask_sqlalchemy import SQLAlchemy
# from sqlalchemy import Column, Integer, String, Text
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
import copy
import operator

app = Flask(__name__)


@app.route('/header')
def _header():
    return render_template('header.html')  # 在一个目录下,templates中


@app.route('/login')
def _login():
    return render_template('login.html')  # 在一个目录下,templates中


@app.route('/')
def index():
    return "<h1>欢迎来到主页</h1>"

def read_xlrd(excelFile):
    data = xlrd.open_workbook(excelFile)
    table = data.sheet_by_index(0)
    dataFile = []
    for rowNum in range(table.nrows):
        dataFile.append(table.row_values(rowNum))

    # # if 去掉表头
    # if rowNum > 0:

    return dataFile


def text_save(filename, data):  # filename为写入CSV文件的路径，data为要写入数据列表.
    file = open(filename, 'a')
    for i in range(len(data)):
        s = str(data[i]).replace('[', '').replace(']', '')  # 去除[],这两行按数据不同，可以选择
        s = s.replace("'", '').replace(',', '') + '\n'  # 去除单引号，逗号，每行末尾追加换行符
        file.write(s)
    file.close()
    print("保存文件成功")


# 时间日期的转换



if __name__ == "__main__":

    # 等待5秒钟，然后将文件移动到templates目录下

    app.run(debug=True)



