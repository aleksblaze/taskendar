import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskendar/models/task.dart';
import 'package:taskendar/unifiedWidgets/appbarUni.dart';
import 'package:taskendar/unifiedWidgets/navigatorUni.dart';
import 'package:taskendar/tasks/taskCreator.dart';
import 'package:taskendar/router.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyApp(),
    ),
  );
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
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/tasks': (context) => TasksPage(),
        '/settings': (context) => SettingsPage(),
        '/taskCreator': (context) => TaskCreatorPage(),
      },
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
            context.go('/settings');
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.app_registration),
            onPressed: () {
              Navigator.pushNamed(context, '/tasks');
              context.go('/tasks');
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // layout for mobile devices
            return Center(
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
            );
          } else {
            // layout for desktop devices
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
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
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
class ErrorPage extends StatelessWidget {
  final Exception? error;

  const ErrorPage({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Center(
        child: Text(
          error?.toString() ?? 'Unknown error',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      ),
    );
  }
}