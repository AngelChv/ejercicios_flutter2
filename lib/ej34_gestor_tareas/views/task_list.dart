import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task_list_provider.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/widgets/new_task_form.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/widgets/task_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/task_filter.dart';

class TaskListView extends StatelessWidget {
  static final entries = [
    DropdownMenuEntry(
      value: TaskFilter.todo,
      label: TaskFilter.todo.label,
    ),
    DropdownMenuEntry(
      value: TaskFilter.made,
      label: TaskFilter.made.label,
    ),
    DropdownMenuEntry(
      value: TaskFilter.all,
      label: TaskFilter.all.label,
    ),
  ];

  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(child: Center(child: Text("Gestor de tareas"))),
            DropdownMenu(
              initialSelection: TaskFilter.all,
              onSelected: (taskFilter) {
                context.read<TaskListProvider>().filter = taskFilter?.getFunction();
              },
              dropdownMenuEntries: entries,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          NewTaskForm(),
          Expanded(child: TaskList()),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    List<TaskListTile> tasks = context.watch<TaskListProvider>().tasks;
    return ListView.separated(
      padding: const EdgeInsets.all(32),
      itemBuilder: (context, index) => tasks[index],
      separatorBuilder: (context, index) => const Divider(),
      itemCount: tasks.length,
    );
  }
}
