import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskendar/models/task.dart';
import 'package:taskendar/global.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView.builder(
          itemCount: taskProvider.taskList.length,
          itemBuilder: (context, index) {
            Task task = taskProvider.taskList[index];
            return ListTile(
              title: Text(task.name),
              subtitle: Text(task.description),
              trailing: Text(
                  '${shortDateToString(task.date)} ${task.time.format(context)}'),
            );
          },
        );
      },
    );
  }
}