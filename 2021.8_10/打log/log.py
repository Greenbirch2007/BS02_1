logger.py
#!/usr/bin/env python
# -*- coding: utf-8 -*-

from logging import Formatter, handlers, StreamHandler, getLogger, DEBUG


class Logger:
    def __init__(self, name=__name__):
        self.logger = getLogger(name)
        self.logger.setLevel(DEBUG)
        formatter = Formatter("[%(asctime)s] [%(process)d] [%(name)s] [%(levelname)s] %(message)s")

        # stdout
        handler = StreamHandler()
        handler.setLevel(DEBUG)
        handler.setFormatter(formatter)
        self.logger.addHandler(handler)

        # file
        handler = handlers.RotatingFileHandler(filename = 'your_log_path.log',
                                               maxBytes = 1048576,
                                               backupCount = 3)
        handler.setLevel(DEBUG)
        handler.setFormatter(formatter)
        self.logger.addHandler(handler)

    def debug(self, msg):
        self.logger.debug(msg)

    def info(self, msg):
        self.logger.info(msg)

    def warn(self, msg):
        self.logger.warning(msg)

    def error(self, msg):
        self.logger.error(msg)

    def critical(self, msg):
        self.logger.critical(msg)


按照日期进行切分
个人比较习惯这种方式。 在logging这个库之中， 还支持按照分钟、小时、天等级别进行切分。 根据我们业务的大小， 我一般选择按照“天” 进行切分。 可以参考下面的配置：

from logging.handlers import TimedRotatingFileHandler
handler = TimedRotatingFileHandler(
        "flask.log", when="D", interval=1, backupCount=15,
        encoding="UTF-8", delay=False, utc=True)
