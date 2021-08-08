# # tornado Cookie和auth认证
# #
# # tornado Cookie和auth认证
# # 使用cookie
# # 关键函数
# #
# # set_secure_cookie 设置cookie
# # get_secure_cookie 取得浏览器的cookie
# # cookie_secret,为了使用以上方法，必须在构造函数中指定该方法
# # 例子，统计浏览器中页面被加载次数的功能
#
# #coding=utf-8
# import tornado.httpserver
# import tornado.ioloop
# import tornado.web
# import tornado.options
#
#
# from tornado.options import define, options
# define("port", default=8008, help="run on the given port", type=int)
#
#
# class MainHandler(tornado.web.RequestHandler):
#     def get(self):
#         cookie = self.get_secure_cookie("count")
#         count = int(cookie) + 1 if cookie else 1
#         countString = "1 time" if count == 1 else "%d times" % count
#         self.set_secure_cookie("count", str(count))
#
#         self.write(
#             '<html><head><title>Cookie Counter</title></head>'
#             '<body><h1>You’ve viewed this page %s times.</h1>' % countString +
#             '</body></html>'
#         )
#
#
# if __name__ == "__main__":
#     tornado.options.parse_command_line()
#     settings = {
#         "cookie_secret": "bZJc2sWbQLKos6GkHn/VB9oXwQt8S0R0kRvJ5/xJ89E="
#     }
#     application = tornado.web.Application([
#         (r'/', MainHandler)
#     ], **settings)
#     http_server = tornado.httpserver.HTTPServer(application)
#     http_server.listen(options.port)
#     tornado.ioloop.IOLoop.instance().start()
#     如果你检查浏览器中的cookie值，会发现count储存的值类似于MQ==|1310335926|8ef174ecc489ea963c5cdc26ab6d41b49502f2e2。Tornado将cookie值编码为Base-64字符串，并添加了一个时间戳和一个cookie内容的HMAC签名。如果cookie的时间戳太旧（或来自未来），或签名和期望值不匹配，get_secure_cookie()函数会认为cookie已经被篡改，并返回None，就好像cookie从没设置过一样
# self.set_cookie(‘foo’, ‘bar’, httponly=True, secure=True),
# secure属性来指示浏览器只通过SSL连接传递cookie
# httponly 浏览器对于JavaScript不可访问cookie，这可以防范来自读取cookie值的跨站脚本攻击
# ————————————————


# xsrf
# xsrf服务端设置
#     settings = {
#         "cookie_secret": "bZJc2sWbQLKos6GkHn/VB9oXwQt8S0R0kRvJ5/xJ89E=",
#         "xsrf_cookies": True
#     }
#     application = tornado.web.Application([
#         (r'/', MainHandler),
#         (r'/purchase', PurchaseHandler),
#     ], **settings)
#