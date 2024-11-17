import 'package:flutter/material.dart';
import '/imports.dart';

class _BookmarkState extends ChangeNotifier {
  String? pin;

  setPin(String? value) async {
    pin = value;

    if (value == null) {
      sharedPrefs.prefs.remove(sharedPrefs.BOOKMARK_PIN);
      return;
    }

    sharedPrefs.prefs.setString(sharedPrefs.BOOKMARK_PIN, value);

    notifyListeners();
  }
}

var bookmarkState = _BookmarkState();
