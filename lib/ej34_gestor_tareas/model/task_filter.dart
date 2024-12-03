import 'package:ejercicios_flutter2/ej34_gestor_tareas/widgets/task_list_tile.dart';
import 'package:flutter/material.dart';

enum TaskFilter {
  todo("Pendientes"),
  made("Completadas"),
  all("Todas");

  final String label;

  const TaskFilter(this.label);

  static List<DropdownMenuEntry> getMenuEntries() {
    return [
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
  }

  List<TaskListTile> Function(List<TaskListTile>) getFunction() {
    return switch (this) {
      TaskFilter.todo => (original) {return original.toList();},
      TaskFilter.made => (original) {
        List<TaskListTile> filtered = [];
        for (TaskListTile t in original) {
          if (t.task.isComplete) filtered.add(t);
        }
        return filtered;
        },
      TaskFilter.all => (original) {
        List<TaskListTile> filtered = [];
        for (TaskListTile t in original) {
          if (!t.task.isComplete) filtered.add(t);
        }
        return filtered;
        },
    };
  }
}
