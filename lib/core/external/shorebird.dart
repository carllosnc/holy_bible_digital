import 'package:shorebird_code_push/shorebird_code_push.dart';

class ShoreBird {
  static final ShoreBird _sharedPrefs = ShoreBird._internal();
  late final ShorebirdCodePush shoreBird = ShorebirdCodePush();
  late dynamic pathNumber;

  factory ShoreBird() {
    return _sharedPrefs;
  }

  ShoreBird._internal();

  loadShoreBird() async {
    pathNumber = await shoreBird.currentPatchNumber();
  }
}
