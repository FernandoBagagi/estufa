import 'dart:async';
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
  DatabaseReference? dados;
  try {
    dados = FirebaseDatabase.instance.ref('medicoes');
    //dados.push().set({'teste': 123});
    final a = await dados.get();
    final b = a.value as Map;
    b.forEach((key, value) {
      print(key);
      final Map vAux = value as Map;
      vAux.forEach((key2, value2) {
        print('-> $key2: $value2');
      });
    });
    // Map c = b.values.elementAt(0);
    // print(c['segundo']);
    //dados.push();
    //print(dados.orderByKey());
  } catch (erro) {
    dados = null;
    print(erro);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> getDados() async {
    DatabaseReference? dados;
    try {
      dados = FirebaseDatabase.instance.ref('teste-c476d-default-rtdb');
      final a = dados.get();
      //dados.push();
      //print(dados.orderByKey());
    } catch (erro) {
      dados = null;
      print('Deu ruim');
    }
    //print(dados!.key);
  }

  @override
  Widget build(BuildContext context) {
    //getDados();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
