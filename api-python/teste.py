from datetime import datetime 
from time import sleep
import random
import requests
from json import dumps 


webhook = "https://hooks.slack.com/services/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"

nomeFuncionario = 'Pedro'

mensagem = { "text" : "A CPU do funcionario " + str(nomeFuncionario) + " está acima do comum"}

print(requests.post(webhook, data=dumps(mensagem)))

