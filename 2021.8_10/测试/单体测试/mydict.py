


class MyDict(dict):
    def __init__(self,**kwargs):
        super().__init__(**kwargs)
    def put(self,key,value):
        self[key] = value
    def get(self,key):
        return self[key]
