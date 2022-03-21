# -*- coding:utf-8 -*-
import os
import time
import subprocess
import config.HTMLTestReportEN as HTMLTestReportEN
import unittest
import warnings
from config import *
import datetime
import json


def mkdir(path):
    lpath = os.getcwd()
    isExists = os.path.exists(lpath+"/"+path)
    if not isExists:
        os.makedirs(path)



def write_intotTXT(filename,path,contents):
    filepath = os.path.join(path,filename)
    fi_ = open(filepath, "a")
    print(contents,file=fi_)
    now_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print("\n",file=fi_)
    print("test time is: {0}".format(now_time),file=fi_)
    fi_.close()

def alter(file, old_str, new_str):
    """
    替换文件中的字符串
    :param file:文件名
    :param old_str:就字符串
    :param new_str:新字符串
    :return:
    """
    file_data = ""
    with open(file, "r", encoding="utf-8") as f:
        for line in f:
            if "" not in line and "" not in line and "" not in line and old_str in line:
                line = line.replace(old_str, new_str)
            file_data += line
    with open(file, "w", encoding="utf-8") as f:
        f.write(file_data)


def clean_string_from_conf(file, cleanstring):
    file_data = ""
    with open(file, "r", encoding="utf-8") as f:
        for line in f:
            if cleanstring in line:
                line = line.replace(line, " ")
            file_data += line
    with open(file, "w", encoding="utf-8") as f:
        f.write(file_data)



def confirmRoot_from_string(item_string):
    global owner_authority,group_authority
    date_shorthand = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", ]
    for i1 in date_shorthand:
        if i1  in item_string.split():
            owner_authority = item_string.split()[2]
            group_authority = item_string.split()[3]
        return owner_authority,group_authority


def compare_path2jsonfile(pathname,jsonfile,testname):
    warnings.simplefilter("ignore", ResourceWarning)
    mkdir("")
    # get the path info
    now_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    filepath = os.path.join(evidencepath, "{0}_result.txt".format(testname))
    fi_ = open(filepath, "w")
    print("\n", file=fi_)
    print("{0} is running!".format(testname) + " " * 5 +"Test time is {0}".format(now_time), file=fi_)
    print("\n", file=fi_)
    # get tree path
    def tree_path_json(path):
        dir_structure = {}
        base_name = os.path.basename(os.path.realpath(path))
        if os.path.isdir(path):
            dir_structure[base_name] = [tree_path_json(os.path.join(path, file_name)) for file_name in os.listdir(path)]
        else:
            return os.path.basename(path)
        return dir_structure
    big_dict = dict(tree_path_json(pathname))
    # read the json file
    with open(jsonfile,"r") as f:
        data = json.load((f))
        print("\n", file=fi_)
        print("", file=fi_)
        fi_.close()
        return data,big_dict

class TestS(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        mkdir("")
        warnings.simplefilter("ignore", ResourceWarning)
        os.system("")
    def test_1_1_1(self):
        self.assertTrue(True)
        print("")
def Suite():
    suiteTest = unittest.TestSuite()
    suiteTest.addTest(TestS("test_1_1_1"))
    return suiteTest

if __name__ == '__main__':
    evidencepath = os.path.join(os.getcwd(), "")
    filePath ='{0}'.format(TestFileName)
    fp = open(filePath,'wb')
    runner = HTMLTestReportEN.HTMLTestRunner(
        stream=fp,
        title='{}'.format(TestReportTitle),
        tester='{0}'.format(Tester)
        )
    runner.run(Suite())
    fp.close()
    time.sleep(2)












