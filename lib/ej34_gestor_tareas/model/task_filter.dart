import 'package:ejercicios_flutter2/ej34_gestor_tareas/widgets/task_list_tile.dart';
import 'package:flutter/material.dart';

enum TaskFilter {
  todo("Pendientes"),
  made("Completadas"),
  all("Todas");

  final String label;

  const TaskFilter(this.label);

  static List<DropdownMenuEntry> getMenuEntries() {
    List<DropdownMenuEntry> entries = [];

    for (var i in TaskFilter.values) {
      entries.add(DropdownMenuEntry(
        value: i,
        label: i.label,
      ));
    }

    return entries;
  }

  List<TaskListTile> Function(List<TaskListTile>) getFunction() {
    return switch (this) {
      TaskFilter.all => (original) {
          return original.toList();
        },
      TaskFilter.made => (original) {
          List<TaskListTile> filtered = [];
          for (TaskListTile t in original) {
            if (t.task.isComplete) filtered.add(t);
          }
          return filtered;
        },
      TaskFilter.todo => (original) {
          List<TaskListTile> filtered = [];
          for (TaskListTile t in original) {
            if (!t.task.isComplete) filtered.add(t);
          }
          return filtered;
        },
    };
  }
}
