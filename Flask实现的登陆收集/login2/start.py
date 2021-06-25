from flask import Flask
from flask import Flask, flash, redirect, render_template, request, session, abort
import os

app = Flask(__name__)

@app.route('/')
def home():

    if not session.get('logged_in'):
        return render_template('login.html')

    else:
        return "Hello Boss!"

@app.route('/login', methods=['POST'])
def do_admin_login():
    if request.form['password'] == 'password' and request.form['username'] == 'username':
        session['logged_in'] = True
        return "login success"
    else:
        flash('wrong password!')
        return home()

@app.route("/logout")
def logout():
    session['logged_in'] = False
    return home()

@app.route('/logout')  # 登出
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))



if __name__ == "__main__":
    app.secret_key = os.urandom(12)
    app.run(debug=True,host='0.0.0.0', port=4000)