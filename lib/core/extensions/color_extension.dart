import 'package:flutter/material.dart';
import '/imports.dart';

extension ColorExtension on BuildContext {
  Color get textColor => themeState.lightTheme //;
      ? Colors.black.withValues(alpha: 0.7)
      : const Color.fromRGBO(255, 255, 255, 1).withValues(alpha: 0.45);

  Color get titleColor => themeState.lightTheme //;
      ? Colors.black
      : const Color.fromRGBO(255, 255, 255, 1).withValues(alpha: 0.7);

  Color get lineColor => themeState.lightTheme //;
      ? Colors.black.withValues(alpha: 0.2)
      : Colors.white.withValues(alpha: 0.15);

  Color get buttonColor => themeState.lightTheme //;
      ? Colors.black
      : const Color(0xFF333c48);

  Color get buttonTextColor => themeState.lightTheme //;
      ? Colors.white
      : Colors.white;
}
