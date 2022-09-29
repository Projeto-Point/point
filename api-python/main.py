import psutil
import pymysql
from time import sleep
    
contador = 1
while True:
    conexao = pymysql.connect(db='BDpoint', user='root', passwd='1234', port=3307)
    cursor = conexao.cursor()
    
    cursor.execute(f"INSERT INTO Registro VALUES (null, {psutil.cpu_percent()}, '%', now(), 1)")
    conexao.commit()

    conexao.close()

    print(f'Registro {contador} inserido!')
    contador += 1
    sleep(1)