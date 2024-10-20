import 'package:taskendar/models/task.dart';

abstract class NetworkService {
  Future<List<Task>> fetchTasks();
  Future<void> saveTask(Task task);
}