import 'package:flutter/material.dart';
import 'taskCreator.dart';
import 'package:taskendar/global.dart';
import 'package:taskendar/models/task.dart'; 

class TasksPage extends StatefulWidget {
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Column(
        children: [
          Center(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaskCreator()),
                    );
                    setState(() {
                      TaskInheritedWidget.of(context)!.taskList.sort((a, b) => a.date.compareTo(b.date));
                    });
                  },
                  child: const Text('Create Task'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: TaskInheritedWidget.of(context)!.taskList.length,
              itemBuilder: (context, index) {
                Task task = TaskInheritedWidget.of(context)!.taskList[index];
                return ListTile(
                  title: Text(task.name),
                  subtitle: Text(task.description),
                  trailing: Text(
                      '${shortDateToString(task.date)} ${task.time.format(context)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
