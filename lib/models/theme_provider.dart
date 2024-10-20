import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData get themeData => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
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
    );
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
    );
    notifyListeners();
  }
}