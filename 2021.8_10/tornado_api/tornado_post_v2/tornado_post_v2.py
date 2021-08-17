

#! -*-coding:utf-8 -*-
import base64
import datetime
import tornado.ioloop
import tornado.web
from tornado.escape import json_decode, json_encode

import time
import json


import base64
import inspect
from functools import wraps


def basic_auth(auth_func=lambda *args, **kwargs: True):
    def auth(handler, kwargs):
        def create_auth_header(handler):
            handler.set_status(401)
            handler.set_header('WWW-Authenticate', 'Basic realm=Restricted')
            handler._transforms = []
            handler.finish()

        auth_header = handler.request.headers.get('Authorization')
        if auth_header is None or not auth_header.startswith('Basic '):
            create_auth_header(handler)
            return False
        else:
            auth_decoded = base64.b64decode(auth_header[6:]).decode()
            user, pwd = auth_decoded.split(':', 2)

            if auth_func(user, pwd):
                return True
            else:
                create_auth_header(handler)
                return False

    def basic_auth_decorator(handler_obj):
        if inspect.isfunction(handler_obj):
            @wraps(handler_obj)
            def wrap_func(self, *xargs, **kwargs):
                if auth(self, kwargs):
                    handler_obj(self, *xargs, **kwargs)
            return wrap_func
        else:
            @wraps(handler_obj)
            def wrap_execute(handler_execute):
                async def _execute(self, *args, **kwargs):
                    if auth(self, kwargs):
                        await handler_execute(self, *args, **kwargs)
                return _execute
            handler_obj._execute = wrap_execute(handler_obj._execute)
            return handler_obj

    return basic_auth_decorator


def basic_auth_valid(user, pwd):
    try:

        result= {
            "username": "tg_last",
            "password": "test"
        }



        # server username,password
        username=result['username']
        password=result['password']
        if user==username and pwd == password:
            return True
        else:
            return False
    except Exception as e:
        return False












# post-header----auth----true---->
@basic_auth(basic_auth_valid)
class MainHandler(tornado.web.RequestHandler):

    def post(self, *args, **kwargs):
        global body_data
        '''
        用户登录
        post -> /login/
        payload:
            {
                "user_id": "tg_last",
                "password": "密码"
            }
        '''
# test-----base64---->dGVzdA==
#
# 授权还是非常适合写一个装饰器！ 稍微研究一下

        try:
            # from client receive info json------>object
            body_data = tornado.escape.json_decode(self.request.body)



            # Authorization: Basic base64("user:passwd")
            auth_header = self.request.headers.get('Authorization', None)
            print("before  auth_header---> ", auth_header)
            if auth_header is not None:
                # Basic Zm9vOmJhcg==
                auth_mode, auth_base64 = auth_header.split(' ', 1)
                assert auth_mode == 'Basic'
                # Zm9vOmJhcg解码
                auth_info = base64.b64decode(auth_base64)
                # byte转str
                auth_username, auth_password = auth_info.decode('utf-8').split(":")
                print("after auth_header------->",auth_username, auth_password)

                response = {}
                _f_date_ = datetime.datetime.now().date()
                _f_time_ = datetime.datetime.now().time()
                response["meta"] = {"version": 1, "date": "{0}".format(_f_date_.strftime("%Y-%m-%d"))}
                response["info"] = {"time": "{0}".format(_f_time_.strftime("%H:%M:%S")), "result": [
                    {"A": 0.2},
                    {"B": 0.3},
                    {"C": 0.5},
                ]}

                response["login_info"] = body_data
                response = json.dumps(response)

                # response_str =json.load(response)
                # print(response_str["login_info"])
                self.write(response)
                print(response, type(response))
            else:
                pass




            print("post success")
        except BaseException:
            result = {
                "eror": 400,
                "timestamp": int
            }

            self.write(json.dumps(result, ensure_ascii=False))


def make_app():
    return tornado.web.Application([
        (r"/",MainHandler)
    ])

#  postman body -----># {"auth_test":"v1","user_id":"tg_last","passwd":"test~~"}
#  postman Headers Authorization: Basic dGctbGFzdDp0ZXN0
# postman Authorization  username:tg_last password:test




if __name__=="__main__":
    app = make_app()
    app.listen(8989)
    tornado.ioloop.IOLoop.current().start()