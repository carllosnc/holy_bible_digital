import 'package:flutter/material.dart';
import '/imports/app.dart';
import './app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //load preferences
  await sharedPrefs.loadPreferences();

  //load shorebird
  await ShoreBird().loadShoreBird();

  runApp(const App());
}
