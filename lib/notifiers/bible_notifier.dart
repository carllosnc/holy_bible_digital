import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/imports.dart';

class _BibleNotifier {
  ValueNotifier<Bible> currentBible = ValueNotifier<Bible>(
    Bible(books: [], lang: 'null'),
  );

  Future<void> setBible(String lang) async {
    final bible = await readBibleJson(lang);
    currentBible.value = bible;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('bible_lang', lang);
  }
}

var bibleNotifier = _BibleNotifier();
