import requests
import psutil
import json
import email
from datetime import datetime, timedelta


def testarfields():
    url = "https://api.pipefy.com/graphql"

    payload = {"query":"{ allCards(pipeId:302754703){ pageInfo{ endCursor hasNextPage } edges{ node{ id title fields{ value } assignees{ email } phases_history{ duration firstTimeIn created_at phase{ name } } } } } }"}
    #payload = {"query": "{pipe(id:302776879){phases{id,name,fields{id}}}}"}
    headers = {
        "accept": "application/json",
        "content-type": "application/json",
        "authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjp7ImlkIjozMDIwODAyNDcsImVtYWlsIjoiYWxlc3NhbmRyYS5iYWNjaW5Ac3B0ZWNoLnNjaG9vbCIsImFwcGxpY2F0aW9uIjozMDAyMTEzMjR9fQ.TmKWl_6YGv1rP6NsBmLGSSSnmJ6_EStYHMDHN5Rmc7C1BSnsvdTlZSGq9YPpuehXdJ9qiaAfAARrt-G_11dn4g"
    }

    response = requests.post(url, json=payload, headers=headers)

    print(response.text)





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


print("Enviando Alerta Para Service Desk")
reportarAlerta("80% RAM", "agdaTaniguchi@gmail.com", "Agda Tani")


#testarfields()

