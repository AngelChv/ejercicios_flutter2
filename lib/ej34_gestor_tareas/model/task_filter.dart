import 'package:ejercicios_flutter2/ej34_gestor_tareas/widgets/task_list_tile.dart';

enum TaskFilter {
  todo("Todas"),
  made("Completadas"),
  all("Pendientes");

  final String label;

  const TaskFilter(this.label);

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
