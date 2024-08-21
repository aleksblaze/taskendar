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
