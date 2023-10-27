import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ThemeNotifier {
  ValueNotifier<bool> lightTheme = ValueNotifier<bool>(true);

  setLightTheme(bool value) async {
    lightTheme.value = value;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('lightTheme', value);
  }
}

var themeNotifier = _ThemeNotifier();
