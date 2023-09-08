import 'package:flutter/material.dart';
import '/imports/app.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    if (ShoreBird().pathNumber != null) {
      return Text(
        'V0.${ShoreBird().pathNumber}',
        style: const TextStyle(fontSize: 10),
      );
    }

    return const SizedBox.shrink();
  }
}
