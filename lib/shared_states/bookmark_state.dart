import 'package:flutter/material.dart';
import '/imports.dart';

class _BookmarkState extends ChangeNotifier {
  String? pin;

  setPin(String? value) async {
    pin = value;

    if (value == null) {
      sharedPrefs.prefs.remove('bookmark_pin');
      return;
    }

    sharedPrefs.prefs.setString('bookmark_pin', value);

    notifyListeners();
  }
}

var bookmarkState = _BookmarkState();
