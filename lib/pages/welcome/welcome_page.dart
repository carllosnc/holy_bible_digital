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
              width: 270,
              child: Column(
                children: [
                  Text(
                    'Para sempre, ó Senhor, a tua palavra permanece no céu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Salmos 119 : 89'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
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
