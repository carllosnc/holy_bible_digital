import 'package:flutter/material.dart';

appTheme({required bool isLight}) => ThemeData(
      useMaterial3: true,
      brightness: isLight ? Brightness.light : Brightness.dark,
      colorSchemeSeed: const Color.fromARGB(255, 0, 60, 255),
      fontFamily: 'SFProDisplay',
    );
