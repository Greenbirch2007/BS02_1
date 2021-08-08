


# -*- coding:utf-8 -*-
import requests
import json
import base64





if __name__=="__main__":
    data = {}
    data["user_id"] = "10000000"
    passwd_1 = "tesatasfawerwawe"
    passwd_ = base64.b64encode(passwd_1.encode("utf-8"))
    data["passwd"] = str(passwd_)
    url = "http://127.0.0.1:8989/"
    headers = {'Content-Type': 'application/json'}
    r = requests.post(url=url, headers=headers, data=json.dumps(data))
    print(r.text)



