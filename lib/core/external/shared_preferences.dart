import 'package:holy_bible_digital/notifiers/bible_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/imports/app.dart';

class _SharedPrefs {
  late final SharedPreferences prefs;

  loadPreferences() async {
    prefs = await SharedPreferences.getInstance();

    // get from shared preferences
    final bool? lightTheme = prefs.getBool('lightTheme');
    final bool? welcome = prefs.getBool('welcome');
    final String? bookmarkPin = prefs.getString('bookmark_pin');
    final String? bibleLang = prefs.getString('bible_lang');

    await bibleNotifier.setBible(bibleLang ?? 'pt-br');

    // set bookmark pin to the bookmark notifier
    if (bookmarkPin != null) {
      bookmarkNotifier.setPin(bookmarkPin);
    }

    // set welcome to the welcome notifier
    if (welcome == null) {
      prefs.setBool('welcome', true);
    }

    // set theme to the theme notifier
    if (lightTheme != null) {
      themeNotifier.lightTheme.value = lightTheme;
    }
  }
}

var sharedPrefs = _SharedPrefs();
