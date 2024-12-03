import 'package:ejercicios_flutter2/ej34_gestor_tareas/model/task.dart';
import 'package:flutter/material.dart';

import '../dao/task_dao.dart';
import '../widgets/task_list_tile.dart';

class TaskListProvider extends ChangeNotifier {
  final List<TaskListTile> _originaTasks = [];
  List<TaskListTile> _tasks = [];
  List<TaskListTile> Function(List<TaskListTile>)? _filter;

  set filter(List<TaskListTile> Function(List<TaskListTile>)? value) {
    _filter = value;
    filterTasks();
  }

  TaskListProvider() {
    importTasks();
  }

  void filterTasks() {
    if (_filter != null) {
      _tasks = _filter!(_originaTasks);
      notifyListeners();
    } else {
      _tasks = _originaTasks.toList();
    }
  }

  List<TaskListTile> get tasks => _tasks;

  void importTasks() {
    TaskDAO.findAll().then((result) {
      for (Task task in result) {
        _originaTasks.add(TaskListTile(task: task));
      }
      filterTasks();
      notifyListeners();
    });
  }

  Future<bool> removeTask(TaskListTile taskListTile) async {
    if (await TaskDAO.delete(taskListTile.task.id!)) {
      _originaTasks.remove(taskListTile);
      filterTasks();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> addTask(Task task) async {
    task.id = await TaskDAO.insert(task);
    if (task.id != null) {
      _originaTasks.add(TaskListTile(task: task));
      filterTasks();
      notifyListeners();
      return true;
    }
    return false;
  }

}
