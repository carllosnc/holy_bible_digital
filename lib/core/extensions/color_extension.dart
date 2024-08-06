import 'package:flutter/material.dart';
import '/imports.dart';

extension ColorExtension on BuildContext {
  Color get textColor => themeState.lightTheme //;
      ? Colors.black.withOpacity(0.7)
      : Colors.white.withOpacity(0.45);

  Color get lineColor => themeState.lightTheme //;
      ? Colors.black.withOpacity(0.2)
      : Colors.white.withOpacity(0.15);

  Color get buttonColor => themeState.lightTheme //;
      ? Colors.black
      : Theme.of(this).colorScheme.secondaryContainer.withOpacity(0.6);

  Color get buttonTextColor => themeState.lightTheme //;
      ? Colors.white
      : Colors.white;
}
