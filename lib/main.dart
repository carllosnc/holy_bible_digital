import 'package:flutter/material.dart';
import '/app.dart';
import '/data/data.dart';
import '/domain/domain.dart';
import '/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //load preferences
  await sharedPrefs.loadPreferences();

  //load shorebird
  await ShoreBird().loadShoreBird();

  //load bible
  final BibleRepository bibleRepository = BibleRepository();
  final Bible bible = await bibleRepository.readBibleJson();
  BibleService().bible = bible;

  runApp(const App());
}
