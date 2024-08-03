import 'package:flutter/material.dart';
import '/imports.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SharedState {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appTheme(isLight: themeState.lightTheme),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
