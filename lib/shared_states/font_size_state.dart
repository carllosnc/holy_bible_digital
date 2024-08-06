import 'package:flutter/material.dart';
import '/imports.dart';

class _FontSizeState extends ChangeNotifier {
  double ratio = 1;

  increaseFontSize() {
    if (ratio < 1.2) {
      ratio += 0.1;
    }

    sharedPrefs.prefs.setDouble('font_size', ratio);
    notifyListeners();
  }

  decreaseFontSize() {
    if (ratio > 1) {
      ratio -= 0.1;
    }

    sharedPrefs.prefs.setDouble('font_size', ratio);
    notifyListeners();
  }

  setFontSize(double value) {
    ratio = value;
    sharedPrefs.prefs.setDouble('font_size', ratio);
    notifyListeners();
  }
}

var fontSizeState = _FontSizeState();
