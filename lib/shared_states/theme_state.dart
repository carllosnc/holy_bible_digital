import 'package:flutter/material.dart';
import '/imports.dart';

class _ThemeState extends ChangeNotifier {
  bool lightTheme = true;

  setLightTheme(bool value) {
    lightTheme = value;

    sharedPrefs.prefs.setBool('light_theme', value);

    notifyListeners();
  }
}

var themeState = _ThemeState();
