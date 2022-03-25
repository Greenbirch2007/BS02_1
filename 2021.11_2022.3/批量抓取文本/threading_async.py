#! -*- coding:utf-8 -*-

import csv
import os
import time
import copy
from config import *
import re
from urllib3.exceptions import ProtocolError
import datetime
import requests
from queue import Queue
import threading
from urllib3.exceptions import MaxRetryError
from bs4 import BeautifulSoup
from requests.exceptions import  ConnectionError,ReadTimeout,ConnectTimeout
import langid

import asyncio
import aiohttp
from logging import Formatter, handlers, getLogger, DEBUG
import html
from zhconv import convert

queue_num = 10
test_filename = "input.txt"
########


def solve_meta_http_equiv_refresh(stringcontent):
    if 'http-equiv="refresh"' in stringcontent:
        pattern = re.compile('<meta http-equiv="refresh" content="(.*?)">',re.S)
        items = re.findall(pattern,stringcontent)
        redirect_url = items[0].split("url=")[1]
        final_url = redirect_url
        finanl_content = ""
    else:
        final_url = ""
        finanl_content = stringcontent
    return finanl_content,final_url

class Logger():
    def __init__(self, name=__name__):
        self.logger = getLogger(name)
        self.logger.setLevel(DEBUG)
        formatter = Formatter("[%(asctime)s] [%(process)d] [%(name)s] [%(levelname)s] %(message)s")
        handler = handlers.RotatingFileHandler(filename = '{0}.log'.format(datetime.datetime.now().strftime("%Y%m%d%H%M%S")),
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
# source :https://github.com/gumblex/zhconv
def confirm_ko_2_zh_tw(langcontent,stringcontent):
    zh_cn_convert_content = convert(stringcontent,'zh-cn')
    if langcontent =="zh":
        if zh_cn_convert_content == stringcontent:
            lang_zh = 'zh-cn'
        else:
            lang_zh = 'zh-tw'
        finanl_lang = lang_zh
    elif langcontent =="ja" and True not in [x in stringcontent for x in all_kana]:
        lang_zh = 'zh-tw'
        finanl_lang = lang_zh
    else:
        finanl_lang = langcontent
    return finanl_lang

# It&#x27;s----->It's
def convert_string(string):
    string = html.unescape(string)
    return string

def use_langdetect_and_langid_confirmlang(stringcontent):
    langdetect_content = langid.classify(stringcontent)[0]
    langdetect_content = confirm_ko_2_zh_tw(langdetect_content,stringcontent)
    return langdetect_content




def confirm_lang(
        title,
        meta_keywords,
        meta_description,
        a_tag,
        p_tag,
        ):
    try:
        if  a_tag != "":

            lang_content = use_langdetect_and_langid_confirmlang(a_tag)
        elif  a_tag == "" and p_tag != "":
            lang_content =  use_langdetect_and_langid_confirmlang(p_tag)
        elif  a_tag == "" and p_tag == "" and meta_keywords != "":
            lang_content = use_langdetect_and_langid_confirmlang(meta_keywords)
        elif  a_tag == "" and p_tag == "" and meta_keywords == "" and meta_description != "":
            lang_content = use_langdetect_and_langid_confirmlang(meta_description)
        elif a_tag == "" and p_tag == "" and meta_keywords == "" and meta_description == "" and title != "":
            lang_content = use_langdetect_and_langid_confirmlang(title)
        else:
            lang_content = ""
    except :
        lang_content = ""
    return lang_content



def confirmNotNullString(list_item):
    if len(list_item)!=0:
        final_content = list_item
    else:
        final_content = [" "]
    return final_content


def cleanupString(list_item):
    result_string= " ".join(" ".join([x.strip() for x in list_item]).split())
    return result_string


def writeinto_htmlfile(filename,data):
    filenamepath = os.path.join(htmlfilepath,filename)
    with open(filenamepath, 'w', encoding="utf-8") as f_output:
        f_output.write(data)




def writeintoTSV_file(filename,data):
    filenamepath = os.path.join(outfilepath,filename)
    with open(filenamepath,'a', newline='\n', encoding="utf-8") as f_output:
        tsv_output = csv.writer(f_output, delimiter='\t')
        tsv_output.writerow(data)




def save_30000_laststring(string_content):
    if string_content !="":
        string_content = string_content[:29999]
    return string_content
def mkdir(path):
    lpath = os.getcwd()
    isExists = os.path.exists(lpath+"/"+path)
    if not isExists:
        os.makedirs(path)

def clean_except_big_string(big_string):
    big_string = save_30000_laststring(big_string)
    big_string =  re.sub(special_tag,'',big_string)
    big_string =  re.sub(emoji_tag1,'',big_string)
    big_string =  re.sub(emoji_tag2,'',big_string)
    big_string =  re.sub(emoji_tag3,'',big_string)
    big_string =  re.sub(emoji_tag4,'',big_string)
    big_string =  re.sub(emoji_tag5,'',big_string)
    big_string =  re.sub(emoji_tag6,'',big_string)
    big_string =  re.sub(emoji_tag7,'',big_string)
    big_string =  re.sub(emoji_tag8,'',big_string)
    big_string =  re.sub(emoji_tag9,'',big_string)
    big_string =  re.sub(clean_except_big_string_tag,'',big_string)
    big_string = remove_upprinttalb_char(big_string)
    big_string = re.sub("","",big_string)
    big_string = re.sub(new_words,"",big_string)
    big_string = " ".join(big_string.split("\\"))

    return big_string

def remove_upprinttalb_char(s):
    return "".join(x for x in s if x.isprintable())

def big_cleanup(big_string):
    big_string = save_30000_laststring(big_string)
    big_string =  re.sub(special_tag,'',big_string)
    big_string =  re.sub(emoji_tag1,'',big_string)
    big_string =  re.sub(emoji_tag2,'',big_string)
    big_string =  re.sub(emoji_tag3,'',big_string)
    big_string =  re.sub(emoji_tag4,'',big_string)
    big_string =  re.sub(emoji_tag5,'',big_string)
    big_string =  re.sub(emoji_tag6,'',big_string)
    big_string =  re.sub(emoji_tag7,'',big_string)
    big_string =  re.sub(emoji_tag8,'',big_string)
    big_string =  re.sub(emoji_tag9,'',big_string)
    big_string = re.sub(big_cleanup_tag, '', big_string)
    big_string = remove_upprinttalb_char(big_string)
    big_string = " ".join(big_string.split("\\"))
    big_string = re.sub(new_words,"",big_string)

    return big_string


def use_bs4_parsehtml(html,tag_name):
    tag_list = []
    soup = BeautifulSoup(html, 'html.parser')
    soup_find_all_tagname = soup.find_all(tag_name)
    tag_len = len(soup_find_all_tagname)
    for item in range(tag_len):
        # remove \n \t
        tag_list.append(" ".join(soup_find_all_tagname[item].get_text().split()))
    big_string = " ".join(tag_list)
    final_list= [big_string]
    return final_list

def use_re_parsehtml_get_metainfo(html):
    keysword_list = []
    description_list = []
    meta_tag_pattern = re.compile('<meta(.*?)>', re.S)
    meta_content = re.compile('content="(.*?)"', re.S)
    meta_tag_content = re.findall(meta_tag_pattern,html)
    for item in meta_tag_content:
        if "keywords" in item or "Keywords" in item or "KEYWORDS" in item:
            for item in re.findall(meta_content, item):
                item = convert_string(item)
                keysword_list.append(item)
        if "description" in item or "Description" in item or "DESCRIPTION" in item:
            for item in re.findall(meta_content, item):
                item = convert_string(item)
                description_list.append(item)
    return keysword_list,description_list


def clean_nn(list_content):
    for item in list_content[3:]:
        if item !="":
            cleaned_item = " ".join(item.split())
            list_content[list_content.index(item)] = cleaned_item
    return list_content

def parseHtml_intoListText(text):
    title_tag = use_bs4_parsehtml(text,"title")
    html_lang_tag =  [" "]
    meta_keywords_contents,meta_desciption_contents = use_re_parsehtml_get_metainfo(text)
    a_tag =  use_bs4_parsehtml(text,"a")
    p_tag =  use_bs4_parsehtml(text,"p")
    other_tag_string_list = []

    for one_tag in other_tag:
        one_tag_string = use_bs4_parsehtml(text,one_tag) # body tag
        if one_tag_string != [""] and one_tag_string != [" "]:
            for item in one_tag_string:
                other_tag_string_list.append(item)
    final_list_title_tag = convert_string(confirmNotNullString(keep_textof_block(title_tag)))
    final_list_html_lang_tag = convert_string(confirmNotNullString(keep_textof_block(html_lang_tag))) # [" "]
    final_list_meta_keywords_contents = convert_string(confirmNotNullString(keep_textof_block(meta_keywords_contents)))
    final_list_meta_desciption_contents = convert_string(confirmNotNullString(keep_textof_block(meta_desciption_contents)))
    final_list_a_tag = convert_string(confirmNotNullString(a_tag))
    final_list_p_tag = convert_string(confirmNotNullString(p_tag))
    final_list_other_tag_string_list = convert_string(confirmNotNullString(keep_textof_block(other_tag_string_list)))
    final_big_cleanup_string = convert_string(big_cleanup(cleanupString(final_list_other_tag_string_list)))
    if final_big_cleanup_string != 0:
        final_big_cleanup_string = final_big_cleanup_string[:29999]
        list_text = [clean_except_big_string(cleanupString(final_list_html_lang_tag)).lower(),
                     clean_except_big_string(cleanupString(final_list_title_tag)).lower(),
                     clean_except_big_string(cleanupString(final_list_meta_keywords_contents)).lower(),
                     clean_except_big_string(cleanupString(final_list_meta_desciption_contents)).lower(),
                     clean_except_big_string(cleanupString(final_list_a_tag)).lower(),
                     clean_except_big_string(cleanupString(final_list_p_tag)).lower(),
                     final_big_cleanup_string.lower()]
    else:
        list_text = [clean_except_big_string(cleanupString(final_list_html_lang_tag)).lower(),
                     clean_except_big_string(cleanupString(final_list_title_tag)).lower(),
                     clean_except_big_string(cleanupString(final_list_meta_keywords_contents)).lower(),
                     clean_except_big_string(cleanupString(final_list_meta_desciption_contents)).lower(),
                     clean_except_big_string(cleanupString(final_list_a_tag)).lower(),
                     clean_except_big_string(cleanupString(final_list_p_tag)).lower(),
                     final_big_cleanup_string.lower()]

    lang_content = confirm_lang(list_text[1],list_text[2],list_text[3],list_text[4],list_text[5])
    list_text[0] = lang_content
    return list_text


def run_forever(func):
    def wrapper(obj):
        while True:
            func(obj)
    return wrapper



def readDatafile(filename):
    line_list = []
    with open(filename,"r", encoding="utf-8") as f:
        for line in f.readlines():
            line = line.strip("\n")
            line_list.append(line)
    return line_list


def change_tsvfilename():
    os.chdir(outfilepath)
    write_intofilename_datetime = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
    line_nums = len(used_url_list)
    not_usedurl_len = len(url_list)-line_nums

    for i1 in url_list:
        if i1 not in used_url_list:
            not_used_list = [i1]
            writeintoTSV_file('{0}_{1}_notused_url.txt'.format(write_intofilename_datetime,not_usedurl_len), not_used_list)
    time.sleep(2)
    for file in os.listdir("."):
        if file.split(".")[1]=="tsv" and file.split("_")[0] =="use":
            os.rename(file, write_intofilename_datetime + "_" + str(line_nums) + "_" + file)





def keep_textof_block(list_content):
    list_content_block =" ".join(list_content)
    list_content_list = [list_content_block]
    return list_content_list

def confirm_encodings(response,encodings):
    if encodings != []:
        response_text = response.content.decode("{0}".format(encodings[0]))
    else:
        response_text = response.text
    return response_text

def confirm_reponsetext(response, encodings):
    if encodings != []:
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
    list_text = parseHtml_intoListText(response_text)
    html_text = copy.deepcopy(response_text)
    data_url = url
    after_redirected_url = response.url
    final_list = [data_url, after_redirected_url, response.status_code] + list_text
    if final_list[0] in url_list and final_list[0][:4] == "http":
        final_list = clean_nn(final_list)
        used_url_content.append(final_list)
        onlyurl_from_threading_output_1_ = final_list[:1]
        used_url_list.append(onlyurl_from_threading_output_1_[0])
        htmlfile_name = re.sub(":|\/|\.|\-|=|&|%|\$|\?|,", "_", data_url)
        htmlfile_name = get_only100_from225string(htmlfile_name)
        writeinto_htmlfile(htmlfile_name + ".html", html_text)
    else:
        pass


class ARtoolSpider(object):
    def __init__(self):
        self.headers = {
            'User-Agent': 'User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; TencentTraveler 4.0)'
        }
        self.url_pattern = '{0}'
        self.url_queue = Queue()
    def add_url_to_queue(self):
        for i in url_list:
            self.url_queue.put(self.url_pattern.format(i))


    @run_forever
    def add_page_to_queue(self):
        try:
            url = self.url_queue.get()
            response = requests.get(url,headers=self.headers,timeout=10,allow_redirects=True)

            finanl_content, final_url = solve_meta_http_equiv_refresh(response.text)
            if final_url !="":
                response = requests.get(final_url, headers=self.headers, timeout=10, allow_redirects=True)
            else:
                response = response

            after_rediected_url = response.url
            encodings = requests.utils.get_encodings_from_content(response.text)
            response_text = confirm_reponsetext(response,encodings)
            after_parse_html_has_80(url, response, response_text)
        except (UnicodeDecodeError,LookupError) as e:
            try:
                response = requests.get(url, headers=self.headers, timeout=10,allow_redirects=True)
                response_text = response.text
                after_parse_html_has_80(url,response,response_text)
            except (BaseException,ReadTimeout,ProtocolError,ConnectTimeout,MaxRetryError)as e:
                if "No such file or directory" not in str(e):
                    data_url = url
                    log.debug("url:{0},error:{1}".format(data_url, e))

        except (BaseException,ReadTimeout,ProtocolError,ConnectTimeout,MaxRetryError)as e:
            if "No such file or directory" not in str(e):
                data_url = url
                log.debug("url:{0},error:{1}".format(data_url, e))
        except ConnectionError as e :

            if "HTTPConnectionPool" in str(e):
                data_url = url
                www_not_exists_url = data_url
                async def error_request(i):
                    i = www_not_exists_url
                    async with aiohttp.ClientSession() as session:
                        async with session.get(i) as resp:
                            text = await resp.text()
                            response_text = text
                            list_text = parseHtml_intoListText(response_text)
                            html_text = copy.deepcopy(response_text)
                            data_url = url
                            final_list = [www_not_exists_url, after_rediected_url, response.status_code] + list_text
                            if final_list[0] in url_list and final_list[0][:4] == "http":
                                final_list = clean_nn(final_list)
                                used_url_content.append(final_list)
                                onlyurl_from_threading_output_1_ = final_list[:1]
                                used_url_list.append(onlyurl_from_threading_output_1_[0])
                                htmlfile_name = re.sub(":|\/|\.|\-|\?|#", "_", data_url)
                                htmlfile_name = get_only100_from225string(htmlfile_name)
                                writeinto_htmlfile(htmlfile_name + ".html", html_text)
                loop = asyncio.get_event_loop()
                fun_list = (error_request(i) for i in [www_not_exists_url])
                loop.run_until_complete(asyncio.gather(*fun_list))
            else:
                if "No such file or directory" not in str(e):
                    data_url = url
                    log.debug("url:{0},error:{1}".format(data_url, e))



        self.url_queue.task_done()
    def run_use_more_task(self, func, count=1):
        for i in range(0, count):
            t = threading.Thread(target=func)
            t.setDaemon(True)
            t.start()
    def run(self):
        url_t = threading.Thread(target=self.add_url_to_queue)
        url_t.setDaemon(True)
        url_t.start()
        self.run_use_more_task(self.add_page_to_queue,queue_num)
        self.url_queue.join()


def listdir(path, list_name):
    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isdir(file_path):
            listdir(file_path, list_name)
        elif os.path.splitext(file_path)[1] == '.tsv':
            list_name.append(file_path)

if __name__ == '__main__':
    log = Logger()
    used_url_list= []
    used_url_content = []
    mkdir("outfile")
    mkdir("htmlfile")
    time.sleep(1)
    outfilepath = os.path.join(os.getcwd(), "outfile")
    htmlfilepath = os.path.join(os.getcwd(), "htmlfile")
    time.sleep(1)
    url_list = readDatafile("{0}".format(test_filename))
    log.debug("start time : {0}".format(datetime.datetime.now()))
    s = datetime.datetime.now()
    qbs = ARtoolSpider()
    qbs.run()
    time.sleep(1)
    for item in used_url_content:
        writeintoTSV_file('use_requests_output.tsv', item)
    change_tsvfilename()
