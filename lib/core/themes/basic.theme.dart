import 'package:flutter/material.dart';

appTheme({required bool isLight}) => ThemeData(
      useMaterial3: true,
      brightness: isLight ? Brightness.light : Brightness.dark,
      colorSchemeSeed: const Color.fromARGB(255, 255, 0, 0),
      fontFamily: 'SFProDisplay',
    );
