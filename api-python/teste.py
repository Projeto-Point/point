from datetime import datetime 
from time import sleep
import random
import requests
from json import dumps 
import pymssql


serverSqlServer = 'bd-point.database.windows.net'
databaseSqlServer = 'bd-point' 
usernameSqlServer = 'adm-point' 
passwordSqlServer = '1cco#grupo1'

def consultarBanco(comando):
        # Azure SQL Server
    conexaoSqlServer = pymssql.connect(server=serverSqlServer, user=usernameSqlServer, password=passwordSqlServer, database=databaseSqlServer)

    with conexaoSqlServer:
        with conexaoSqlServer.cursor() as cursor:
            cursor.execute(comando)
            return cursor.fetchall()

def has_alerta_por_componente(componente):
    x = consultarBanco(f"SELECT TOP 1 resolucao,idAlerta FROM Alerta WHERE fkMaquina = 12 and componente like '{componente}' ORDER BY dataEhora DESC;")
    if len(x) > 0:
        return [x[0][0], x[0][1]]
    else:
        return [0,0]
    

print(has_alerta_por_componente('CPU')[0])