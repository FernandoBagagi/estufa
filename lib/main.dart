import 'dart:async';
import 'package:estufa/models/data_model.dart';
import 'package:estufa/screens/home_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'teste',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDmsNkXm50Uq0I0chSBZ0ncyvNJ6g4EKYw',
      appId: '1:225685323453:android:71d36c4c5455f1419cc1d4',
      messagingSenderId: '225685323453',
      projectId: 'teste-c476d',
      databaseURL: 'https://teste-c476d-default-rtdb.firebaseio.com',
      storageBucket:
          'https://console.firebase.google.com/project/teste-c476d/storage/teste-c476d.appspot.com/files',
    ),
  );
  try {
    DatabaseReference medicoes = FirebaseDatabase.instance.ref('medicoes');
    // medicoes.push().set(DataModel(
    //       datahora: DateTime.now().toString(),
    //       temperaturaDHT22: 39.89,
    //       temperaturaAmbienteGY906: 39.95,
    //       temperaturaObjetoGY906: 34.9,
    //       temperaturaLM35: 39.8,
    //       umidadeDHT22: 60.7,
    //       umidadeHIH4000: 60.3,
    //     ).getAsMap());
    final listaDados = await medicoes.orderByKey().get();
    final dados = listaDados.value as Map;
    final List<DataModel> listaDadosDataModel = [];
    dados.forEach(
      (key, value) =>
          listaDadosDataModel.add(DataModel.toDataModel(value as Map)),
    );
    for (DataModel dado in listaDadosDataModel) {
      print(dado.toString());
    }
  } catch (erro) {
    print(erro);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
