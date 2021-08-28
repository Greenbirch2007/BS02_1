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


�������ڽ����з�
���˱Ƚ�ϰ�����ַ�ʽ�� ��logging�����֮�У� ��֧�ְ��շ��ӡ�Сʱ����ȼ�������з֡� ��������ҵ��Ĵ�С�� ��һ��ѡ���ա��족 �����з֡� ���Բο���������ã�

from logging.handlers import TimedRotatingFileHandler
handler = TimedRotatingFileHandler(
        "flask.log", when="D", interval=1, backupCount=15,
        encoding="UTF-8", delay=False, utc=True)

���ߣ���������·��
���ӣ�https://www.jianshu.com/p/daf5c9e57c65
��Դ������
����Ȩ���������С���ҵת������ϵ���߻����Ȩ������ҵת����ע��������