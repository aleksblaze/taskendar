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
  String _selectedLanguage = 'en';
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
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
                  child: Text(value == 'Light' ? localization.light : localization.dark),
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
              title: Text(localization.language),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                items: <String>['en', 'uk'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'en' ? localization.english : localization.ukrainian),
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