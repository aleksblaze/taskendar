import 'package:flutter/material.dart';
import 'package:taskendar/tasks/task_creator.dart';
import 'package:provider/provider.dart';
import 'package:taskendar/models/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksPage extends StatefulWidget {
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tasks),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
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
                        child: Text(AppLocalizations.of(context)!.createTask),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: context.watch<TaskProvider>().taskList.length,
                    itemBuilder: (context, index) {
                      final task =
                          context.watch<TaskProvider>().taskList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(task.name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(task.description),
                                SizedBox(height: 4),
                                Text('${task.date.toLocal()}'.split(' ')[0]),
                                Text(task.time.format(context)),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await context
                                    .read<TaskProvider>()
                                    .deleteTask(task.id);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            // Layout for desktop devices
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
                        child: Text(AppLocalizations.of(context)!.createTask),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    itemCount: context.watch<TaskProvider>().taskList.length,
                    itemBuilder: (context, index) {
                      final task =
                          context.watch<TaskProvider>().taskList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(task.name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(task.description),
                                SizedBox(height: 4),
                                Text('${task.date.toLocal()}'.split(' ')[0]),
                                Text(task.time.format(context)),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await context
                                    .read<TaskProvider>()
                                    .deleteTask(task.id);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
