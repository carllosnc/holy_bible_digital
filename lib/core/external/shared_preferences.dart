import 'package:shared_preferences/shared_preferences.dart';
import '/notifiers/notifiers.dart';

class SharedPrefs {
  static final SharedPrefs _sharedPrefs = SharedPrefs._internal();
  late final SharedPreferences prefs;

  factory SharedPrefs() {
    return _sharedPrefs;
  }

  SharedPrefs._internal();

  loadPreferences() async {
    prefs = await SharedPreferences.getInstance();

    //get from shared preferences
    final bool? lightTheme = prefs.getBool('lightTheme');
    final bool? welcome = prefs.getBool('welcome');
    final String? bookmarkPin = prefs.getString('bookmark_pin');

    // set bookmark pin to the bookmark notifier
    if (bookmarkPin != null) {
      BookmarkNotifier().setPin(bookmarkPin);
    }

    // set welcome to the welcome notifier
    if (welcome == null) {
      prefs.setBool('welcome', true);
    }

    // set theme to the theme notifier
    if (lightTheme != null) {
      ThemeNotifier().lightTheme.value = lightTheme;
    }
  }
}
