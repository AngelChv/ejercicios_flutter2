import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task.dart';
import 'package:flutter/material.dart';

class TaskListTile extends StatefulWidget {
  final Task task;

  const TaskListTile({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.task.isComplete,
        onChanged: (value) {
          setState(() {
            widget.task.isComplete = value ?? false;
          });
        },
      ),
      title: Text(widget.task.title),
      subtitle: Text(widget.task.description),
      trailing: IconButton(
        onPressed: () {
          setState(() {

          });
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
