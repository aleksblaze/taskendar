import 'package:flutter/material.dart';
import 'package:taskendar/main.dart';
import 'package:go_router/go_router.dart';
import 'package:taskendar/tasks/tasks.dart';
import 'package:taskendar/settings.dart';
import 'package:taskendar/tasks/task_creator.dart';

const String AppTitle = 'Taskendar';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/tasks',
          builder: (context, state) => TasksPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => SettingsPage(),
        ),
        GoRoute(
          path: '/task_creator',
          builder: (context, state) => TaskCreatorPage(),
        ),
      ],
    );

    return MaterialApp.router(
      title: AppTitle,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.green,
      ),      
      routerConfig: _router,      
      debugShowCheckedModeBanner: false,
    );
  }
}