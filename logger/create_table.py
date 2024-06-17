from config.postegresSQL import PostegresHelper
from dotenv import load_dotenv
import os

load_dotenv()

username = os.environ["username"]
password = os.environ["password"]
dbname = os.environ["dbname"]
host = os.environ["host"]


def created_table():
    pg = PostegresHelper(username,password,host,dbname)

    pg.executeInsert("CREATE TABLE IF NOT EXISTS logs (topic TEXT, level TEXT, logTime timestamp, message TEXT, source TEXT)")