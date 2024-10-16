import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskendar/models/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 

class TaskCreatorPage extends StatefulWidget {
  @override
  _TaskCreatorState createState() => _TaskCreatorState();
}

class _TaskCreatorState extends State<TaskCreatorPage> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String _taskName = '';
  String _taskDescription = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.taskCreator), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  _taskName = value;
                });
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.enterTaskName, 
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  _taskDescription = value;
                });
              },
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.enterTaskDescription, 
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.selectDate, 
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.selectTime, 
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () => _selectTime(context),
                ),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text(AppLocalizations.of(context)!.addTask), 
              onPressed: () {
                Task task = Task(
                  name: _taskName,
                  description: _taskDescription,
                  date: DateTime.now(),
                  time: TimeOfDay.now(),
                );

                context.read<TaskProvider>().addTask(task);
                Navigator.pushNamed(context, '/tasks');
              },
            ),
          ],
        ),
      ),
    );
  }
}