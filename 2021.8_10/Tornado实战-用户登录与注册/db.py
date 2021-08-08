from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker



HOSTNAME = '127.0.0.1'
PORT = '3306'  #注意这个不是本地端口是指远程数据库端口，因为pycharm已经先SSH连接到本地了
DATABASE = 'my_db'
USERNAME = 'root'
PASSWORD = '1q2w3e4r'

db_url = 'mysql+pymysql://{}:{}@{}:{}/{}?charset=utf8'.format(
    USERNAME,
    PASSWORD,
    HOSTNAME,
    PORT,
    DATABASE
)


#连接数据库
engine = create_engine(db_url)

Base = declarative_base(bind = engine)  #这个基类是维系类和数据表关系的目录。

#在对表数据进行增删改查之前，先需要建立会话，建立会话之后才能进行操作，就类似于文件要打开之后才能对文件内容操作。
Session = sessionmaker(engine)
session = Session()