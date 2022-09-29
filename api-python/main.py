import psutil
import pymysql
from time import sleep

def registro():
    conexao = pymysql.connect(db='BDpoint', user='root', passwd='1234', port=3307)
    cursor = conexao.cursor()
    
    cursor.execute(f"INSERT INTO Registro VALUES (null, {psutil.cpu_percent()}, '%', now(), 1)")
    conexao.commit()

    conexao.close()

while True:
    registro()
    sleep(1)