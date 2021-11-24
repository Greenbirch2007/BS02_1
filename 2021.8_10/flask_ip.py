from flask import Flask

from flask import request
from flask import jsonify



app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'


@app.route("/get_my_ip", methods=["GET"])
def get_my_ip():
     
    return jsonify({'ip': request.environ.get('HTTP_X_REAL_IP', request.remote_addr)}), 200    

if __name__ == '__main__':
    app.run(host='0.0.0.0')