import 'package:flutter/material.dart';
import '/imports.dart';

class _FontSizeState extends ChangeNotifier {
  double ratio = 1;

  increaseFontSize() {
    if (ratio < 1.2) {
      ratio += 0.1;
    }

    sharedPrefs.prefs.setDouble(sharedPrefs.FONT_SIZE, ratio);
    notifyListeners();
  }

  decreaseFontSize() {
    if (ratio > 1) {
      ratio -= 0.1;
    }

    sharedPrefs.prefs.setDouble(sharedPrefs.FONT_SIZE, ratio);
    notifyListeners();
  }

  setFontSize(double value) {
    ratio = value;
    sharedPrefs.prefs.setDouble(sharedPrefs.FONT_SIZE, ratio);
    notifyListeners();
  }
}

var fontSizeState = _FontSizeState();
