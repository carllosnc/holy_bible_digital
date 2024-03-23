import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports/app.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.fullLogo,
              height: 110,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 250,
              child: Column(
                children: [
                  const Text(
                    'A tua palavra, Senhor, para sempre está firmada nos céus.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Salmos 119 : 89',
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSurface),
          ),
          onPressed: () {
            sharedPrefs.prefs.setBool('welcome', false);
            context.go('/home');
          },
          child: const Text('Começar'),
        ),
      ),
    );
  }
}
