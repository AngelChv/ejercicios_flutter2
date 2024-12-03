import 'package:ejercicios_flutter2/ej34_gestor_tareas/dao/task_dao.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task.dart';
import 'package:ejercicios_flutter2/ej34_gestor_tareas/views/task_list.dart';
import 'package:flutter/material.dart';

class TaskListTile extends StatefulWidget {
  final Task task;

  const TaskListTile({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  late Text title;

  @override
  Widget build(BuildContext context) {
    title = Text(widget.task.title);
    print("isComplete: ${widget.task.isComplete}");
    return ListTile(
      leading: Checkbox(
        value: widget.task.isComplete,
        onChanged: (value) {
          setState(() {
            widget.task.isComplete = value ?? false;
          });
          TaskDAO.update(widget.task);
        },
      ),
      title: Text(
        widget.task.title,
        style: (widget.task.isComplete)
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: Text(widget.task.description),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            if (widget.task.id != null) {
              TaskDAO.delete(widget.task.id!);
              final state = context.findAncestorStateOfType<TaskListState>();
              state?.update(widget);
            }
            widget.task.id = null;
          });
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
