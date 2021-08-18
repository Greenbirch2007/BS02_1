# coding:utf-8
import yaml
import os
# 作者：上海-悠悠 交流QQ群：588402570

# 获取当前脚本所在文件夹路径
curPath = os.path.dirname(os.path.realpath(__file__))
# 获取yaml文件路径
yamlPath = os.path.join(curPath, "t.yaml")

# open方法打开直接读出来
f = open(yamlPath, 'r', encoding='utf-8')
cfg = f.read()
print(cfg)

d = yaml.load(cfg, Loader=yaml.FullLoader)
print(d["user"])
print(d["psw"])
