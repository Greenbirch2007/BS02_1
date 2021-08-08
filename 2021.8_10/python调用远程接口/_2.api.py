# 三、使用requests模块实现post方式调用远程接口
# 使用post方式调用远程接口主要使用了requests模块的post方法
#
# requests.post()
# post方法常见的参数有url,data和headers
#
# url：表示远程接口的地址
# data：表示post参数
# headers：表示post传参的headers参数信息
# 使用requests模块实现post方式调用远程接口的简单实现如下

# -*- coding:utf-8 -*-

import requests
import ast
#接口地址
url = 'XXX'
#header信息
headers = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization': 'Bearer XXX'
}

#post传参

data ={
    "nicename":"1111",
    "gender":1,
    "city":"ce",
    "avatar":"111"
}

r = requests.post(url, data=data,headers=headers)
# 接口返回的状态码
print(r.status_code)
# 接口返回的字符串内容
content = r.text
# #将字符串转字典型
content_list = ast.literal_eval(content)
print(content_list)
# 接口返回的json格式内容
print(r.json())