import 'package:flutter/material.dart';
import 'package:taskendar/tasks/tasks.dart';
import 'package:taskendar/settings.dart';

void main() {
  runApp(MyApp());
}

const AppTitle = 'Taskendar';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTitle,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(AppTitle),
      leading: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
         Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        },
      ),
      actions: [
        IconButton(
        icon: Icon(Icons.app_registration),
        onPressed: () {
          Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => TasksPage()),
            );
            setState(() {
              
            });
          },
        ),
      ],
    ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(
          '*There will be a calendar here, but it is not implemented yet.*',
          style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Upcoming Events: (will be a lot lower on the page)',
          style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Date - Tomorrow',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'New Year - in 2 days',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Moms birthday - Date',
          style: TextStyle(fontSize: 16),
        ),
        ],
      ),
      ),
    );
  }
}