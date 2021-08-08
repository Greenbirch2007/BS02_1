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
            else:
                pass
            #     try:
            #         name = auth_username
            #         cursor.execute(
            #             "SELECT * FROM blog_bloguser WHERE name='{}'".format(name)
            #         )
            #         result = cursor.fetchone()
            #         if result is not None:
            #             password = result['password']
            #             if auth_password == password:
            #                 self.create_auth_header()
            #             else:
            #                 self.create_auth_header()
            #         else:
            #             self.create_auth_header()
            #     except Exception as e:
            #         return self.write(e)
            # else:
            #     self.create_auth_header()



            # base64.b64decode(object_base64).decode("utf-8")
            # body_Passwd=base64.b64decode(body_Passwd).decode("utf-8")
            # body_data["password"] =body_Passwd
            # body_data["user_id"] =body_user_id
            # print("after base64---->",body_data)
            # if body_data["user_id"] == "tg_last" and body_data["Passwd"] == "test":
            #     return body_data
            # elif body_data["user_id"] != "tg_last":
            #     self.write("user_id is wrong !")
            # elif body_data["Passwd"] != "test":
            #     self.write("Passwd is wroing!")
            # else:
            #     self.write("user_id and Passwd are wroing!")

            print("post success")
        except BaseException:
            result = {
                "eror": 400,
                "timestamp": int
            }

            self.write(json.dumps(result, ensure_ascii=False))
        response = {}
        _f_date_ = datetime.datetime.now().date()
        _f_time_ = datetime.datetime.now().time()
        response["meta"]={"version":1,"date":"{0}".format(_f_date_.strftime("%Y-%m-%d"))}
        response["info"]= {"time":"{0}".format(_f_time_.strftime("%H:%M:%S")),"result":[
            {"A":0.2},
            {"B":0.3},
            {"C":0.5},
        ]}

        response["login_info"] = body_data
        response=json.dumps(response)

        # response_str =json.load(response)
        # print(response_str["login_info"])
        self.write(response)
        print(response,type(response))

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