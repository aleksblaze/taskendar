import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskendar/models/themeProvider.dart';
import 'package:taskendar/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool switchValue = false;
  String _selectedTheme = 'Light';
  String _selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.notifications),
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.theme),
              trailing: DropdownButton<String>(
                value: _selectedTheme,
                items: <String>['Light', 'Dark'].map((String value) {
                  return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value == 'Light' ? AppLocalizations.of(context)!.light : AppLocalizations.of(context)!.dark),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTheme = newValue!;
                  });
                  if (newValue != null) {
                    _changeTheme(context, newValue);
                  }
                },
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                items: <String>['en', 'uk'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'en' ? AppLocalizations.of(context)!.english : AppLocalizations.of(context)!.ukrainian),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                  if (newValue != null) {
                    _changeLanguage(context, newValue);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeTheme(BuildContext context, String theme) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    if (theme == 'Light') {
      themeProvider.setLightTheme();
    } else if (theme == 'Dark') {
      themeProvider.setDarkTheme();
    }
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    LocaleProvider localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    localeProvider.setLocale(Locale(languageCode));
  }
}