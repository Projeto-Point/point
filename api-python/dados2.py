## Esse código é da Camarada Agdas. Temos que refatorar o código python 
import datetime
import os
import platform
from time import sleep
from dashing import (HSplit, VSplit, VGauge, HGauge, Text)
from psutil import (virtual_memory, cpu_percent, disk_usage, users, pids, process_iter, cpu_count)
import pymssql
import geocoder

# print(geocoder.ip("me").city)
# print(geocoder.ip("me").country)

def limpar():
    if os.name == 'posix':
        os.system("clear")
    else:
        os.system("cls")

server = 'bd-point.database.windows.net'
database = 'bd-point' 
username = 'adm-point' 
password = '1cco#grupo1'

conn = pymssql.connect(server=server, user=username, password=password, database=database)
cursor = conn.cursor()

verificaLogin = False
verificarCadastro = False

while verificaLogin == False:
    limpar()

    login = input('Bem vindo ao Point! \nDigite o login do funcionário: ')
    senha = input('Digite a senha do funcionário: ')
    
    nomeFuncionario = cursor.execute(("SELECT nome FROM Funcionario WHERE email = '{}' and senha = '{}'").format(login, senha))
    if(len(cursor.fetchall()) > 0):
        verificaLogin = True

nome = platform.node()

verificarCadastro = cursor.execute(("SELECT nomeMaquina FROM Maquina WHERE nomeMaquina = '{}'").format(nome))
resultado = cursor.fetchall()

if len(resultado) == 1:
    print("Esta máquina já está cadastrada")
else:
    print("Cadastro feito")

    def bytes_para_giga(value):
        return f'{value / 1024 / 1024 / 1024: .2f}'


    memoriaTotal = bytes_para_giga(virtual_memory().total)
    discoTotal = bytes_para_giga(disk_usage("/").total)

    cursor.execute((f"""SELECT idFuncionario FROM Funcionario WHERE email = '{login}' and senha = '{senha}'"""))

    fkFuncionario = cursor.fetchall()[0][0]
    
    cursor.execute(f"""INSERT INTO Maquina (sistemaOperacional, nomeMaquina, tipo, fkFuncionario) VALUES ('{platform.system()}', '{platform.node()}', 'Servidor', {fkFuncionario})""")

    cursor.execute((f"""SELECT idMaquina FROM Maquina WHERE nomeMaquina = '{nome}'"""))
    id = cursor.fetchall()[0][0]

    conn.commit()

    # Inserindo componentes
    cursor.execute(f"INSERT INTO Componente (idComponente, fkMaquina, tipo) VALUES (1, {id}, 'CPU')")
    cursor.execute(f"""INSERT INTO Componente (idComponente, fkMaquina, tipo) VALUES (2, {id}, 'RAM')""")
    cursor.execute(f"""INSERT INTO Componente (idComponente, fkMaquina, tipo) VALUES (3, {id}, 'Disco')""")

    # Inserindo atributo dos componentes
    cursor.execute(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES ('CORE', {cpu_count(logical=False)}, 'unidade', {id}, 1)")
    cursor.execute(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES ('THREADS', {cpu_count(logical=True)}, 'unidade', {id}, 1)")
    cursor.execute(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES ('Tamanho', {memoriaTotal}, 'GB', {id}, 2)")
    cursor.execute(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES ('Tamanho', {discoTotal}, 'GB', {id}, 3)")

    conn.commit()

# Inserindo entrada com localização
cursor.execute((f"""SELECT idMaquina FROM Maquina WHERE nomeMaquina = '{nome}'"""))
idMaquina = cursor.fetchall()[0][0]

ip = geocoder.ip('me')
cursor.execute(f"INSERT INTO Localizacao (acao, dataEhora, ipAdress, longitude, latitude, cidade, pais, fkMaquina) VALUES ('E', GETDATE(), '{ip.ip}', {ip.latlng[0]}, {ip.latlng[1]}, '{ip.city}', '{ip.country}', {idMaquina})")

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
while True:
    # #Processos
    # #Pega os processos que foram executados na máquina e coloca na caixa [0] do terminal 
    # proc_tui = ui.items[0].items[0]
    # p_list = []
    # #mostra todos os processos
    # for proc in process_iter():
    #     proc_info = proc.as_dict(['name', 'cpu_percent'])
    #     if proc_info['cpu_percent'] > 0:
    #         p_list.append(proc_info)

    #Memória RAM
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
    agora = datetime.datetime.now()
    agora_string = agora.strftime("%A %d %B %y %I:%M")

    agora_datetime = datetime.datetime.strptime(agora_string, "%A %d %B %y %I:%M")

    # Banco de dados
    cursor.execute((f"""SELECT idMaquina FROM Maquina WHERE nomeMaquina = '{nome}'"""))

    id = cursor.fetchall()[0][0]
    
    try:
        cursor.execute(f"INSERT INTO Registro (valor, unidadeMedida, dataEhora, fkComponente, fkMaquina) VALUES ({cpu_percent(interval=0.1)}, '%', GETDATE(), 1, {id})")

        cursor.execute(f"INSERT INTO Registro (valor, unidadeMedida, dataEhora, fkComponente, fkMaquina) VALUES ({virtual_memory().percent}, '%', GETDATE(), 2, {id})")

        cursor.execute(f"INSERT INTO Registro (valor, unidadeMedida, dataEhora, fkComponente, fkMaquina) VALUES ({disk_usage('/').percent}, '%', GETDATE(), 3, {id})")

        conn.commit()

    except:
        print("F no chat aki")

    #Mostrar os dados de 3 em 3 segundos
    try:
        ui.display()
        sleep(3)
    except KeyboardInterrupt:
        # Inserindo entrada com localização
        cursor.execute((f"SELECT idMaquina FROM Maquina WHERE nomeMaquina = '{nome}'"))
        idMaquina = cursor.fetchall()[0][0]

        cursor.execute(f"INSERT INTO Localizacao (acao, dataEhora, ipAdress, longitude, latitude, cidade, pais, fkMaquina) VALUES ('S', GETDATE(), '{ip.ip}', {ip.latlng[0]}, {ip.latlng[1]}, '{ip.city}', '{ip.country}', {idMaquina})")
        conn.commit()

        conn.close()
        break