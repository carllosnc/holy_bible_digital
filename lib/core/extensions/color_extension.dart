import 'package:flutter/material.dart';
import '/imports.dart';

extension ColorExtension on BuildContext {
  Color get textColor => themeState.lightTheme //;
      ? Colors.black.withOpacity(0.7)
      : const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.45);

  Color get titleColor => themeState.lightTheme //;
      ? Colors.black
      : const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.7);

  Color get lineColor => themeState.lightTheme //;
      ? Colors.black.withOpacity(0.2)
      : Colors.white.withOpacity(0.15);

  Color get buttonColor => themeState.lightTheme //;
      ? Colors.black
      : const Color(0xFF333c48);

  Color get buttonTextColor => themeState.lightTheme //;
      ? Colors.white
      : Colors.white;
}
