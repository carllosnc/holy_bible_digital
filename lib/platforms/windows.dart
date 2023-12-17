import 'dart:io';
import 'dart:ui';
import 'package:window_manager/window_manager.dart';

windowsPlatform() async {
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(500, 800),
      title: "Bíblia Sagrada Digital",
      center: true,
      minimumSize: Size(400, 700),
      maximumSize: Size(800, 900),
      fullScreen: false,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setMaximizable(false);

      await windowManager.show();
      await windowManager.focus();
    });
  }
}
