import 'package:ejercicios_flutter2/ej34_gestor_tareas/dao/task_dao.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/widgets/task_list_tile.dart';
import 'package:flutter/material.dart';

import '../model/task.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestor de tareas"),
        centerTitle: true,
      ),
      body: const TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<StatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  static final List<TaskListTile> _tasks = [];

  @override
  void initState() {
    super.initState();
    TaskDAO.findAll().then((result) {
      setState(() {
        for (Task task in result) {
          _tasks.add(TaskListTile(task: task));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(32),
      itemBuilder: (context, index) => _tasks[index],
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _tasks.length,
    );
  }
}
