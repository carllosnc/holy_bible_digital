import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/imports.dart';

class _BibleState extends ChangeNotifier {
  Bible currentBible = Bible(books: [], lang: 'null');

  Future<void> setBible(String lang) async {
    final bible = await readBibleJson(lang);
    currentBible = bible;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('bible_lang', lang);

    notifyListeners();
  }
}

final bibleState = _BibleState();
