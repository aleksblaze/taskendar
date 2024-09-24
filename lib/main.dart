import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:taskendar/models/task.dart';
import 'package:taskendar/unifiedWidgets/navigatorUni.dart';
import 'package:taskendar/tasks/taskCreator.dart';
import 'package:taskendar/settings.dart';
import 'package:taskendar/tasks/tasks.dart';
import 'package:taskendar/models/themeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider(ThemeData.light())),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, child) {
        return MaterialApp(
          title: 'Taskendar',
          theme: themeProvider.themeData,
          locale: localeProvider.locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''), // English
            const Locale('uk', ''), // Ukrainian
          ],
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => HomePage(),
            '/tasks': (context) => TasksPage(),
            '/settings': (context) => SettingsPage(),
            '/taskCreator': (context) => TaskCreatorPage(),
          },
        );
      },
    );
  }
}

class LocaleProvider with ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
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
        title: Text(AppLocalizations.of(context)!.homeTitle),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.app_registration),
            onPressed: () {
              Navigator.pushNamed(context, '/tasks');
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
              child: Text(AppLocalizations.of(context)!.homeTitle),
            );
          } else {
            // layout for larger screens
            return Center(
              child: Text(AppLocalizations.of(context)!.homeTitle),
            );
          }
        },
      ),
    );
  }
}