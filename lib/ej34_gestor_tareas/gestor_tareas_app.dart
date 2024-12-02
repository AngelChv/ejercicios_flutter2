import 'package:ejercicios_flutter2/ej34_gestor_tareas/dao/task_dao.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/db/sqflite_common_ffi_manager.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/views/task_list.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  SqliteManager.startDb();
  // TaskDAO.create();
  // TaskDAO.insert(Task(title: "Task 1", description: "Task 1"));
  // final tasks = TaskDAO.findAll();
  // print(tasks);
  runApp(const GestorTareasApp());
}

class GestorTareasApp extends StatelessWidget {
  const GestorTareasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Gestor Tareas",
      home: TaskListView(),
    );
  }
}