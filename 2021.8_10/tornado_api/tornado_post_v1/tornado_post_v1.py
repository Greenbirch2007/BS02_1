#! -*-coding:utf-8 -*-

import datetime
import tornado.ioloop
import tornado.web
from tornado.escape import json_decode, json_encode

import time
import json


class MainHandler(tornado.web.RequestHandler):

    def post(self, *args, **kwargs):
        global body_data
        try:
            # from client receive info json------>object
            body_data = tornado.escape.json_decode(self.request.body)
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

if __name__=="__main__":
    app = make_app()
    app.listen(8989)
    tornado.ioloop.IOLoop.current().start()