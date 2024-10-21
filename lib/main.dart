import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskendar/firebase_options.dart';
import 'package:taskendar/models/task_provider.dart';
import 'package:taskendar/models/theme_provider.dart';
import 'package:taskendar/settings.dart';
import 'package:taskendar/tasks/task_creator.dart';
import 'package:taskendar/tasks/tasks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskendar/unifiedWidgets/navigator_uni.dart';
import 'package:taskendar/unifiedWidgets/calendar_uni.dart';
import 'package:taskendar/models/event_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    useMaterial3: false,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto'),
      bodyLarge:
          TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: 'Roboto'),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontFamily: 'Roboto',
      ),
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(
            create: (context) => ThemeProvider(defaultTheme)),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => EventDatabase()),
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
  String _selectedLanguage = 'English';

  Locale get locale => _locale;
  String get selectedLanguage => _selectedLanguage;

  void setLocale(Locale locale, String languageName) {
    _locale = locale;
    _selectedLanguage = languageName;
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
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final eventDatabase = Provider.of<EventDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.homeTitle),
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
              Navigator.pushNamed(context, '/taskCreator');
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // layout for mobile devices
            return Column(
              children: [
                UnifiedCalendar(),
                Center(
                  child: Text(localization.homeTitle),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: eventDatabase.getUpcomingEvents().length,
                    itemBuilder: (context, index) {
                      final event = eventDatabase.getUpcomingEvents()[index];
                      return Center(
                        child: ListTile(
                          title: Center(child: Text(event.title)),
                          subtitle:
                              Center(child: Text(event.timeToEvent(context))),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            // layout for larger screens
            return Column(
              children: [
                UnifiedCalendar(),
                Center(
                  child: Text(localization.homeTitle),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: eventDatabase.getUpcomingEvents().length,
                    itemBuilder: (context, index) {
                      final event = eventDatabase.getUpcomingEvents()[index];
                      return Center(
                        child: ListTile(
                          title: Center(child: Text(event.title)),
                          subtitle:
                              Center(child: Text(event.timeToEvent(context))),
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
