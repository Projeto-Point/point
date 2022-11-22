from datetime import datetime 
from time import sleep
import random

def has_hora_passada(hora_atual, hora_ultima_notificacao):
    # 3 é a quantidade de horas que precisa passar para mandar a notificacao    
   return hora_atual >= hora_ultima_notificacao + 1
      
      

is_primeira_hora = True
arr_componentes_alertas = []
while True:
    
    sleep(1)
    
    
    agora = datetime.now()
    
    if is_primeira_hora:
        ultima_hora = agora
        is_primeira_hora = False
        
        
    randCPU = random.randint(79,81)
    randRam = random.randint(83,86)
    randDisco = random.randint(88,91)
    if randCPU > 80 and 'CPU' not in arr_componentes_alertas:
        print('foi CPU')
        arr_componentes_alertas.append('CPU')
    if randRam > 85 and 'RAM' not in arr_componentes_alertas:
        print('foi RAM')
        arr_componentes_alertas.append('RAM')
    if randDisco > 90 and 'Disco' not in arr_componentes_alertas:
        print('foi Disco')
        arr_componentes_alertas.append('Disco')

        
    if has_hora_passada(agora.minute, ultima_hora.minute):
        arr_componentes_alertas.clear()
        ultima_hora = agora 
    


# import json
# import urllib.request as urllib2


# def get_webcrawler():
    
#     url = 'http://ipinfo.io/json'
#     response = urllib2.urlopen(url)
#     data = json.load(response)
    
#     return data

# def get_ip_address():
#     return get_webcrawler()['ip']

# def get_city():
#     return get_webcrawler()['city']

# def get_country():
#     return get_webcrawler()['country']  

# def coordinates():

#     coordinates_string = get_webcrawler()['loc']
#     coordinates_split = coordinates_string.split(',')
#     return coordinates_split

# def get_latitude():
#     return coordinates()[0]

# def get_longitude():
#     return coordinates()[1]
        

# print(get_ip_address())
# print(get_city())
# print(get_country())
# print(get_latitude())
# print(get_longitude())



