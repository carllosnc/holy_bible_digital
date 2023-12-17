import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/imports/app.dart';
import './app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //load preferences
  await sharedPrefs.loadPreferences();

  //load shorebird
  await ShoreBird().loadShoreBird();

  //lock screen to landscape
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //specific platform
  await windowsPlatform();

  runApp(const App());
}
