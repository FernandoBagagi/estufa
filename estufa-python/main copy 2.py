from datetime import datetime
import pyrebase
import time
import serial

porta = 'COM3'
baud_rate = 9600
ser = serial.Serial(porta, baud_rate)


config = {
  "apiKey": "teste-c476d",
  "authDomain": "teste-c476d.firebaseapp.com",
  "databaseURL": "https://teste-c476d-default-rtdb.firebaseio.com/",
  "storageBucket": "gs://teste-c476d.appspot.com",
}

firebase = pyrebase.initialize_app(config)

db = firebase.database()

def media(lista, posicao, quantidade):
    acumulador = 0.0
    for aux in lista:
        acumulador += aux[posicao]
    return round(acumulador / quantidade, 2)

contador = 10
while contador != 0:
    leituras = 0
    dados_lidos = []
    while leituras < 5:
        dados = ser.readline()
        dados = dados.rstrip()
        dados = dados.decode("utf-8")
        dados = dados.split(' ')
        dados = list(map(lambda item: float(item), dados))
        dados_lidos.append(dados)
        time.sleep(1.0)
        leituras += 1

    dado_bd = {
        'datahora': str(datetime.now()),
        'temperaturaAmbienteGY906': media(dados_lidos, 2, leituras),
        'temperaturaDHT22': media(dados_lidos, 4, leituras),
        'temperaturaLM35': media(dados_lidos, 0, leituras),
        'temperaturaObjetoGY906': media(dados_lidos, 3, leituras),
        'umidadeDHT22': media(dados_lidos, 5, leituras),
        'umidadeHIH4000': media(dados_lidos, 1, leituras),
    }
    print('Dados: ', dado_bd)
    db.child("medicoes").push(dado_bd)
    time.sleep(60.0)
    contador -= 1
