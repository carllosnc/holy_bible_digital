import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required Widget content,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: content,
      ),
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      duration: const Duration(seconds: 1),
    ),
  );
}
