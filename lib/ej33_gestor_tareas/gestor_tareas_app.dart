import 'package:ejercicios_flutter2/ej33_gestor_tareas/task_list.dart';
import 'package:ejercicios_flutter2/ej33_gestor_tareas/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TaskProvider(),
    child: const GestorTareasApp(),
  ));
}

class GestorTareasApp extends StatelessWidget {
  const GestorTareasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Gestor tareas",
      home: TaskListScreen(),
    );
  }
}
