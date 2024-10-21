import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskendar/models/theme_provider.dart';
import 'package:taskendar/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool switchValue = false;
  String _selectedTheme = 'Light';
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    _selectedTheme = themeProvider.selectedTheme;
    _selectedLanguage = localeProvider.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.settings),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text(localization.notifications),
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });
              },
            ),
            ListTile(
              title: Text(localization.theme),
              trailing: DropdownButton<String>(
                value: _selectedTheme,
                items: <String>['Light', 'Dark'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTheme = newValue!;
                    if (_selectedTheme == 'Light') {
                      themeProvider.setLightTheme();
                    } else {
                      themeProvider.setDarkTheme();
                    }
                  });
                },
              ),
            ),
            ListTile(
              title: Text(localization.language),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                items: <String>['English', 'Ukrainian'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                    if (_selectedLanguage == 'English') {
                      localeProvider.setLocale(Locale('en'), 'English');
                    } else {
                      localeProvider.setLocale(Locale('uk'), 'Ukrainian');
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}