import 'package:flutter/material.dart';

class Task {
  String name;
  String description;
  DateTime date;
  TimeOfDay time;

  Task({
    required this.name,
    required this.description,
    required this.date,
    required this.time,
  });
}

class TaskProvider with ChangeNotifier {
  List<Task> _taskList = [];

  List<Task> get taskList => _taskList;

  void addTask(Task task) {
    _taskList.add(task);
    notifyListeners();
  }

  void sortTasks() {
    _taskList.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }
}
