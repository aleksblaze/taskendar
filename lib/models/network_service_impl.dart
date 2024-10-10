import 'dart:convert';
import 'package:http/http.dart' as http;
import 'network_service.dart';
import 'package:taskendar/models/task.dart';

class NetworkServiceImpl implements NetworkService {
  final String baseUrl = 'https://example.com/api'; // Замість цього використовуйте реальну URL-адресу вашого API

  @override
  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Future<void> saveTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to save task');
    }
  }
}