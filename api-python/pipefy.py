import requests
import psutil
import json

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

def reportarAlerta(nome, id, mensagem):
    url = "https://api.pipefy.com/graphql"

    #teste card do pipefy com o formulário preenchido a mão. Em seguida eu vou conectar isso com o BD para pegar as infos direto da máquina do funcionário

    payload = {"query": "mutation {createCard(input: {pipe_id: 302776879,title: \"New card\",fields_attributes:[{field_id: \"qual_o_assunto_do_seu_pedido\", field_value: \"PC está superaquecendo\"},{field_id: \"email\", field_value: \"lullyfito@gmail.com\"},{field_id: \"nome_do_funcion_rio\", field_value: \"Lullyfuli\"}, {field_id: \"data_e_hora\", field_value: \"24/09/2004 08:30\"}]}) {card {title}}}"}
    headers = {
        "accept": "application/json",
        "content-type": "application/json",
        "authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjp7ImlkIjozMDIwODAyNDcsImVtYWlsIjoiYWxlc3NhbmRyYS5iYWNjaW5Ac3B0ZWNoLnNjaG9vbCIsImFwcGxpY2F0aW9uIjozMDAyMTEzMjR9fQ.TmKWl_6YGv1rP6NsBmLGSSSnmJ6_EStYHMDHN5Rmc7C1BSnsvdTlZSGq9YPpuehXdJ9qiaAfAARrt-G_11dn4g"
    }

    response = requests.post(url, json=payload, headers=headers)

    print(response.text)


print("Enviando Alerta Para Service Desk")
reportarAlerta("Máquina 1", "10053","RAM em 85%")
#testarfields()

