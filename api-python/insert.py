import psutil
import pymysql
import time

def insetzada():

    cpu_percent = psutil.cpu_percent()
    ram_percent = psutil.virtual_memory().percent
    disc = psutil.disk_usage("/").percent


    conexao = pymysql.connect(db='BDpoint', user='root', passwd='#Gf45297661870', port=3306)

    cursor = conexao.cursor()

    cursor.execute(f"INSERT INTO dados (idDados, usoRAM, usoCPU, usoDiscoLocal) VALUES (null, {cpu_percent}, {ram_percent}, {disc})")

    conexao.commit()

    conexao.close()


def topProcessos():
    # Sorted faz a função 
    ordenados = sorted(
        key=lambda p: p['cpu_percent'],
        reverse=True
    )[:10]
 
