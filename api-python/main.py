import psutil
import pymysql
from time import sleep
    
contador = 1
while True:
    conexao = pymysql.connect(db='BDpoint', user='root', passwd='#Gf45297661870')
    cursor = conexao.cursor()
    
    cursor.execute(f"INSERT INTO Registro VALUES (null, {psutil.cpu_percent()}, '%', now(), 1)")
    conexao.commit()

    conexao.close()

    print(f'Registro {contador} inserido!')
    contador += 1
    sleep(1)

    

