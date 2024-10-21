import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;
  String _selectedTheme;

  ThemeProvider(this._themeData) : _selectedTheme = 'Light';

  ThemeData get themeData => _themeData;
  String get selectedTheme => _selectedTheme;

  void setTheme(ThemeData themeData, String themeName) {
    _themeData = themeData;
    _selectedTheme = themeName;
    notifyListeners();
  }

  void setLightTheme() {
    _themeData = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      useMaterial3: false,
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Roboto'),
        bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: 'Roboto'),
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
    _selectedTheme = 'Light';
    notifyListeners();
  }

  void setDarkTheme() {
    _themeData = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      useMaterial3: false,
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'OpenSans'),
        bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: 'OpenSans'),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontFamily: 'OpenSans',
        ),
      ),
    );
    _selectedTheme = 'Dark';
    notifyListeners();
  }
}