#! -*-coding:utf-8 -*-


import csv
import os
import time
import copy
from config import *
import re
from urllib3.exceptions import ProtocolError,MaxRetryError
import datetime
import requests
from queue import Queue
import threading
from bs4 import BeautifulSoup
from requests.exceptions import ConnectionError,RequestException,ConnectTimeout,ReadTimeout
import langid
import asyncio
import aiohttp
from logging import Formatter, handlers, StreamHandler, getLogger, DEBUG
import html
from zhconv import convert

queue_num = 6
test_filename = "input.txt"

def solve_meta_http_equiv_refresh(string_content):
    if 'http-equiv="refresh"' in string_content:
        pattern = re.compile('<meta http-equiv="refresh" content="(.*?)">',re.S)
        items = re.findall(pattern,string_content)
        redirect_url = items[0].split("url=")[1]
        final_url = redirect_url
        final_content = ""
    else:
        final_url = ""
        final_content  = string_content
    return final_content,final_url

class Logger():
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
        mkdir("logfile")
        logpath = os.path.join(os.getcwd(), "logfile")
        logfilename = os.path.join(logpath,"{0}.log".format(datetime.datetime.now().strftime("%Y-%m-%d")))
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

def confirm_zhtw(langcontent,stringcontent):
    zh_cn_convert_content = convert(stringcontent,"zh-cn")
    if langcontent =="zh":
        if zh_cn_convert_content == stringcontent:
            lang_zh = 'zh-cn'
        else:
            lang_zh = 'zh-tw'
        final_lang = lang_zh
    elif langcontent =="ja" and True not in [x in stringcontent for x in all_kana]:
        lang_zh = 'zh-tw'
        final_lang = lang_zh
    else:
        final_lang = langcontent
    return final_lang

def convert_string(string):
    string = html.unescape(string)
    return string

def use_langid_confirmlang(stringcontent):
    lang_confirm_content = langid.classify(stringcontent[0])
    lang_confirm_content = confirm_zhtw(lang_confirm_content,stringcontent)
    return lang_confirm_content

def confirm_lang(title,meta_keywords,meta_description,a_tag,p_tag):
    try :
        if a_tag !="":
            lang_content = use_langid_confirmlang(a_tag)
        elif a_tag=="" and p_tag!="":
            lang_content = use_langid_confirmlang(p_tag)
        elif a_tag=="" and p_tag=="" and meta_keywords !="":
            lang_content = use_langid_confirmlang(meta_keywords)
        elif a_tag=="" and p_tag=="" and meta_keywords =="" and meta_description!="":
            lang_content = use_langid_confirmlang(meta_description)
        elif a_tag == "" and p_tag == "" and meta_keywords == "" and meta_description == "" and title!="":
            lang_content = use_langid_confirmlang(title)
        else:
            lang_content = ""
    except:
        lang_content =""

    return lang_content

def confirm_notnull_string(list_item):
    if len(list_item)!=0:
        final_content = list_item
    else:
        final_content = [" "]
    return final_content

def cleanupString(list_item):
    result_string = " ".join(" ".join([x.strip() for x in list_item])).split()
    return result_string


def writeinto_htmlfile(filename,data):
    filename = os.path.join(htmlfilepath,filename)
    with open(filename,"w",encoding="utf-8") as f_output:
        f_output.write(data)

def remove_upprintable_char(s):
    return "".join(x for x in s if x.isprintable())
def writeinto_tsvfile(filename,data):
    filename = os.path.join(outfilepath,filename)
    with open(filename,"a",newline="",encoding="utf-8") as f_output:
        tsv_output = csv.writer(f_output,delimiter="\t")
        tsv_output.writerow(data)

def save_30000laststring(string_content):
    if string_content !="":
        string_content = string_content[:28888]
    return string_content
def mkdir(path):
    lpath=os.getcwd()
    isExists = os.path.exists(os.path.join(lpath,path))
    if not isExists:
        os.makedirs(path)

def clean_except_big_string(big_string):
    # big_string = re.sub(special_tag,"",big_string)
    # big_string = re.sub(emoji_tag,"",big_string)
    # big_string = re.sub(clean_except_big_string_tag,"",big_string)
    # big_string = re.sub("","",big_string)
    big_string = remove_upprintable_char(big_string)
    big_string =" ".join(big_string.split("\\"))
    big_string= save_30000laststring(big_string)
    return big_string




def big_cleanup(big_string):
    # big_string = re.sub(special_tag,"",big_string)
    # big_string = re.sub(emoji_tag,"",big_string)
    # big_string = re.sub(big_cleanup_tag,"",big_string)
    # big_string =" ".join(big_string.split("\\"))
    big_string= save_30000laststring(big_string)
    return big_string

def use_bs4_parsehtml(html,tag_name):
    tag_list = []
    soup = BeautifulSoup(html,"html.parser")
    tag_len = len(soup.find_all(tag_name))
    for item in range(tag_len):
        tag_list.append(" ".join(soup.find_all(tag_name)[item].get_text().split()))
    big_string = " ".join(tag_list)
    final_list =[big_string]
    return final_list


def use_re_parsehtml_get_metainfo(html):
    keyword_list = []
    description_list = []
    meta_tag_pattern = re.compile('<meta(.*?)>',re.S)
    meta_content = re.compile('content="(.*?)"',re.S)
    meta_tag_content = re.findall(meta_tag_pattern,html)
    for item in meta_tag_content:
        if "Keywords" in item or "keywords" in item or "KEYWORDS" in item:
            for item in re.findall(meta_content,item):
                item = convert_string(item)
                keyword_list.append(item)
        if "description" in item or "Description" in item or "DESCRIPTION" in item:
            for item in re.findall(meta_content,item):
                item = convert_string(item)
                description_list.append(item)

    return keyword_list,description_list


def clean_nn(list_content):
    for item in list_content[3:]:
        if item !="":
            cleaned_item = " ".join(item.split())
            list_content[list_content.index(item)] = cleaned_item
    return list_content

def keep_textof_block(list_content):
    list_content_block = " ".join(list_content)
    list_content_list = [list_content_block]
    return list_content_list

def confirm_responsetext(response,encodings):
    if encodings !=[]:
        response_text = response.content.decode("{0}".format(encodings[0]))
    else:
        response_text = response.text
    return response_text


def get_only100_from225string(string):
    if len(string)>225:
        final_string = string[:101]
    else:
        final_string = string
    return final_string

def after_parse_html_has_80(url,response,response_text):
    list_text = parsehtml_intoListText(response_text)
    html_text = copy.deepcopy(response_text)
    data_url = url
    afer_redirected_url= data_url
    final_list  = [data_url,afer_redirected_url,response.status_code] + list_text
    if final_list[0] in url_list and final_list[0][:4] =="http":
        final_list = clean_nn(final_list)
        used_url_content.append(final_list)
        onlyurl_from_threading_output_1_ =  final_list[:1]
        used_url_list.append(onlyurl_from_threading_output_1_[0])
        htmlfile_name = re.sub(":|\/|\.|\-|=|&|%|\$|\?|.","_",data_url)
        htmlfile_name = get_only100_from225string(htmlfile_name)
        writeinto_htmlfile(htmlfile_name+".html",html_text)
    else:
        pass
def run_forever(func):
    def wrapper(obj):
        while True:
            func(obj)
    return wrapper


class Bspider(object):
    def __init__(self):
        self.headers = {
            "User-Agent":"Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0;"
        }
        self.url_pattern = '{0}'
        # url 队列
        self.url_queue = Queue()

    def add_url_to_queue(self):
        for i in url_list:
            self.url_queue.put(self.url_pattern.format(i))

    @run_forever
    def add_page_to_queue(self):
        try:
            url = self.url_queue.get()
            response = requests.get(url,headers = self.headers,timeout=10,allow_redirects=True)
            final_content,final_url = solve_meta_http_equiv_refresh(response.text)
            if final_url != "":
                response = requests.get(final_url,headers=self.headers,timeout=10,allow_redirects=True)
            else:
                response =  response

            after_redirected_url = response.url
            encodings = requests.utils.get_encodings_from_content(response.text)
            response_text = confirm_responsetext(response,encodings)
            after_parse_html_has_80(url,response,response_text)
        except (UnicodeDecodeError,LookupError) as e:
            try:
                response = requests.get(url,header=self.headers,timeout=10,allow_redirects=True)
                response_text = response.text
                after_parse_html_has_80(url,response,response_text)
            except (ReadTimeout,ProtocolError,ConnectTimeout,MaxRetryError) as e:
                if "No such file or directory" not in str(e):
                    data_url = url
                    log.debug("url:{0},error:{1}".format(data_url,e))

        except (ReadTimeout,ProtocolError,ConnectTimeout,MaxRetryError) as e:
            if "No such file or directory" not in str(e):
                data_url = url
                log.debug("url:{0},error:{1}".format(data_url, e))
        except ConnectionError as e:
            if "HTTPConnectionPool" in str(e):
                data_url = url
                www_not_exists_url = data_url
                async def error_request(i):
                    i = www_not_exists_url
                    async with aiohttp.ClientSession() as session:
                        async with session.get(i) as resp:
                            text = await resp.text()
                            response_text = text
                            list_text = parsehtml_intoListText(response_text)
                            html_text = copy.deepcopy(response_text)
                            data_url = url
                            final_list = [www_not_exists_url,after_redirected_url,response.status_code] + list_text
                            if final_list[0] in url_list and final_list[0][:4] =="http":
                                final_list = clean_nn(final_list)
                                used_url_content.append(final_list)
                                onlyurl_from_threading_output_1_ = final_list[:1]
                                used_url_list.append(onlyurl_from_threading_output_1_[0])
                                htmlfile_name = re.sub(":|\/|\.|\-|\?|#","_",data_url)
                                htmlfile_name = get_only100_from225string(htmlfile_name)
                                writeinto_htmlfile(htmlfile_name+".html",html_text)

                        loop = asyncio.get_event_loop()
                        func_list = (error_request(i) for i in [www_not_exists_url])
                        loop.run_until_complete(asyncio.gather(*func_list))
            else:
                if "No such file or directory" not in str(e):
                    data_url = url
                    log.debug("url:{0},error:{1}".format(data_url, e))
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

def listdir(path,list_name):
    for file in os.listdir(path):
        file_path = os.path.join(path,file)
        if os.path.isdir(file_path):
            listdir(file_path,list_name)
        elif os.path.splitext(file_path)[1] == ".tsv":
            list_name.append(file_path)



def read_datafile(filename):

    line_list= []
    with open(filename,"r",encoding="utf-8") as f :
        for line in f.readlines():
            line = line.strip("\n")
            line_list.append(line)
    return line_list

def change_tsvfilename():
    os.chdir(outfilepath)
    write_intofilename_datatime = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
    line_nums = len(used_url_list)
    not_usedurl_len = len(url_list) - line_nums
    for i1 in url_list:
        if i1 not in used_url_list:
            not_used_list = [i1]
            writeinto_tsvfile('{0}_{1}_notused_url.txt'.format(write_intofilename_datatime,not_usedurl_len),not_used_list)
    time.sleep(2)
    for file in os.listdir("."):
        if file.split(".")[1] == "tsv" and file.split("_")[0] == "use":
            os.rename(file,write_intofilename_datatime+"_"+str(line_nums)+"_"+file)
def parsehtml_intoListText(text):
    title_tag = use_bs4_parsehtml(text,"title")
    html_lang_tag = [" "]
    meta_keywords_contents,meta_description_contents = use_re_parsehtml_get_metainfo(text)
    a_tag = use_bs4_parsehtml(text,"a")
    p_tag = use_bs4_parsehtml(text,"p")
    ohter_tag_string_list=[]
    for one_tag in other_tag:
        one_tag_string = use_bs4_parsehtml(text,one_tag)
        if one_tag_string != [""] and one_tag_string !=[" "]:
            for item in one_tag_string:
                ohter_tag_string_list.append(item)

    final_list_title_tag = convert_string(confirm_notnull_string(title_tag))
    final_list_html_lang_tag = convert_string(confirm_notnull_string(keep_textof_block(html_lang_tag)))
    final_list_meta_keywords_contents = convert_string(confirm_notnull_string(keep_textof_block(meta_keywords_contents)))
    final_list_meta_description_contents = convert_string(confirm_notnull_string(keep_textof_block(meta_description_contents)))
    final_list_a_tag = convert_string(confirm_notnull_string(a_tag))
    final_list_p_tag = convert_string(confirm_notnull_string(p_tag))
    final_list_other_tag_string_list =confirm_notnull_string(keep_textof_block(ohter_tag_string_list))
    final_big_cleanup_string = convert_string(big_cleanup(cleanupString(final_list_other_tag_string_list)))
    print(cleanupString(final_list_other_tag_string_list))
    if final_big_cleanup_string !=0:
        final_big_cleanup_string = final_big_cleanup_string[:29999]
        list_text =[clean_except_big_string(cleanupString(final_list_html_lang_tag)).lower(),
                    clean_except_big_string(cleanupString(final_list_title_tag)).lower(),
                    clean_except_big_string(cleanupString(final_list_meta_keywords_contents)).lower(),
                    clean_except_big_string(cleanupString(final_list_meta_description_contents)).lower(),
                    clean_except_big_string(cleanupString(final_list_a_tag)).lower(),
                    clean_except_big_string(cleanupString(final_list_p_tag)).lower(),
                    final_big_cleanup_string.lower()]

    else:
        list_text =[clean_except_big_string(cleanupString(final_list_html_lang_tag)).lower(),
                    clean_except_big_string(cleanupString(final_list_title_tag)).lower(),
                    clean_except_big_string(cleanupString(final_list_meta_keywords_contents)).lower(),
                    clean_except_big_string(cleanupString(final_list_meta_description_contents)).lower(),
                    clean_except_big_string(cleanupString(final_list_a_tag)).lower(),
                    clean_except_big_string(cleanupString(final_list_p_tag)).lower(),
                    final_big_cleanup_string.lower()]
    lang_content =confirm_lang(list_text[1],list_text[2],list_text[3],list_text[4],list_text[5])
    list_text[0] = lang_content
    return list_text




if __name__ :="__main__":
    log = Logger()
    used_url_list = []
    used_url_content = []
    mkdir("outfile")
    mkdir("htmlfile")

    time.sleep(1)
    outfilepath = os.path.join(os.getcwd(),"outfile")
    htmlfilepath = os.path.join(os.getcwd(),"htmlfile")

    time.sleep(1)
    url_list = read_datafile("{0}".format(test_filename))
    log.debug("start time:{0}".format(datetime.datetime.now()))
    s = datetime.datetime.now()
    bs_ = Bspider()
    bs_.run()
    time.sleep(1)
    for item in used_url_content:
        writeinto_tsvfile("output.tsv",item)
    change_tsvfilename()