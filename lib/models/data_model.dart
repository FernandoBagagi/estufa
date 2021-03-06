class DataModel {
  final String datahora;
  final double temperaturaDHT22;
  final double temperaturaLM35;
  final double umidadeDHT22;
  final double umidadeHIH4000;

  DataModel({
    required this.datahora,
    required this.temperaturaDHT22,
    required this.temperaturaLM35,
    required this.umidadeDHT22,
    required this.umidadeHIH4000,
  });

  Map<String, dynamic> getAsMap() => {
        'datahora': datahora,
        'temperaturaDHT22': temperaturaDHT22,
        'temperaturaLM35': temperaturaLM35,
        'umidadeDHT22': umidadeDHT22,
        'umidadeHIH4000': umidadeHIH4000,
      };

  @override
  String toString() {
    return 'datahora: $datahora' +
        '\ntemperaturaDHT22: $temperaturaDHT22' +
        '\ntemperaturaLM35: $temperaturaLM35' +
        '\numidadeDHT22: $umidadeDHT22' +
        '\numidadeHIH4000: $umidadeHIH4000';
  }

  static DataModel toDataModel(Map dado) => DataModel(
        datahora: dado['datahora'],
        temperaturaDHT22: dado['temperaturaDHT22'],
        temperaturaLM35: dado['temperaturaLM35'],
        umidadeDHT22: dado['umidadeDHT22'],
        umidadeHIH4000: dado['umidadeHIH4000'],
      );
}
