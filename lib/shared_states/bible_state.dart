import 'package:flutter/material.dart';
import '/imports.dart';

class _BibleState extends ChangeNotifier {
  Bible currentBible = Bible(books: [], lang: 'null');

  Future<void> setBible(String lang) async {
    final bible = await readBibleJson(lang);
    currentBible = bible;

    sharedPrefs.prefs.setString('bible', lang);

    notifyListeners();
  }
}

final bibleState = _BibleState();
