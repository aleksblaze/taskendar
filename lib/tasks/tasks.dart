import 'package:flutter/material.dart';
import 'package:taskendar/tasks/taskCreator.dart';
import 'package:provider/provider.dart';
import 'package:taskendar/unifiedWidgets/taskCreatorUni.dart';
import 'package:taskendar/models/task.dart';
import 'package:taskendar/unifiedWidgets/appbarUni.dart';
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
      appBar: CustomAppBar(
        title: 'Tasks',
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Layout for mobile devices
            return Column(
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
                            MaterialPageRoute(
                                builder: (context) => TaskCreatorPage()),
                          );
                          if (mounted) {
                            context.read<TaskProvider>().sortTasks();
                          }
                        },
                        child: const Text('Create Task'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TaskList(),
                ),
              ],
            );
          } else {
            // Layout for desktop devices
            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 30,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskCreatorPage()),
                          );
                          if (mounted) {
                            context.read<TaskProvider>().sortTasks();
                          }
                        },
                        child: const Text('Create Task'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TaskList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}