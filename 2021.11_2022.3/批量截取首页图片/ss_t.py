

import sys
import html
from logging import Formatter, handlers, StreamHandler, getLogger, DEBUG
import csv
import os
import time
import copy
import re
import datetime

from queue import Queue
import threading

from selenium import webdriver
from selenium.common.exceptions import WebDriverException,TimeoutException




queue_num = 1
test_filename = "input_urls.txt"
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
        logfilename = os.path.join(logpath,"{0}.log".format(datetime.now().strftime("%Y-%m-%d")))
        handler = handlers.RotatingFileHandler(filename = logfilename,
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


def get_only100_from225string(strng):
    if len(strng)>225:
        final_string = string[:101]
    else:
        final_string = string

    return final_string

def run_forever(func):
    def wrapper(obj):
        while True:
            func(obj)
    return wrapper


class Screenshort(object):
    def __init__(self):
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36'
        }
        self.url_pattern = '{0}'
        # url 队列
        self.url_queue = Queue()

    def add_url_to_queue(self):
        for i in url_list:
            self.url_queue.put(self.url_pattern.format(i))

    @run_forever
    def add_page_to_queue(self):
        url = self.url_queue.get()
        use_selenium_headless_getpng(url)
        self.url_queue.task_done()
    def run_use_more_task(self,func,count=1):
        for i in range(0,count):
            t = threading.Thread(target=func)
            t.setDaemon(True)
            t.start()
    def run(self):
        url_t = threading.Thread(target=self.add_url_to_queue)
        url_t.setDaemon(True)
        url_t.start()
        self.run_use_more_task(self.add_page_to_queue,queue_num)
        self.url_queue.join()


def writeinto_tsvfile(filename,data):
    filenamepath = os.path.join(outfilepath,filename)
    with open(filenamepath,"a",newline="\n",encoding="utf-8") as f:
        tsv_output = csv.writer(f,delimiter="\t")
        tsv_output.writerow(data)
        f.close()

def read_datafile(filename):
    line_list = []
    with open(filename,"r",encoding="utf-8") as f:
        for line in f.readlines():
            line = line.strip("\n")
            line_list.append(line)
    return line_list







def use_selenium_headless_getpng(urlname):
    try:
        ch_options.add_argument("--headless")
        ch_options.add_argument("--no-sandbox")
        ch_options.add_argument("--disable-gpu")
        ch_options.add_argument("--disable-dev-shm-usage")
        dr  = webdriver.Chrome(options=ch_options)
        dr.set_page_load_timeout(30)
        dr.set_script_timeout(30)
        dr.get(urlname)
        pngfile_name = re.sub(":|\\/|\\.|\\-|=|\\$|&|%|\\?|,","_",urlname)
        pngfile_name = os.path.join(pngfilepath,pngfile_name)
        used_url.append(urlname)
        dr.save_screenshot(pngfile_name)
        dr.close()
    except (WebDriverException,TimeoutException):
        pass

def mkdir(path):
    lpath=os.getcwd()
    isExists = os.path.exists(os.path.join(lpath,path))
    if not isExists:
        os.makedirs(path)

def get_not_used_url(used_url,url_list):
    line_nums = len(used_url)
    not_usedurl_len = len(url_list) - line_nums
    for i1 in url_list:
        if i1 not in used_url:
            not_used_list = [i1]
            w_time = datetime.datetime.now().strftime("%H%m%d%H%M%S%")
            writeinto_tsvfile("{0}_{1}_notused.txt".format(w_time,not_usedurl_len),not_used_list)





if __name__:="__main__":
    ch_options = webdriver.ChromeOptions()
    s = datetime.datetime.now()
    used_url =[]
    outfilepath = os.getcwd()
    mkdir("pngfile")
    pngfilepath = os.path.join(os.getcwd(),"pngfile")
    url_list = read_datafile("{0}".format(test_filename))
    sst = Screenshort()
    sst.run()
    e =  datetime.datetime.now()
    f = e-s
    get_not_used_url(used_url,url_list)
    print(f)