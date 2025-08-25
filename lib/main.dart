import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize/localize.dart';
import '/imports.dart';
import '/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  localizeState.init(content: localizeLabels);

  //load preferences
  await sharedPrefs.loadPreferences();

  //load database
  await bibleDatabase.init();

  //lock screen to landscape
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //specific platform
  await windowsPlatform();

  runApp(const App());
}
