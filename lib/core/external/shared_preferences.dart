// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';
import '/imports.dart';

class _SharedPrefs {
  late final SharedPreferences prefs;

  final WELCOME = 'welcome';
  final BOOKMARK_PIN = 'bookmark_pin';
  final BIBLE_LANG = 'bible_lang';
  final LIGHT_THEME = 'light_theme';
  final FONT_SIZE = 'font_size';

  loadPreferences() async {
    prefs = await SharedPreferences.getInstance();

    // get from shared preferences
    final bool? welcome = prefs.getBool(WELCOME);
    final String? bookmarkPin = prefs.getString(BOOKMARK_PIN);
    final String? bibleLang = prefs.getString(BIBLE_LANG);
    final bool? lightTheme = prefs.getBool(LIGHT_THEME);
    final double? fontSize = prefs.getDouble(FONT_SIZE);

    await bibleState.setBible(bibleLang ?? Langs.portuguese.abbr);

    // set bookmark pin to the bookmark notifier
    if (bookmarkPin != null) {
      bookmarkState.setPin(bookmarkPin);
    }

    // set welcome to the welcome notifier
    if (welcome == null) {
      prefs.setBool(WELCOME, true);
    }

    // set light theme to the theme notifier
    if (lightTheme != null) {
      themeState.setLightTheme(lightTheme);
    }

    // set font size to the font size notifier
    if (fontSize != null) {
      fontSizeState.setFontSize(fontSize);
    }
  }
}

final sharedPrefs = _SharedPrefs();
