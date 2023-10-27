import 'package:flutter/material.dart';
import '/imports/app.dart';

class Welcome extends StatelessWidget {
  final Function onPressed;

  const Welcome({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.welcome),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
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
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: FilledButton(
          onPressed: () {
            sharedPrefs.prefs.setBool('welcome', false);

            onPressed();
          },
          child: const Text('Começar'),
        ),
      ),
    );
  }
}
