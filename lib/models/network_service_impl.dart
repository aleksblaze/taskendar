import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskendar/models/task.dart';
import 'package:taskendar/models/network_service.dart';

class NetworkServiceImpl implements NetworkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Task>> fetchTasks() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('tasks').get();
      return snapshot.docs.map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  @override
  Future<void> saveTask(Task task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).set(task.toJson());
    } catch (e) {
      throw Exception('Failed to save task: $e');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await _firestore.collection('tasks').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}