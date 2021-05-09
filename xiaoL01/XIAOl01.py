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

# 初始化
# 先实例化 login_manager 对象，然后用它来初始化应用：

from flask import Flask
from flask_login import LoginManager
# ...
app = Flask(__name__)  # 创建 Flask 应用

app.secret_key = 'abc'  # 设置表单交互密钥

login_manager = LoginManager()  # 实例化登录管理对象
login_manager.init_app(app)  # 初始化应用
login_manager.login_view = 'login'  # 设置用户登录视图函数 endpoint
# 表单交互时，所以要设置 secret_key，以防跨域攻击（ CSRF ）
# 登录管理对象 login_manager 的 login_view 属性，指定登录页面的视图函数 (登录页面的 endpoint)，即验证失败时要跳转的页面，这里设置为登录页


# 用户模块
# 用户数据
# 要做用户验证，需要维护用户记录，为了方便演示，使用一个全局列表 USERS 来记录用户信息，并且初始化了两个用户信息：

from werkzeug.security import generate_password_hash
# ...
USERS = [
    {
        "id": 1,
        "name": 'lily',
        "password": generate_password_hash('123')
    },
    {
        "id": 2,
        "name": 'tom',
        "password": generate_password_hash('123')
    }
]

# 用户信息只包含最基本的信息：
#
# name 为登录用户名
# password 为登录密码，切忌：无论如何不要在系统中存放用户密码的明文，幸运的是模块 werkzeug.security 提供了 generate_password_hash 方法，使用 sha256 加密算法将字符串变为密文
# id 为用户识别码，相当于主键
# 基于用户信息，定义两方法，用来创建( create_user )和获取( get_user )用户信息:


# 用户模块
# 用户数据
# 要做用户验证，需要维护用户记录，为了方便演示，使用一个全局列表 USERS 来记录用户信息，并且初始化了两个用户信息：

from werkzeug.security import generate_password_hash
# ...
USERS = [
    {
        "id": 1,
        "name": 'lily',
        "password": generate_password_hash('123')
    },
    {
        "id": 2,
        "name": 'tom',
        "password": generate_password_hash('123')
    }
]

# 用户信息只包含最基本的信息：
#
# name 为登录用户名
# password 为登录密码，切忌：无论如何不要在系统中存放用户密码的明文，幸运的是模块 werkzeug.security 提供了 generate_password_hash 方法，使用 sha256 加密算法将字符串变为密文
# id 为用户识别码，相当于主键
# 基于用户信息，定义两方法，用来创建( create_user )和获取( get_user )用户信息:

# 用户类
# 下面创建一个用户类，类维护用户的登录状态，是生成 Session 的基础，Flask-Login 提供了用户基类 UserMixin，方便定义自己的用户类，我们定义一个 User：

from flask_login import UserMixin  # 引入用户基类
from werkzeug.security import check_password_hash
# ...
class User(UserMixin):
    """用户类"""
    def __init__(self, user):
        self.username = user.get("name")
        self.password_hash = user.get("password")
        self.id = user.get("id")

    def verify_password(self, password):
        """密码验证"""
        if self.password_hash is None:
            return False
        return check_password_hash(self.password_hash, password)

    def get_id(self):
        """获取用户ID"""
        return self.id

    @staticmethod
    def get(user_id):
        """根据用户ID获取用户实体，为 login_user 方法提供支持"""
        if not user_id:
            return None
        for user in USERS:
            if user.get('id') == user_id:
                return User(user)
        return None
# 实例化方法接受一个用户记录，即 USERS 列表中的一个元素，用来初始化成员变量
# get_id 方法返回用户实例的 ID，这是必须实现的，不然 Flask-Login 将无法判断用户是否被验证
# get 是个静态方法，即可以通过类之间调用，是为了在获取验证后的用户实例时用的，必须接受参数 ID，返回 ID 所以对应的用户实例
# verify_password 方法接受一个明文密码，与用户实例中的密码做校验，将被用在用户验证的判断逻辑中



# 用户类
# 下面创建一个用户类，类维护用户的登录状态，是生成 Session 的基础，Flask-Login 提供了用户基类 UserMixin，方便定义自己的用户类，我们定义一个 User：

from flask_login import UserMixin  # 引入用户基类
from werkzeug.security import check_password_hash
# ...
class User(UserMixin):
    """用户类"""
    def __init__(self, user):
        self.username = user.get("name")
        self.password_hash = user.get("password")
        self.id = user.get("id")

    def verify_password(self, password):
        """密码验证"""
        if self.password_hash is None:
            return False
        return check_password_hash(self.password_hash, password)

    def get_id(self):
        """获取用户ID"""
        return self.id

    @staticmethod
    def get(user_id):
        """根据用户ID获取用户实体，为 login_user 方法提供支持"""
        if not user_id:
            return None
        for user in USERS:
            if user.get('id') == user_id:
                return User(user)
        return None
# 实例化方法接受一个用户记录，即 USERS 列表中的一个元素，用来初始化成员变量
# get_id 方法返回用户实例的 ID，这是必须实现的，不然 Flask-Login 将无法判断用户是否被验证
# get 是个静态方法，即可以通过类之间调用，是为了在获取验证后的用户实例时用的，必须接受参数 ID，返回 ID 所以对应的用户实例
# verify_password 方法接受一个明文密码，与用户实例中的密码做校验，将被用在用户验证的判断逻辑中

# 后台
# 根据前面介绍的 Form 相关知识 (参见 Web 开发 Form )，需要定义一个 Form 类，用来设置页面的元素和规则:

from wtforms import StringField, PasswordField
from wtforms.validators import DataRequired, EqualTo
# ...
# class LoginForm(FlaskForm):
#     """登录表单类"""
#     username = StringField('用户名', validators=[DataRequired()])
#     password = PasswordField('密码', validators=[DataRequired()])
# 定义用户名和密码两个字段，分别是字符类型字段和密码类型字段，密码类型字段会在页面上显示为密码形式，以提高安全性
# 为两个字段设置必填规则
# 然后定义一个用户登录的视图函数 login:
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



