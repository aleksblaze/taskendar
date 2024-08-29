import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                    context.read<TaskProvider>().sortTasks();
                  },
                  child: const Text('Create Task'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Consumer<TaskProvider>(
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
            ),
          ),
        ],
      ),
    );
  }
}
