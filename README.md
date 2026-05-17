# Holy Bible Digital

[![Bíblia SD](https://github.com/C4co/holy_bible_digital/actions/workflows/dart.yml/badge.svg)](https://github.com/C4co/holy_bible_digital/actions/workflows/dart.yml)

### Commands

Build runner
```
dart run build_runner build --delete-conflicting-outputs
```

Launcher icon
```
dart run flutter_launcher_icons
```

Splash
```
dart run flutter_native_splash:create
```

Build to release (Standard)
```
flutter build appbundle --release
```

Build to release (Shorebird)
```
shorebird release android
```

Note: To sign the release build, create a `key.properties` file in the `android` directory with the following content:
```properties
storePassword=<password>
keyPassword=<password>
keyAlias=<alias>
storeFile=<path-to-keystore-file>
```

---

Carlos Costa @ 2023
