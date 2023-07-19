import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkNotifier {
  static final BookmarkNotifier _themeNotifier = BookmarkNotifier._internal();

  factory BookmarkNotifier() {
    return _themeNotifier;
  }

  BookmarkNotifier._internal();

  ValueNotifier<String?> pin = ValueNotifier<String?>(null);

  setPin(String value) async {
    pin.value = value;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('bookmark_pin', value);
  }
}
