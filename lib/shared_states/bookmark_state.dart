import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _BookmarkState extends ChangeNotifier {
  String? pin;

  setPin(String? value) async {
    pin = value;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value == null) {
      prefs.remove('bookmark_pin');
      return;
    }

    prefs.setString('bookmark_pin', value);

    notifyListeners();
  }
}

var bookmarkState = _BookmarkState();
