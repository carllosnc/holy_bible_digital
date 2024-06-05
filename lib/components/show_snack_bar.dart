import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required Widget content,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: content,
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.onSurface,
      duration: const Duration(seconds: 1),
    ),
  );
}
