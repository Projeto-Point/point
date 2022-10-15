# Fazer a conexão com SQL 
from pickle import NONE
import pymysql
# datetime é para pegar as datas e as horas com precisão exata e conseguir fazer contasa 
import datetime

# Pega os dados do sistema exemplo sistema operacional da máquina
import os
import platform

# Faz uma pausa no código
from time import sleep

from dashing import (
    HSplit, 
    VSplit, 
    VGauge, 
    HGauge, 
    Text
)

# Pega os dados das máquina 
from psutil import (
    # Pega os dados da memória virtual (ram)
    virtual_memory,
    # Porcentagem de uso do processador
    cpu_percent,
    # Uso de disco
    disk_usage,
    # Pega uma lista dos usuários
    users,
    # return os processos que estão sendo executados
    pids,
    # Mostra todos os processos que foram executados desde o boot da máquina  e o pid
    process_iter,
)

# Verifica se é Windowns ou Linux 
def limpar():
    #Linux
    if os.name == 'posix':
        os.system("clear")
    #Windowns
    else:
        os.system("cls")

verificaLogin = False

cadastrarMaquina = False

verificarCadastro = False

while verificaLogin == False:
    #Chama a função limpar
    limpar()

    login = input('Bem vindo ao Point! \nDigite o login do funcionário: ')
    senha = input('Digite a senha do funcionário: ')

    # Conecta com o banco, passando o usuário, e o banco desejado
    conexao = pymysql.connect(db='bd_point', user='root', passwd='GuilhermeAugusto123')

    # AGDDAAAAA
    cursor = conexao.cursor()
    
    #Executa o comando no banco que foi conectado 
    verificaLogin = cursor.execute(("SELECT email, senha FROM Funcionario WHERE email = '{}' and senha = '{}'").format(login, senha))

    #Encerra o processo
    conexao.close()



nome = platform.node()
conexao = pymysql.connect(db='bd_point', user='root', passwd='GuilhermeAugusto123')
cursor = conexao.cursor()
verificarCadastro = cursor.execute(("SELECT nomeMaquina FROM Maquina WHERE nomeMaquina = '{}'").format(nome))

resultado = cursor.fetchall()

conexao.close()

if verificarCadastro != 0:
    print("Esta máquina já está cadastrada")
else:

    print("Cadastro feito")
    

    def bytes_para_giga(value):
        return f'{value / 1024 / 1024 / 1024: .2f}'


    memoriaTotal = bytes_para_giga(virtual_memory().total)
    discoTotal = bytes_para_giga(disk_usage("/").total)

    conexao = pymysql.connect(db='bd_point', user='root', passwd='GuilhermeAugusto123')

    cursor = conexao.cursor()

    fkFuncionario = cursor.execute((f"""SELECT idFuncionario FROM Funcionario WHERE email = '{login}' and senha = '{senha}'"""))

    
    cursor.execute(f"""INSERT INTO Maquina VALUES (null, '{platform.system()}', '{platform.node()}', null, {fkFuncionario})""")
    
    id = cursor.execute((f"""SELECT idMaquina FROM Maquina WHERE nomeMaquina = '{nome}'"""))
    
    idComponente = cursor.execute((f"SELECT max(C.idComponente) as id FROM Componente C INNER JOIN Maquina M ON M.idMaquina = C.fkMaquina WHERE idMaquina = {id}"))

    conexao.commit()
    try:
        cursor.execute(f"INSERT INTO Componente (idComponente, fkMaquina, tipo) VALUES (1, {id}, 'CPU')")

        cursor.execute(f"""INSERT INTO Componente (idComponente, fkMaquina, tipo) VALUES (2, {id}, 'MemóriaRam')""")

        cursor.execute(f"""INSERT INTO Componente (idComponente, fkMaquina, tipo) VALUES (3, {id}, 'Disco')""")
        
        fkComponenteCpu = cursor.execute((f"SELECT idComponente FROM Componente WHERE tipo = 'CPU' and idComponente = {id}"))
        fkComponenteRam = cursor.execute((f"SELECT idComponente FROM Componente WHERE tipo = 'MemóriaRam' and idComponente = {id}"))
        fkComponenteDisco = cursor.execute((f"SELECT idComponente FROM Componente WHERE tipo = 'Disco' and idComponente = {id}"))

        cursor.execute(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES (null, {memoriaTotal}, 'GB', {id}, {fkComponenteRam})")
        cursor.execute(f"INSERT INTO Atributo (atributo, valor, unidadeMedida, fkMaquina, fkComponente) VALUES (null, {discoTotal}, 'GB', {id}, {fkComponenteDisco})")
    
        conexao.commit()
        conexao.close()
    except:
        print("f no chat")
    
# Converte de bytes para giga 
def bytes_para_giga(value):
    return value / 1024 / 1024 / 1024

# Personaliza o terminal 

ui = HSplit(  # ui
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
    
    #Processos
    #Pega os processos que foram executados na máquina e coloca na caixa [0] do terminal 
    proc_tui = ui.items[0].items[0]
    p_list = []
    #mostra todos os processos
    for proc in process_iter():
        proc_info = proc.as_dict(['name', 'cpu_percent'])
        if proc_info['cpu_percent'] > 0:
            p_list.append(proc_info)

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

    # Conexão BD

    conexao = pymysql.connect(db='bd_point', user='root', passwd='GuilhermeAugusto123')

    cursor = conexao.cursor()

    cursor.execute(f"SELECT idMaquina FROM Maquina INNER JOIN Funcionario ON fkFuncionario = idFuncionario WHERE email = '{login}'")
    
    identificador = cursor.fetchall()
    try:
        idComponente = cursor.execute((f"SELECT max(C.idComponente) as id FROM Componente C INNER JOIN Maquina M ON M.idMaquina = C.fkMaquina WHERE idMaquina = {id}"))

        fkComponenteCpu = cursor.execute((f"SELECT idComponente FROM Componente WHERE tipo = 'CPU' and idComponente = 1"))
        fkComponenteRam = cursor.execute((f"SELECT idComponente FROM Componente WHERE tipo = 'MemóriaRAM' and idComponente = 2"))
        fkComponenteDisco = cursor.execute((f"SELECT idComponente FROM Componente WHERE tipo = 'Disco' and idComponente = 3"))


        cursor.execute(f"INSERT INTO Registro (valor, unidadeMedida, dataEhora, fkComponente, fkMaquina) VALUES ({cpu_percent()}, '%', NOW(), {fkComponenteCpu}, {id})")

        cursor.execute(f"INSERT INTO Registro (valor, unidadeMedida, dataEhora, fkComponente, fkMaquina) VALUES ({virtual_memory().percent}, '%', NOW(), {fkComponenteRam}, {id})")

        cursor.execute(f"INSERT INTO Registro (valor, unidadeMedida, dataEhora, fkComponente, fkMaquina) VALUES ({disk_usage('/').percent}, '%', NOW(), {fkComponenteDisco}, {id})")

        conexao.commit()

        conexao.close()
    except:
        print("F no chat aki")

    #Mostrar os dados de 3 em 3 segundos

    try:
        ui.display()
        sleep(0.50)
    except KeyboardInterrupt:
        break