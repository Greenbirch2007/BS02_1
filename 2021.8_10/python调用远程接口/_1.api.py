
#
# 二、使用requests模块实现get方式调用远程接口
# 使用get方式调用远程接口主要使用了requests模块的get方法
#
# requests.get()
# get方法常见的参数有url,params和headers
#
# url：表示远程接口的地址
#
# params表示get参数
#
# headers表示get传参的headers参数信息
#
# 使用requests模块实现get方式调用远程接口的简单实现如下

# get方法

import requests

import ast

# 接口地址

url = 'http://127.0.0.1:5000/jsin'

#get传参
data = {'type':"00"}
# data ='jsin'
#headers信息

headers = {
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization': 'Bearer XXX'
}

res = requests.get(url,params=data,headers=headers)

# 接口返回的状态码

print(res.status_code)

# 接口返回的字符串内容

content = res.text

# 将字符串转字典形  str---->dict

print(content)


content_list= ast.literal_eval(content)
print(content_list)
# 接口返回的json格式内容


print(res.json())