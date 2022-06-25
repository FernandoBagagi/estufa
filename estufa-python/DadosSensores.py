from datetime import datetime

class DadosSensores:

    def __init__(self, datahora, temperaturaAmbienteGY906, temperaturaDHT22, temperaturaLM35,
                 temperaturaObjetoGY906, umidadeDHT22, umidadeHIH4000):
        self.datahora = datahora
        self.temperaturaAmbienteGY906 = temperaturaAmbienteGY906
        self.temperaturaDHT22 = temperaturaDHT22
        self.temperaturaLM35 = temperaturaLM35
        self.temperaturaObjetoGY906 = temperaturaObjetoGY906
        self.umidadeDHT22 = umidadeDHT22
        self.umidadeHIH4000b = umidadeHIH4000


print(datetime.now())
"2022-02-28 10:42:12.990196"
