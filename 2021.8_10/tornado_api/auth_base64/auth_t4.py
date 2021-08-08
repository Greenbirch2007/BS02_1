import jwt
class LoginHandler(BaseHandler):
    '''
    用户登录
    post -> /login/
    payload:
        {
            "username": "用户名或者邮箱",
            "password": "密码"
        }
    '''
    async def post(self, *args, **kwargs):
        res = {}
        data = self.request.body.decode("utf-8")
        data = json.loads(data)
        form = LoginForm.from_json(data)
        if form.validate():
            username = form.username.data
            password = form.password.data
            try:
                query = UserProfile.select().where(
                    (UserProfile.username==username) | (UserProfile.email==username)
                )
                user = await self.application.objects.execute(query)
                try:
                    user = user[0]
                except IndexError as e:
                    self.set_status(400)
                    res['non_fields'] = '不存在该用户'
                    self.finish(res)
                    return
                if not user.password.check_password(password):
                    res['non_fields'] = '用户名或密码错误'
                    self.set_status(400)
                else:
                    payload = {
                        'id': user.id,
                        'username': username,
                        'exp': datetime.utcnow()
                    }
                    token = jwt.encode(payload, self.settings["secret_key"], algorithm='HS256')
                    res['token'] = token.decode('utf-8')
                    res['username'] = username
            except UserProfile.DoesNotExist:
                self.set_status(400)
                res['username'] = '用户不存在'
        else:
            self.set_status(400)
            for field in form.errors:
                res[field] = form.errors[field]
        self.finish(res)