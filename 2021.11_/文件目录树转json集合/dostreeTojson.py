# import os
#
# import json
#
#
# def gci(filepath):
# #遍历filepath下所有文件，包括子目录
#   files = os.listdir(filepath)
#   for fi in files:
#     fi_d = os.path.join(filepath,fi)
#     if os.path.isdir(fi_d):
#       gci(fi_d)
#     else:
#       tree_list.append(os.path.join(filepath,fi_d))
#
# #递归遍历/root目录下所有文件
#
#
#
#
# # 1. 先生成文件目录的列表
# # 2. 把文件目录的列表塞进json里面
#
# if  __name__ == "__main__":
#     tree_list = []
#     # tree_list = ['v1/init/time,get', 'v1/order,get', 'v1/surface/detail,post_get', 'v1/surface/order,post', 'v1/surface/user,post', 'v1/user,get', 'v2/country,put', 'v2/list,put', 'v3/languages,get', 'v3/surface/detail,delete', 'v3/surface/list,delete', 'v3/user,get']
#
#
# #{"v1": {"init": {"time": "get"}, "order": "get", "surface": {"detail": "post_get", "order": "post", "user": "post"}, "user": "get"}, "v2": {"country": "put", "list": "put"}, "v3": {"languages": "get", "surface": {"detail": "delete", "list": "delete"}, "user": "get"}}
#
#
#     gci('E:\\dt')
#     print(tree_list)
#
#
#     temp = {}
#     for api in tree_list:
#         temp_split = api.split('\\')
#         temp_str = temp_split[1]
#         temp_api = {temp_str[0]: temp_str[1]}
#         if temp_split[0] not in temp:
#             temp[temp_split[0]] = temp_api
#         else:
#             temp[temp_split[0]].update(temp_api)
#
#
#
#
#
#
#
#     str_json = json.dumps(temp)
#     print(str_json)
#
#
#
#
#



# data = ["1. abc", "2. afd", "3.ad", "4. ajh", "1. fc", "2. acxcf",
# "3. fcacxi", "1.acxcf", "2. rrr", "1. acxcf", "2.rrr", "1.adsfdd", "2.acxcfxxc"]
#
# lst = []
# for item in data:
#     lst.append(item.split("."))
lst = [['1', ' abc'], ['2', ' afd'], ['3', 'ad'], ['4', ' ajh'], ['1', ' fc'], ['2', ' acxcf'], ['3', ' fcacxi'], ['1', 'acxcf'], ['2', ' rrr'], ['1', ' acxcf'], ['2', 'rrr'], ['1', 'adsfdd'], ['2', 'acxcfxxc']]



from collections import defaultdict

d = defaultdict(list)
from functools import reduce



for k, *v in lst:
    d[k].append(v)


# [[' abc'], [' fc'], ['acxcf'], [' acxcf'], ['adsfdd']]
# [[' afd'], [' acxcf'], [' rrr'], ['rrr'], ['acxcfxxc']]
# [['ad'], [' fcacxi']]
# [[' ajh']]


for item in list(d.items()):
    print(item[0],[".".join(x) for x in item[1:][0]])





