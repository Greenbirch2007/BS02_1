# from flask import Flask, render_template, abort,json
#
# app = Flask(__name__)
#
#
# @app.route('/test')
# def index():
#     9 / 0
#     return render_template('index.html')
#
#
#
# def
#
# @app.errorhandler(ZeroDivisionError)
# def zero_division_error(e):
#     print(e)
#     return fjs
#
#
# app.run()




import logging

from flask import Flask, jsonify

app = Flask(__name__)
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s",
    filename='test.log'
)


class ApiException(Exception):
    code = 0
    msg = "错误"

    def __init__(self, code=None, msg=None):
        if code:
            self.code = code
        if msg:
            self.msg = msg

    def to_result(self):
        return {'code': self.code, 'msg': self.msg}


class illegalUserErr(ApiException):
    code = 1000
    msg = '非法的登陆用户'

class NotFound(ApiException):
    code = 1001
    msg = '资源未找到'

class ParameterErr(ApiException):
    code = 1002
    msg = '无效的参数'


class TokenExpireErr(ApiException):
    code = 1003
    msg = "token过期"



@app.route("/")
def index():
    raise ApiException('error')
    return 'ok'


@app.errorhandler(ApiException)
def handler_api_err(err):
    logging.error(err)
    return err.to_result()

@app.errorhandler(Exception)
def handler_err(err):
    logging.error(err)
    err = ApiException()
    return err.to_result()

@app.errorhandler(404)
def handle_404(err):
    err = ParameterErr('api接口不存在')
    return err.to_result()


if __name__ == "__main__":
    app.run()
