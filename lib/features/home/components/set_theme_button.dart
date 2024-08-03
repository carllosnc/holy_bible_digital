import 'package:flutter/material.dart';
import '/imports.dart';

class SetThemeButton extends StatefulWidget {
  const SetThemeButton({super.key});

  @override
  State<SetThemeButton> createState() => _SetThemeButtonState();
}

class _SetThemeButtonState extends State<SetThemeButton> with SharedState {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        themeState.setLightTheme(!themeState.lightTheme);
      },
      icon: Icon(
        themeState.lightTheme ? Icons.light_mode_outlined : Icons.dark_mode,
      ),
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
