import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List<ListTile> _taskList = [
    const ListTile(
      title: Text("Prueba 1"),
    ),
    const ListTile(
      title: Text("Prueba 2"),
    ),
  ];

  List<ListTile> get taskList => _taskList;

  set taskList(List<ListTile> value) {
    _taskList = value;
  }

  void addTask(String text) {
    _taskList.add(ListTile(
      title: Text(text),
    ));
    notifyListeners();
  }
}
