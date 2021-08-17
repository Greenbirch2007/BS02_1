#
#
# import datetime
#
# def log(func):
#
#
#     def inner(*args,**kwargs):
#
#         timestamp = datetime.datetime.now().strftime("%y-%m-%d %H:%M:%S")
#         rep = func(*args,**kwargs)
#         print(f"[{timestamp}]({func.__name__}){args}->{rep}")
#         return rep
#     return inner
#
#
#
# @log
# def pluser(a,b):
#     return a+b
#
#
# print(pluser(1,2))


import logging

logger = logging.getLogger(__name__)
logger.setLevel("DEBUG")

formatter = logging.Formatter("%(asctime)s - [%(levelname)s] - %(message)s")
chlr = logging.StreamHandler()

chlr.setFormatter(formatter)
