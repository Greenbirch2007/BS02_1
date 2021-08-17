#! -*-coding:utf-8 -*-
import base64
import datetime
import tornado.ioloop
import tornado.web
from tornado.escape import json_decode, json_encode

import time
import json



# post-header----auth----true---->
class MainHandler(tornado.web.RequestHandler):

    def post(self, *args, **kwargs):
        global auth_username, auth_password
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
            # body_data = tornado.escape.json_decode(self.request.body)
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

            if auth_username == "tg_last" and auth_password == "test":
                 response = {}
                 _f_date_ = datetime.datetime.now().date()
                 _f_time_ = datetime.datetime.now().time()
                 response["meta"] = {"version": 1, "date": "{0}".format(_f_date_.strftime("%Y-%m-%d"))}
                 response["info"] = {"time": "{0}".format(_f_time_.strftime("%H:%M:%S")), "result": [
                     {"A": 0.2},
                     {"B": 0.3},
                     {"C": 0.5},
                 ]}

                 response = json.dumps(response)

                 self.write(response)
                 print(response, type(response))

            else:
                _401_error = {
                    "error_code": 401,
                    "error_content": "401 Unauthorized"
                }
                self.write("{0}".format(_401_error))


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

#  postman body -----># {"user_id": "tg_last", "Passwd": "{{passwd}}"}

#  postman Pre-request-script

# const passwd = CryptoJS.enc.Utf8.parse("test")
# const base64_passwd = CryptoJS.enc.Base64.stringify(passwd)
# pm.globals.set("Passwd",base64_passwd);




if __name__=="__main__":
    app = make_app()
    app.listen(8989)
    tornado.ioloop.IOLoop.current().start()