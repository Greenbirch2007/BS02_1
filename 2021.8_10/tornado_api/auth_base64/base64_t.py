

import base64


#  object -----object_utf-8-------object-base64
#          object.encode("utf-8")---base64.b64encode(obe)
#  obe= object.encode("utf-8")


# 想将字符串转编码成base64,要先将字符串转换成二进制数据
url = "tg-last:test"
bytes_url = url.encode("utf-8")
str_url = base64.b64encode(bytes_url)  # 被编码的参数必须是二进制数据
print(str_url)


# base64_object------>str
#url = "dGVzdA=="
# Basic cm9vdDpyb290     cm9vdDpyb290  ---> root:root
# Basic dGVzdDAwMToxMjMONTY=       dGVzdDAwMToxMjMONTY=--->   test001:12356----->

#Basic dGctbGFzdDp0ZXN0------>tg-last:test


# 先在postman的Authorization 中设置 Username:tg_last    Password:test
# 然后再在Headers中添加 KEY:Authorization    VALUE: Basic dGctbGFzdDp0ZXN0

url = "dGctbGFzdDp0ZXN0"
str_url = base64.b64decode(url).decode("utf-8")
print(str_url)
# 
# 
# # s


# !/usr/bin/env python
# encoding=utf-8

import sys, os, time
import functools


# def authenticated(f):
#     @functools.wraps(f)
#     def wrapper(self, *args, **kwargs):
#         if self.get_current_user() == "admin":
#             f(self, *args, **kwargs)
#         else:
#             raise Exception("404")
#
#     return wrapper
#
#
# class Test(object):
#     def __init__(self):
#         self.current_user = None
#
#     @authenticated
#     def hello(self):
#         print("Hello %s" % self.get_current_user())
#
#
#     def get_current_user(self):
#         return self.current_user
#
#     def set_current_user(self, user):
#         self.current_user = user
#
#
# if __name__ == '__main__':
#     t = Test()
#     t.set_current_user("admin")
#     t.hello()
#     t.set_current_user("me")
#     t.hello()
#

