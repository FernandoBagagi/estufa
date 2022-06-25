import datetime
import pyrebase


class Medicao:

    def __init__(self, temperatura, humidade, ano=0, mes=0, dia=0, hora=0, minuto=0, segundo=0):
        self.temperatura = temperatura
        self.humidade = humidade
        agora = datetime.datetime.now()
        self.ano = ano if ano != 0 else agora.year
        self.mes = mes if ano != 0 else agora.month
        self.dia = dia if ano != 0 else agora.day
        self.hora = hora if ano != 0 else agora.hour
        self.minuto = minuto if ano != 0 else agora.minute
        self.segundo = segundo if ano != 0 else agora.second

    def __str__(self) -> str:
        return "temperatura: " + str(self.temperatura) + \
            " humidade: " + str(self.humidade) + \
            " " + self.__completarComZero(self.ano) + \
            "/" + self.__completarComZero(self.mes) + \
            "/" + self.__completarComZero(self.dia) + \
            " " + self.__completarComZero(self.hora) + \
            ":" + self.__completarComZero(self.minuto) + \
            ":" + self.__completarComZero(self.segundo)

    def __completarComZero(self, num):
        return ('0' if num < 10 else '') + str(num)

    def getDicionario(self):
        return {"temperatura": self.temperatura,
                "humidade": self.humidade,
                "ano": self.ano,
                "mes": self.mes,
                "dia": self.dia,
                "hora": self.hora,
                "minuto": self.minuto,
                "segundo": self.segundo,
                }


class BancoMedicoes:

    def __init__(self):
        config = {
            "apiKey": "teste-c476d",
            "authDomain": "teste-c476d.firebaseapp.com",
            "databaseURL": "https://teste-c476d-default-rtdb.firebaseio.com/",
            "storageBucket": "gs://teste-c476d.appspot.com"
        }
        firebase = pyrebase.initialize_app(config)
        self.db = firebase.database()

    def inserirMedicao(self, medicao):
        self.db.child("medicoes").push(medicao.getDicionario())

    def alterarMedicao(self, medicaoId, campo, valor):
        self.db.child("medicoes").child(medicaoId).update({campo: valor})

    def deletarMedicao(self, medicaoId):
        self.db.child("medicoes").child(medicaoId).remove()

    def getTodosRegistrosComoDicionario(self):
        return list(map(lambda item: item.val(), self.db.child("medicoes").get().each()))

    def getTodosRegistros(self):
        return list(map(lambda item: Medicao(item['temperatura'], item['humidade'], ano=item['ano'],
                                             mes=item['mes'], dia=item['dia'], hora=item['hora'], minuto=item['minuto'], segundo=item['segundo']),
                        self.getTodosRegistrosComoDicionario()))


b = BancoMedicoes()
b.inserirMedicao(Medicao(26, 93))
l = b.getTodosRegistros()
print(type(l))
for aux in l:
    print(aux)
