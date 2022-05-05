from flask import Flask

app = Flask(__name__)

@app.route('/mytest')
def mytest():
    return 'Hello World.这是一个部署测试。'

if __name__ == '__main__':
    app.run()