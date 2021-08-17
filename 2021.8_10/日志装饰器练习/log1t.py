

import datetime

def log(func):


    def inner(*args):
        timestamp = str(datetime.datetime.now()).split(".")[0]
        res = func(*args)
        print(f"[{timestamp}] ({func.__name__}){args}--->{res}")
        return res
    return inner


@log
def pluser(a,b):
    return a+b


print(pluser(1,2))