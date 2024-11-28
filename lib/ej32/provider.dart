import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: 'Provider',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Provider'),
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
  int _counter = 5;

  int get counter => _counter;

  void incrementar() {
    _counter++;
    // Cuando se realiza algún cambio, se debe llamar a la siguiente función.
    notifyListeners();
  }
}

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // Para acceder a la clase modelo que nos provee la información,
    // se realiza mediante el contexto, indicando a la función watch el tipo
    // de la clase.
    final counter = context.watch<CounterProvider>().counter;
    return Text("Contador: $counter");
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.read<CounterProvider>().incrementar(),
      child: const Icon(Icons.add),
    );
  }
}
