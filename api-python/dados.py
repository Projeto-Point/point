from pickle import TRUE

# Fazer a conexão com SQL 
import pymysql
# datetime é para pegar as datas e as horas com precisão exata e conseguir fazer contasa 
import datetime

# Pega os dados do sistema exemplo sistema operacional da máquina
import os

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
    process_iter
)

# Verifica se é Windowns ou Linux 
def limpar():
    #Linux
    if os.name == 'posix':
        os.system("clear")
    #Windowns
    else:
        os.system("cls")

verificaLogin = TRUE

while verificaLogin == False:
    #Chama a função limpar
    limpar()

    login = input('Bem vindo ao Point! \n Digite o login do funcionário: ')
    senha = input('Digite a senha do funcionário: ')

    # Conecta com o banco, passando o usuário, e o banco desejado
    conexao = pymysql.connect(db='BDpoint', user='aluno', passwd='sptech')

    # AGDDAAAAA
    cursor = conexao.cursor()
    
    #Executa o comando no banco que foi conectado 
    verificaLogin = cursor.execute(("select email, senha from funcionario where email = '{}' and senha = {}").format(login, senha))

    # AGDAAAAAAA
    conexao.commit()

    #Encerra o processo
    conexao.close()


# Converte de bytes para giga 
def bytes_para_giga(value):
    return value / 1024 / 1024 / 1024

# Personaliza o terminal 

ui = HSplit(  # ui
    VSplit(
        Text(
            ' ',
            border_color=9,
            title='Processos'
        ),
        HSplit(  # ui.items[0]
            VGauge(title='RAM'),  # ui.items[0].items[0]
            title='Memória',
            border_color=3
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
        Text(
            ' ',
            title='Outros',
            border_color=4
        ),
        Text(
            ' ',
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
    mem_tui = ui.items[0].items[1]
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
    
    # User + Bateria + Boot + Contagens de processos no PC
    outros_tui = ui.items[2].items[0]
    outros_tui.text = ''
    outros_tui.text += f'\nUsuário: {users()[0].name}'
    # outros_tui.text += f'\nBateria: {sensors_battery().percent}%'
    # boot = datetime.fromtimestamp(boot_time()).strftime("%Y-%m-%d %H:%M:%S")
    # outros_tui.text += f'\nHorário do boot: {boot}'
    outros_tui.text += f'\nProcessos: {len(pids())}'
    
    # Disco - Porcentagem de memória ocupada do disco
    disk_tui = ui.items[2].items[1]
    disk_tui.text = ''
    disk_tui.text += f'\nEspaço em disco utilizado: {disk_usage("/").percent}%'

    # Tempo real

    agora = datetime.datetime.now()

    agora_string = agora.strftime("%A %d %B %y %I:%M")

    agora_datetime = datetime.datetime.strptime(agora_string, "%A %d %B %y %I:%M")

    # Conexão BD

    conexao = pymysql.connect(db='BDpoint', user='ivanfm', passwd='')

    cursor = conexao.cursor()

    # cursor.execute("select idDispositivo from dispositivo join funcionario as func on dispositivo.fkFuncionario = func.idFuncionario join empresa on idEmpresa = func.fkEmpresa join funcionario as gestor on gestor.idFuncionario = func.fkGestor where func.email = '{}'".format(login))

    # identificador = cursor.fetchall()

    cursor.execute("INSERT INTO dados (idDados, usoRAM, usoCPU, usoDiscoLocal, fkDispositivo, dataEhora) VALUES (null, {}, {}, {}, {}, '{}')".format(ram_tui.value, cpu_percent_tui.value, disk_usage("/").percent, identificador[0][0], agora_datetime))

    conexao.commit()

    conexao.close()

    #Mostrar os dados de 3 em 3 segundos

    try:
         ui.display()
         sleep(3.00)
    except KeyboardInterrupt:
         break
