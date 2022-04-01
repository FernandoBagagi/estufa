import 'package:estufa/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/card_data.dart';
import '../widgets/line_medicao.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> sensores = const [
    'Temperatura DHT22',
    'Temp. Ambiente GY-906',
    'Temp. Objeto GY906',
    'Temperatura LM35',
    'Umidade DHT21',
    'Umidade HIH4000',
  ];

  int numSensor = 0;
  bool showHistoricoTemperatura = false;
  bool showHistoricoUmidade = false;

  List<DataModel> dados = [
    DataModel(
      datahora: DateTime.now().toString(),
      temperaturaDHT22: 39.89,
      temperaturaAmbienteGY906: 39.95,
      temperaturaObjetoGY906: 34.9,
      temperaturaLM35: 39.8,
      umidadeDHT22: 60.7,
      umidadeHIH4000: 60.3,
    ),
    DataModel(
      datahora: DateTime.now().toString(),
      temperaturaDHT22: 40.0,
      temperaturaAmbienteGY906: 40.1,
      temperaturaObjetoGY906: 38.4,
      temperaturaLM35: 39.9,
      umidadeDHT22: 61.2,
      umidadeHIH4000: 61.3,
    ),
    DataModel(
      datahora: DateTime.now().toString(),
      temperaturaDHT22: 40.1,
      temperaturaAmbienteGY906: 40.15,
      temperaturaObjetoGY906: 38.5,
      temperaturaLM35: 40.8,
      umidadeDHT22: 55.7,
      umidadeHIH4000: 56.3,
    ),
    DataModel(
      datahora: DateTime.now().toString(),
      temperaturaDHT22: 39.89,
      temperaturaAmbienteGY906: 39.95,
      temperaturaObjetoGY906: 34.9,
      temperaturaLM35: 39.8,
      umidadeDHT22: 60.7,
      umidadeHIH4000: 60.3,
    ),
  ];

  Future<void> carregarDados() async {
    try {
      DatabaseReference medicoes = FirebaseDatabase.instance.ref('medicoes');
      final listaDados = (await medicoes.get()).value as Map;
      List<DataModel> listaDadosDataModel = <DataModel>[];
      listaDados.forEach(
        (key, value) =>
            listaDadosDataModel.add(DataModel.toDataModel(value as Map)),
      );
      setState(() {
        listaDadosDataModel
            .sort((d1, d2) => d2.datahora.compareTo(d1.datahora));
        dados = listaDadosDataModel;
      });
    } catch (erro) {
      dados = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    carregarDados();
    return Stack(
      children: [
        Column(
          children: [Image.asset('assets/images/rain.png')],
        ),
        Container(
          color: Colors.black38,
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const Center(
                    child: Text(
                      'Estufa',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                CardData(
                  porcentagemTamanho: 0.3,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Temperatura',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showHistoricoTemperatura = true;
                          });
                        },
                        child: const Text('Histórico'),
                      ),
                    ],
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      LineMedicao(
                        label: 'DHT22',
                        dado: dados[0].temperaturaDHT22.toStringAsFixed(1) +
                            ' °C',
                      ),
                      LineMedicao(
                        label: 'GY-906 (Ambiente)',
                        dado: dados[0]
                                .temperaturaAmbienteGY906
                                .toStringAsFixed(1) +
                            ' °C',
                      ),
                      LineMedicao(
                        label: 'GY-906 (Objeto)',
                        dado:
                            dados[0].temperaturaObjetoGY906.toStringAsFixed(1) +
                                ' °C',
                      ),
                      LineMedicao(
                        label: 'LM 35',
                        dado:
                            dados[0].temperaturaLM35.toStringAsFixed(1) + ' °C',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Última atulização foi em ${dados[0].datahora.replaceAll('-', '/').substring(0, 16)}',
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CardData(
                  porcentagemTamanho: 0.22,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Umidade',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showHistoricoUmidade = true;
                          });
                        },
                        child: const Text('Histórico'),
                      ),
                    ],
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      LineMedicao(
                        label: 'DHT22',
                        dado: dados[0].umidadeDHT22.toStringAsFixed(1) + ' %',
                      ),
                      LineMedicao(
                        label: 'HIH 4000',
                        dado: dados[0].umidadeHIH4000.toStringAsFixed(1) + ' %',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Última atulização foi em ${dados[0].datahora.replaceAll('-', '/').substring(0, 16)}',
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CardData(
                  porcentagemTamanho: 0.35,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            numSensor = numSensor == 0 ? 5 : numSensor - 1;
                          });
                        },
                        child: const Icon(
                          Icons.arrow_left,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Text(
                        sensores[numSensor],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            numSensor = numSensor == 5 ? 0 : numSensor + 1;
                          });
                        },
                        child: const Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                  body: Container(
                    height: (MediaQuery.of(context).size.width - 32) * 0.48,
                    margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      legend: Legend(isVisible: false),
                      tooltipBehavior: TooltipBehavior(enable: false),
                      series: <ChartSeries<DataModel, String>>[
                        LineSeries<DataModel, String>(
                          dataSource: dados.sublist(0, 4),
                          xValueMapper: (DataModel dado, _) =>
                              dado.datahora.substring(11, 16),
                          yValueMapper: (DataModel dado, _) {
                            switch (numSensor) {
                              case 0:
                                return dado.temperaturaDHT22;
                              case 1:
                                return dado.temperaturaAmbienteGY906;
                              case 2:
                                return dado.temperaturaObjetoGY906;
                              case 3:
                                return dado.temperaturaLM35;
                              case 4:
                                return dado.umidadeDHT22;
                              case 5:
                                return dado.umidadeHIH4000;
                              default:
                                return dado.temperaturaDHT22;
                            }
                          },
                          color: const Color(0xFFFC377E),
                          dataLabelSettings: const DataLabelSettings(
                              isVisible: true, color: Color(0xFFFC377E)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: showHistoricoTemperatura || showHistoricoUmidade,
          child: Container(
            color: Colors.black87,
          ),
        ),
        Visibility(
          visible: showHistoricoTemperatura,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showHistoricoTemperatura = false;
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                CardData(
                  porcentagemTamanho: 0.35,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Temperatura',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  body: Container(
                    margin: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.73,
                    child: ListView.builder(
                      itemBuilder: (ctx, indice) => SizedBox(
                        child: Column(
                          children: [
                            LineMedicao(
                              label: 'DHT22',
                              dado: dados[indice]
                                      .temperaturaDHT22
                                      .toStringAsFixed(1) +
                                  ' °C',
                            ),
                            LineMedicao(
                              label: 'GY-906 (Ambiente)',
                              dado: dados[indice]
                                      .temperaturaAmbienteGY906
                                      .toStringAsFixed(1) +
                                  ' °C',
                            ),
                            LineMedicao(
                              label: 'GY-906 (Objeto)',
                              dado: dados[indice]
                                      .temperaturaObjetoGY906
                                      .toStringAsFixed(1) +
                                  ' °C',
                            ),
                            LineMedicao(
                              label: 'LM 35',
                              dado: dados[indice]
                                      .temperaturaLM35
                                      .toStringAsFixed(1) +
                                  ' °C',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Medido em ${dados[indice].datahora.replaceAll('-', '/').substring(0, 16)}',
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Divider(
                              indent: 8.0,
                              endIndent: 8.0,
                              thickness: 3.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      itemCount: dados.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: showHistoricoUmidade,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showHistoricoUmidade = false;
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                CardData(
                  porcentagemTamanho: 0.35,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Umidade',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  body: Container(
                    margin: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.73,
                    child: ListView.builder(
                      itemBuilder: (ctx, indice) => SizedBox(
                        child: Column(
                          children: [
                            LineMedicao(
                              label: 'DHT22',
                              dado: dados[indice]
                                      .umidadeDHT22
                                      .toStringAsFixed(1) +
                                  ' %',
                            ),
                            LineMedicao(
                              label: 'HIH 4000',
                              dado: dados[indice]
                                      .umidadeHIH4000
                                      .toStringAsFixed(1) +
                                  ' %',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Última atulização foi em ${dados[indice].datahora.replaceAll('-', '/').substring(0, 16)}',
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Divider(
                              indent: 8.0,
                              endIndent: 8.0,
                              thickness: 3.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      itemCount: dados.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
