import unittest
from unittest.mock import Mock
from unittest.mock import patch
# 该app为创建的Flask实例
from f import app

from db import UserDB


class LoginTestCase(unittest.TestCase):

    def setUp(self):
        # push一个上下文，便可以使用flask中的全局变量，如g
        app.app_context().push()
        app.testing = True
        # 测试用的http client
        self.client = app.test_client()

    def test_login_success(self):
        # 真实请求中的url，host和port可省略
        url = '/login?name=flask&password=flaskpassword'
        # 模拟的方法名称，也可直接写字符串： get_user
        func_name = UserDB.get_user.__name__
        # 模拟的方法，不管请求参数是什么，都会返回return_value的值（Mock还有其他用法）
        mock_func = Mock(return_value={'name': 'flask', 'password': 'flaskpassword'})
        # patch意为，当UserDB的get_user方法被调用时，用mock出来的func来处理
        # 而mock的func，不管请求参数，都会返回return_value
        # 故而，只要UserDB的get_user被调用，都会返回{'name': 'flask', 'password': 'flaskpassword'}
        # with，表示这种处理方式的作用范围
        # 当在with的范围之外时，调用UserDB的get_user不受mock影响，会正常调用
        with patch.object(UserDB, func_name,mock_func):
            # response为返回的响应
            response = self.client.post(url)
            # 因为传入的name和password，和UserDB的mock func返回的name和password相同
            # 所以，该请求会返回200
            # assertEqual意为，认定返回码与200相等，若不等则该用例不通过
            self.assertEqual(response.status_code, 200)

    def test_login_failed(self):
        # 测试传入错误密码的情况
        url = '/login?name=flask&password=wrongpassword'
        func_name = UserDB.get_user.__name__
        mock_func = Mock(return_value={'name': 'flask', 'password': 'flaskpassword'})
        with patch.object(UserDB, func_name,mock_func):
            response = self.client.get(url)
            # 因为传入密码错误，所以在此我们认定返回码是400
            self.assertEqual(response.status_code, 400)


if __name__=="__main__":
    unittest.main()