import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Para transmitir la clase modelo con la información, hacemos que
    // ScopedModel sea padre de los widgets que queramos que accedan al modelo.
    return ScopedModel(
      model: CounterModel(),
      child: MaterialApp(
        title: 'ScopedModel',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'ScopedModel'),
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
class CounterModel extends Model {
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
    // Para acceder a los datos se usa ScopedModelDescendat con el tipo
    // del modelo que hemos creado.
    return ScopedModelDescendant<CounterModel>(
      // Genera un widget que indiquemos y podemos usar la clase modelo mediante
      // model.
      builder: (context, child, model) => Text("Contador: ${model.counter}"),
    );
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // Otra forma de acceder a la clase modelo es de manera estática con of:
      onPressed: () => ScopedModel.of<CounterModel>(context).incrementar(),
      child: const Icon(Icons.add),
    );
  }
}
