import 'package:flutter/material.dart';
import '/imports/app.dart';
import '/notifiers/bible_notifier.dart';

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
                return SizedBox(
                  height: 450,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        width: double.infinity,
                        child: Text(
                          labels(bible.lang)['translates'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            LanguageItem(
                              flag: Assets.flagPtbr,
                              lang: 'pt-br',
                              currentLang: bible.lang,
                              name: 'Português',
                            ),
                            LanguageItem(
                              flag: Assets.flagUs,
                              lang: 'en',
                              currentLang: bible.lang,
                              name: 'English',
                            ),
                            LanguageItem(
                              flag: Assets.flagFr,
                              lang: 'fr',
                              currentLang: bible.lang,
                              name: 'Français',
                            ),
                            LanguageItem(
                              flag: Assets.flagIt,
                              lang: 'it',
                              currentLang: bible.lang,
                              name: 'Italiano',
                            ),
                            LanguageItem(
                              flag: Assets.flagEs,
                              lang: 'es',
                              currentLang: bible.lang,
                              name: 'Español',
                            ),
                          ],
                        ),
                      ),
                    ],
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

class LanguageItem extends StatelessWidget {
  final String flag;
  final String lang;
  final String currentLang;
  final String name;

  const LanguageItem({
    super.key,
    required this.flag,
    required this.lang,
    required this.currentLang,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: currentLang == lang //
          ? Theme.of(context).colorScheme.onSurface.withOpacity(0.1)
          : null,
      child: ListTile(
        leading: Image.asset(
          flag,
          width: 25,
          height: 25,
        ),
        trailing: currentLang == lang ? const Icon(Icons.check) : null,
        title: Text(name),
        onTap: () {
          bibleNotifier.setBible(lang);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              content: Row(
                children: [
                  Image.asset(
                    flag,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  Text("${labels(lang)["lang changed"]} $name"),
                ],
              ),
              duration: const Duration(seconds: 2),
            ),
          );

          Navigator.pop(context);
        },
      ),
    );
  }
}
