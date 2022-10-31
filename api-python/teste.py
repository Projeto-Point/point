import json
import urllib.request as urllib2


def get_webcrawler():
    
    url = 'http://ipinfo.io/json'
    response = urllib2.urlopen(url)
    data = json.load(response)
    
    return data

def get_ip_address():
    return get_webcrawler()['ip']

def get_city():
    return get_webcrawler()['city']

def get_country():
    return get_webcrawler()['country']  

def coordinates():

    coordinates_string = get_webcrawler()['loc']
    coordinates_split = coordinates_string.split(',')
    return coordinates_split

def get_latitude():
    return coordinates()[0]

def get_longitude():
    return coordinates()[1]
        

print(get_ip_address())
print(get_city())
print(get_country())
print(get_latitude())
print(get_longitude())



