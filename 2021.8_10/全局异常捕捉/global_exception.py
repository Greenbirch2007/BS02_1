# -*- coding: utf-8 -*-
from flask import Flask, jsonify

app = Flask(__name__)

# 捕捉全局异常，不论是类，函数，最后都要放到视图函数里面这样才能包桌！
# @app.errorhandler(FileNotFoundError) 使用的格式一直的！

# 关于http的异常处理直接用abort
# 其他的全局变量则用，在视图函数外吧所有异常都整理好，然后，都正常在视图函数里面
#实例化，引用是如果有报错肯定会出现的！
# 也可以用raise抛出异常
@app.route("/getInfo")
def get_info():
    """获取用户信息
    """
    # db()
    try:
        app.config.from_pyfile("config.cfDg")
    except FileNotFoundError as e:
        raise e

    data = {
        "code": 0,
        "msg": "ok",
        "data": {
            "name": "Tom",
        }
    }

    # l = 1/0  # 触发异常
    return jsonify(data)

def db():
    l = 1/0

@app.errorhandler(FileNotFoundError)
def error_handler(e):
    """
    全局异常捕获

    """
    data = {
        "code": -1,
        "msg": str(e),
        "data": "FileNotFoundError"
    }


    return jsonify(data)


if __name__ == '__main__':
    app.config.from_pyfile("config.cfg")
    app.run(port=app.config["S_PORT"])
