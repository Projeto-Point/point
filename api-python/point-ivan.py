## Esse código é da Camarada Agdas. Temos que refatorar o código python 
import os
import platform
from time import sleep
from dashing import (HSplit, VSplit, VGauge, HGauge, Text)
from psutil import (virtual_memory, cpu_percent, disk_usage, users, pids, process_iter, cpu_count)
import pymssql
import geocoder
import pymysql
import requests
from datetime import datetime, timedelta

# Credenciais da Azure
serverSqlServer = 'bd-point.database.windows.net'
databaseSqlServer = 'bd-point' 
usernameSqlServer = 'adm-point' 
passwordSqlServer = '1cco#grupo1'

# Credenciais do MySQL
databaseMySql = 'bd_point'
usernameMySql = 'root'
passwordMySql = 'urubu100'

def limpar():
    if os.name == 'posix':
        os.system("clear")
    else:
        os.system("cls")

def inserirBanco(comando):
    # Azure
    conexaoSqlServer = pymssql.connect(server=serverSqlServer, user=usernameSqlServer, password=passwordSqlServer, database=databaseSqlServer)
    
    with conexaoSqlServer:
        with conexaoSqlServer.cursor() as cursor:
            cursor.execute(comando)
        
        conexaoSqlServer.commit()

    # MySQL Local
    # comando = comando.replace('GETDATE', 'NOW')
    # conexaoMySql = pymysql.connect(db=databaseMySql, user=usernameMySql, passwd=passwordMySql)

    # with conexaoMySql:
    #     with conexaoMySql.cursor() as cursor:
    #         cursor.execute(comando)
        
    #     conexaoMySql.commit()

def consultarBanco(comando):
    comando = comando.replace('GETDATE', 'NOW')
    
    
        # Azure SQL Server
    conexaoSqlServer = pymssql.connect(server=serverSqlServer, user=usernameSqlServer, password=passwordSqlServer, database=databaseSqlServer)

    with conexaoSqlServer:
        with conexaoSqlServer.cursor() as cursor:
            cursor.execute(comando)
            return cursor.fetchall()

    # except:
    #     # MySQL Local
    #     comando = comando.replace('GETDATE', 'NOW')
    #     conexaoMySql = pymysql.connect(db=databaseMySql, user=usernameMySql, passwd=passwordMySql)

    #     with conexaoMySql:
    #         with conexaoMySql.cursor() as cursor:
    #             cursor.execute(comando)
    #             return cursor.fetchall()



def reportarAlerta(mensagem, email, nome):

    url = "https://api.pipefy.com/graphql"


    now = datetime.now()

    now = str(now)

    dt = datetime.strptime(now, '%Y-%m-%d %H:%M:%S.%f')

    somar_3_horas = dt + timedelta(hours=3)

    dt_string = somar_3_horas.strftime("%d/%m/%Y %H:%M")

    #teste card do pipefy com o formulário preenchido a mão. Em seguida eu vou conectar isso com o BD para pegar as infos direto da máquina do funcionário

    payload = {"query": "mutation {createCard(input: {pipe_id: 302776879,title: \"New card\",fields_attributes:[{field_id: \"qual_o_assunto_do_seu_pedido\", field_value: \"%s\"},{field_id: \"email\", field_value: \"%s\"},{field_id: \"nome_do_funcion_rio\", field_value: \"%s\"}, {field_id: \"data_e_hora\", field_value: \"%s\"}]}) {card {title}}}" % (mensagem, email, nome, dt_string)}

    headers = {
        "accept": "application/json",
        "content-type": "application/json",
        "authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjp7ImlkIjozMDIwODAyNDcsImVtYWlsIjoiYWxlc3NhbmRyYS5iYWNjaW5Ac3B0ZWNoLnNjaG9vbCIsImFwcGxpY2F0aW9uIjozMDAyMTEzMjR9fQ.TmKWl_6YGv1rP6NsBmLGSSSnmJ6_EStYHMDHN5Rmc7C1BSnsvdTlZSGq9YPpuehXdJ9qiaAfAARrt-G_11dn4g"
    }

    response = requests.post(url, json=payload, headers=headers)

    print(response.text)


def bytes_para_giga(value):
    return f'{value / 1024 / 1024 / 1024: .2f}'

def has_hora_passada(hora_atual, hora_ultima_notificacao):
    # 3 é a quantidade de horas que precisa passar para mandar a notificacao    
   return hora_atual >= hora_ultima_notificacao + 1
      

verificaLogin = False
verificarCadastro = False
idFuncionario = 0

while verificaLogin == False:
    limpar()

    login = input('Bem vindo ao Point! \nDigite o login do funcionário: ')
    senha = input('Digite a senha do funcionário: ')
    
    consulta = consultarBanco(f"SELECT idFuncionario, nome FROM Funcionario WHERE email = '{login}' and senha = '{senha}'")
    if(len(consulta) > 0):
        idFuncionario = consulta[0][0]
        nomeFuncionario = consulta[0][1]
        verificaLogin = True

nome = platform.node()

# Verificando se a máquina existe
consulta = consultarBanco(f"SELECT nomeMaquina FROM Maquina WHERE nomeMaquina = '{nome}' AND fkFuncionario = {idFuncionario}")

if len(consulta) == 1:
    print("Esta máquina já está cadastrada")
else:
    print("Cadastrando máquina...")

    memoriaTotal = bytes_para_giga(virtual_memory().total)
    discoTotal = bytes_para_giga(disk_usage("/").total)
    
    inserirBanco(f"INSERT INTO Maquina (sistemaOperacional, nomeMaquina, tipo, fkFuncionario) VALUES ('{platform.system()}', '{platform.node()}', 'Servidor', {idFuncionario})")

    consulta = consultarBanco(f"SELECT idMaquina FROM Maquina WHERE nomeMaquina = '{nome}' AND fkFuncionario = {idFuncionario}")
    idMaquina = consulta[0][0]

    # Inserindo componentes
    inserirBanco(f"INSERT INTO Componente (idComponente, fkMaquina, tipo) VALUES (1, {idMaquina}, 'CPU')")
    inserirBanco(f"INSERT INTO Componente (idComponente, fkMaquina, tipo) VALUES (2, {idMaquina}, 'RAM')")
    inserirBanco(f"INSERT INTO Componente (idComponente, fkMaquina, tipo) VALUES (3, {idMaquina}, 'Disco')")

    # Inserindo atributo dos componentes
    inserirBanco(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES ('CORE', {cpu_count(logical=False)}, 'unidade', {idMaquina}, 1)")
    inserirBanco(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES ('THREADS', {cpu_count(logical=True)}, 'unidade', {idMaquina}, 1)")
    inserirBanco(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES ('Tamanho', {memoriaTotal}, 'GB', {idMaquina}, 2)")
    inserirBanco(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES ('Tamanho', {discoTotal}, 'GB', {idMaquina}, 3)")

consulta = consultarBanco(f"SELECT idMaquina FROM Maquina WHERE nomeMaquina = '{nome}' AND fkFuncionario = {idFuncionario}")
idMaquina = consulta[0][0]

# Inserindo entrada com localização
ip = geocoder.ip('me')
inserirBanco(f"INSERT INTO Localizacao (acao, dataEhora, ipAdress, longitude, latitude, cidade, pais, fkMaquina) VALUES ('E', GETDATE(), '{ip.ip}', {ip.latlng[0]}, {ip.latlng[1]}, '{ip.city}', '{ip.country}', {idMaquina})")

# Personalizando o terminal 
ui = HSplit(
    VSplit(
        Text(
             ' ',
            border_color=9,
            color=7,
            title='Informações da máquina'
        ),
    ),
    VSplit(  # ui.items[1]
        HGauge(title='CPU %'),
        HGauge(title='cpu_0'),
        HGauge(title='cpu_1'),
        HGauge(title='cpu_2'),
        HGauge(title='cpu_3'),
        title='CPU',
            border_color=5,
    ),
    VSplit(  # ui.items[2]
        HSplit(  # ui.items[0]
            HGauge(title='RAM'),  # ui.items[2].items[0]
            title='Memória',
            border_color=3
        ),
        HSplit(
            HGauge(title='Disco'),
            title='Disco',
            border_color=6,
        ),
    ),
)


arr_componentes_alertas = []
is_primeira_hora = True
while True:
#     #Memória RAM
    mem_tui = ui.items[2].items[0]
    ram_tui = mem_tui.items[0]
    ram_tui.value = virtual_memory().percent
    ram_tui.title = f'RAM {ram_tui.value} %'

    # Uso CPU em %
    cpu_tui = ui.items[1]
    cpu_percent_tui = cpu_tui.items[0]
    ps_cpu_percent = cpu_percent()
    cpu_percent_tui.value = ps_cpu_percent
    cpu_percent_tui.title = f'CPU Total {ps_cpu_percent}%'

    # Dizendo o core + uso em %
    cores_tui = cpu_tui.items[1:9]
    ps_cpu_percent = cpu_percent(percpu=True)
    for i, (core, value) in enumerate(zip(cores_tui, ps_cpu_percent)):
        core.value = value
        core.title = f'Core_{i} {value}%'
    
    # Informações da máquina
    outros_tui = ui.items[0].items[0]
    outros_tui.text = ''
    
    # boot = datetime.fromtimestamp(boot_time()).strftime("%Y-%m-%d %H:%M:%S")
    # outros_tui.text += f'\nHorário do boot: {boot}'
    outros_tui.text += f'Nome da máquina: {platform.node()}'
    outros_tui.text += f'\nUsuário: {users()[0].name}'
    outros_tui.text += f'\n\nSistema operacional: {platform.system()}'
    outros_tui.text += f'\n\nQuantidade de processos: {len(pids())}'
    
    # Disco - Porcentagem de memória ocupada do disco
    disk_tui = ui.items[2].items[1].items[0]
    disk_tui.value = disk_usage("/").percent
    disk_tui.text = ''
    disk_tui.title = f'Disco {disk_tui.value}%'

    # Tempo real
    agora = datetime.now()
    agora_string = agora.strftime("%A %d %B %y %I:%M")

    agora_datetime = datetime.strptime(agora_string, "%A %d %B %y %I:%M")

    porc_cpu = cpu_percent(interval=0.1)
    porc_ram = virtual_memory().percent
    porc_disco = disk_usage('/').percent   
  
        
    if porc_cpu > 80 and 'CPU' not in arr_componentes_alertas:
        reportarAlerta(f"CPU está com {porc_cpu}%!", login, nomeFuncionario)
        arr_componentes_alertas.append('CPU')
    if porc_ram > 85 and 'RAM' not in arr_componentes_alertas:
        reportarAlerta(f"Ram está com {porc_ram}%!", login, nomeFuncionario)
        arr_componentes_alertas.append('RAM')
    if porc_disco > 90 and 'Disco' not in arr_componentes_alertas:
        reportarAlerta(f"Disco está com {porc_disco}%!", login, nomeFuncionario)
        arr_componentes_alertas.append('Disco')
        
    
    if is_primeira_hora:
        ultima_hora = agora
        is_primeira_hora = False
        
    if has_hora_passada(agora.hour, ultima_hora.hour):
        arr_componentes_alertas.clear()
        ultima_hora = agora

    inserirBanco(f"INSERT INTO Registro (valor, unidadeMedida, dataEhora, fkComponente, fkMaquina) VALUES ({porc_cpu}, '%', GETDATE(), 1, {idMaquina})")

    inserirBanco(f"INSERT INTO Registro (valor, unidadeMedida, dataEhora, fkComponente, fkMaquina) VALUES ({porc_ram}, '%', GETDATE(), 2, {idMaquina})")

    inserirBanco(f"INSERT INTO Registro (valor, unidadeMedida, dataEhora, fkComponente, fkMaquina) VALUES ({porc_disco}, '%', GETDATE(), 3, {idMaquina})")

    #Mostrar os dados de 3 em 3 segundos
    try:
        ui.display()
        sleep(3)
    except KeyboardInterrupt:
        # Inserindo saída com localização
        inserirBanco(f"INSERT INTO Localizacao (acao, dataEhora, ipAdress, longitude, latitude, cidade, pais, fkMaquina) VALUES ('S', GETDATE(), '{ip.ip}', {ip.latlng[0]}, {ip.latlng[1]}, '{ip.city}', '{ip.country}', {idMaquina})")
        break