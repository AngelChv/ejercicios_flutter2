import 'package:ejercicios_flutter2/ej33_gestor_tareas/add_task_screen.dart';
import 'package:ejercicios_flutter2/ej33_gestor_tareas/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tareas"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: TaskList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final taskList = context.watch<TaskProvider>().taskList;
    return ListView.separated(
      itemBuilder: (context, i) => taskList[i],
      separatorBuilder: (context, i) => const Divider(
        height: 16,
      ),
      itemCount: taskList.length,
    );
  }
}
