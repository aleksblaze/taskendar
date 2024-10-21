import 'package:flutter/material.dart';

class Task {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final TimeOfDay time;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(':')[0]),
        minute: int.parse(json['time'].split(':')[1]),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}',
    };
  }
}
