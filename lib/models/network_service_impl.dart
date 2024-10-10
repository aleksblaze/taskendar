import 'package:cloud_firestore/cloud_firestore.dart';
import 'network_service.dart';
import 'package:taskendar/models/task.dart';

class NetworkServiceImpl implements NetworkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Task>> fetchTasks() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('tasks').get();
      return querySnapshot.docs.map((doc) => Task.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  @override
  Future<void> saveTask(Task task) async {
    try {
      await _firestore.collection('tasks').add(task.toJson());
    } catch (e) {
      throw Exception('Failed to save task: $e');
    }
  }
}