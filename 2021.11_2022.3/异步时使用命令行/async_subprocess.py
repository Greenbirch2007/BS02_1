
import subprocess

def use_subprocess_command(command_string):


    process = subprocess.Popen(command_string, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    process.wait()
    command_output = process.stdout.read().decode('utf-8')
    # command_output:str
    return command_output
# 可以选择不输出命令行报错！ 写入日志里面
use_subprocess_command("ls")