import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _BookmarkNotifier {
  ValueNotifier<String?> pin = ValueNotifier<String?>(null);

  setPin(String value) async {
    pin.value = value;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('bookmark_pin', value);
  }
}

var bookmarkNotifier = _BookmarkNotifier();
