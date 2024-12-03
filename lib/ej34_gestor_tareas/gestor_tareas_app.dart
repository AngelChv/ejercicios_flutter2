import 'package:ejercicios_flutter2/ej34_gestor_tareas/dao/task_dao.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/db/sqflite_common_ffi_manager.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task_list_provider.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/views/task_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  SqliteManager.startDb();
  TaskDAO.create();
  runApp(const GestorTareasApp());
}

class GestorTareasApp extends StatelessWidget {
  const GestorTareasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskListProvider(),
      child: const MaterialApp(
        title: "Gestor Tareas",
        home: TaskListView(),
      ),
    );
  }
}