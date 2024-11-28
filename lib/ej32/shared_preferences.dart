import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Para transmitir la clase modelo con la información, hacemos que
    // ChangeNotifierProvider sea padre de los widgets que queramos que
    // accedan al modelo.
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: MaterialApp(
        title: 'SharedPreferences',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'SharedPreferences'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: CounterDisplay(),
      ),
      floatingActionButton: const IncrementButton(),
    );
  }
}

/// Modelo que utilizamos para transmitir información.
class CounterProvider extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  CounterProvider() {
    getCounter().then((value) {
      _counter = (value != null) ? value : 0;
    });
  }

  void incrementar() {
    _counter++;
    saveCounter(_counter);
    // Cuando se realiza algún cambio, se debe llamar a la siguiente función.
    notifyListeners();
  }

  void saveCounter(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', value);
  }

  Future<int?> getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    notifyListeners();
    return prefs.getInt('counter');
  }
}

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // Para acceder a la clase modelo que nos provee la información,
    // se realiza mediante el contexto, indicando a la función watch el tipo
    // de la clase.
    return Text("Contador: ${context.watch<CounterProvider>().counter}");
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CounterProvider>().incrementar();
      },
      child: const Icon(Icons.add),
    );
  }
}