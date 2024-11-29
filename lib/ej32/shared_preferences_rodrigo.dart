import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Correctamente inicializado todo
  final prefs = await SharedPreferences.getInstance();
  final contadorInicial = prefs.getInt('contador') ?? 5;

  runApp(ContadorApp(contadorInicial: contadorInicial));
}

class ContadorApp extends StatefulWidget {
  final int contadorInicial;

  ContadorApp({required this.contadorInicial});

  @override
  _ContadorAppState createState() => _ContadorAppState();
}

class _ContadorAppState extends State<ContadorApp> {
  late int _contador; //Inicialización tardía

  @override
  void initState() {
    super.initState();
    _contador = widget.contadorInicial;
  }

  Future<void> _incrementarContador() async {
    setState(() {
      _contador++;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('contador', _contador);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SharedPreferences Ejemplo')),
        body: Center(child: Text('Contador: $_contador', style: TextStyle(fontSize: 24))),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementarContador,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}