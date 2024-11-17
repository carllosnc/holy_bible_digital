import 'package:flutter/material.dart';
import '/imports.dart';

class _ThemeState extends ChangeNotifier {
  bool lightTheme = true;

  setLightTheme(bool value) {
    lightTheme = value;

    sharedPrefs.prefs.setBool(sharedPrefs.LIGHT_THEME, value);

    notifyListeners();
  }
}

var themeState = _ThemeState();
