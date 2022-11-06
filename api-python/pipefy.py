import requests
import psutil
import json

def testarfields():
    url = "https://api.pipefy.com/graphql"

    payload = {"query": "{pipe(id:302776879){phases{id,name,fields{id}}}}"}
    headers = {
        "accept": "application/json",
        "content-type": "application/json",
        "authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjp7ImlkIjozMDIwODAyNDcsImVtYWlsIjoiYWxlc3NhbmRyYS5iYWNjaW5Ac3B0ZWNoLnNjaG9vbCIsImFwcGxpY2F0aW9uIjozMDAyMTEzMjR9fQ.TmKWl_6YGv1rP6NsBmLGSSSnmJ6_EStYHMDHN5Rmc7C1BSnsvdTlZSGq9YPpuehXdJ9qiaAfAARrt-G_11dn4g"
    }

    response = requests.post(url, json=payload, headers=headers)

    print(response.text)

def reportarAlerta(nome, id, mensagem):
    url = "https://api.pipefy.com/graphql"

    payload = {"query": "mutation {createCard(input: {pipe_id: 302776879,title: \""+str(mensagem)+" - "+str(id)+": "+str(nome)+"\"}) {card {title}}}"}
    headers = {
        "accept": "application/json",
        "content-type": "application/json",
        "authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1c2VyIjp7ImlkIjozMDIwODAyNDcsImVtYWlsIjoiYWxlc3NhbmRyYS5iYWNjaW5Ac3B0ZWNoLnNjaG9vbCIsImFwcGxpY2F0aW9uIjozMDAyMTEzMjR9fQ.TmKWl_6YGv1rP6NsBmLGSSSnmJ6_EStYHMDHN5Rmc7C1BSnsvdTlZSGq9YPpuehXdJ9qiaAfAARrt-G_11dn4g"
    }

    response = requests.post(url, json=payload, headers=headers)

    print(response.text)


print("Enviando Alerta Para Service Desk")
reportarAlerta("Máquina 1", "10053","RAM em 85%")