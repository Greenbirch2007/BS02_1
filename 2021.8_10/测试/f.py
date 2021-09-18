from flask import request
from db import UserDB
from flask import Flask

app = Flask(__name__)

@app.route('/login',methods=["POST"])
def login():
    name = request.args.get('name')
    if not name:
        return 'name is required', 400

    password = request.args.get('password')
    if not password:
        return 'password is required', 400

    # 从数据库获取用户数据
    user = UserDB.get_user(name)
    if user.get('password') == password:
        return 'OK', 200
    else:
        return 'password is wrong', 400

if __name__=="__main__":
    app.run()