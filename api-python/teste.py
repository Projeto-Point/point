from datetime import datetime 
from time import sleep
import random
import requests
from json import dumps 
import pymssql
import random
from datetime import datetime

serverSqlServer = 'bd-point.database.windows.net'
databaseSqlServer = 'bd-point' 
usernameSqlServer = 'adm-point' 
passwordSqlServer = '1cco#grupo1'

def inserirBanco(fkMaquina, fkComponente,data, valor):
        # Azure SQL Server
    conexaoSqlServer = pymssql.connect(server=serverSqlServer, user=usernameSqlServer, password=passwordSqlServer, database=databaseSqlServer)

    with conexaoSqlServer:
        with conexaoSqlServer.cursor() as cursor:
            cursor.execute(f"INSERT INTO Registro (fkMaquina, fkComponente, dataEhora,valor, unidadeMedida) VALUES ({fkMaquina}, {fkComponente}, '{data}', {valor}, '%')")
            
        conexaoSqlServer.commit()
        
        
        
id_maquinas = [78,87,88]

# fkMaquina fkComponente dataEhora valor unidadeDemedida
count = 0

while True:
    
    for i in id_maquinas:
        # pega o id
        for j in range(3,4):
            #pega o componente
            dia = 1
            mes = 4
            for l in range(0,300):
                # pega os dias
                if(dia == 20):
                    dia = 1
                    mes += 1
                    
                data = datetime(2022,mes,dia)  
                dia += 1

                for m in range(0,3):                    
                    numero_random = random.randrange(70,86)  
                    inserirBanco(i,j,data,numero_random)
                    count += 1
                    print(f'INSERT: {count}\nidMaquina: {i}\ndata: {data}\nvalor: {numero_random}\nfkComponente: {j}')
            



