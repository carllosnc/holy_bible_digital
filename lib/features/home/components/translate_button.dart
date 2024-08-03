import 'package:flutter/material.dart';
import '/imports.dart';
import 'language_item.dart';

class TranslateButton extends StatelessWidget {
  const TranslateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bibleNotifier.currentBible,
      builder: (context, Bible bible, child) {
        return IconButton(
          icon: const Icon(
            Icons.translate_outlined,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    title: Text(
                      labels(bible.lang)['translates'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        LanguageItem(
                          flag: Assets.flagPtbr,
                          lang: 'pt-br',
                          currentLang: bible.lang,
                          name: labels(bible.lang)['portuguese']!,
                        ),
                        LanguageItem(
                          flag: Assets.flagUs,
                          lang: 'en',
                          currentLang: bible.lang,
                          name: labels(bible.lang)['english']!,
                        ),
                        LanguageItem(
                          flag: Assets.flagFr,
                          lang: 'fr',
                          currentLang: bible.lang,
                          name: labels(bible.lang)['french']!,
                        ),
                        LanguageItem(
                          flag: Assets.flagIt,
                          lang: 'it',
                          currentLang: bible.lang,
                          name: labels(bible.lang)['italian']!,
                        ),
                        LanguageItem(
                          flag: Assets.flagEs,
                          lang: 'es',
                          currentLang: bible.lang,
                          name: labels(bible.lang)['spanish']!,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
