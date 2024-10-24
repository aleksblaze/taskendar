import 'package:flutter/material.dart';
import 'package:taskendar/models/task.dart';
import 'package:taskendar/models/network_service.dart';
import 'package:taskendar/models/network_service_impl.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _taskList = [];
  final NetworkService _networkService = NetworkServiceImpl();

  List<Task> get taskList => _taskList;

  Future<void> fetchTasks() async {
    try {
      _taskList = await _networkService.fetchTasks();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch tasks: $e');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _networkService.saveTask(task);
      _taskList.add(task);
      notifyListeners();
    } catch (e) {
      print('Failed to save task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _networkService.deleteTask(id);
      _taskList.removeWhere((task) => task.id == id);
      notifyListeners();
    } catch (e) {
      print('Failed to delete task: $e');
    }
  }

  void sortTasks() {
    _taskList.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }
}