import 'package:shared_preferences/shared_preferences.dart';
import '/notifiers/notifiers.dart';

class _SharedPrefs {
  late final SharedPreferences prefs;

  loadPreferences() async {
    prefs = await SharedPreferences.getInstance();

    //get from shared preferences
    final bool? lightTheme = prefs.getBool('lightTheme');
    final bool? welcome = prefs.getBool('welcome');
    final String? bookmarkPin = prefs.getString('bookmark_pin');

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
