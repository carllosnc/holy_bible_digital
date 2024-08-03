import 'package:shared_preferences/shared_preferences.dart';
import '/imports.dart';

class _SharedPrefs {
  late final SharedPreferences prefs;

  loadPreferences() async {
    prefs = await SharedPreferences.getInstance();

    // get from shared preferences
    final bool? welcome = prefs.getBool('welcome');
    final String? bookmarkPin = prefs.getString('bookmark_pin');
    final String? bibleLang = prefs.getString('bible_lang');
    final bool? lightTheme = prefs.getBool('light_theme');

    await bibleNotifier.setBible(bibleLang ?? 'pt-br');

    // set bookmark pin to the bookmark notifier
    if (bookmarkPin != null) {
      bookmarkState.setPin(bookmarkPin);
    }

    // set welcome to the welcome notifier
    if (welcome == null) {
      prefs.setBool('welcome', true);
    }

    // set light theme to the theme notifier
    if (lightTheme != null) {
      themeState.setLightTheme(lightTheme);
    }
  }
}

var sharedPrefs = _SharedPrefs();
