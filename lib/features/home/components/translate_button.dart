import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import '/imports.dart';
import 'language_item.dart';

class TranslateButton extends StatefulWidget {
  const TranslateButton({
    super.key,
  });

  @override
  State<TranslateButton> createState() => _TranslateButtonState();
}

class _TranslateButtonState extends State<TranslateButton> with LocalizeMixin, SharedState {
  @override
  Widget build(BuildContext context) {
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
                  "Translates".localize,
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
                      lang: Langs.portuguese.abbr,
                      currentLang: localizeState.currentLanguage,
                      name: "Portuguese".localize,
                    ),
                    LanguageItem(
                      flag: Assets.flagUs,
                      lang: Langs.english.abbr,
                      currentLang: localizeState.currentLanguage,
                      name: "English".localize,
                    ),
                    LanguageItem(
                      flag: Assets.flagFr,
                      lang: Langs.french.abbr,
                      currentLang: localizeState.currentLanguage,
                      name: "French".localize,
                    ),
                    LanguageItem(
                      flag: Assets.flagIt,
                      lang: Langs.italian.abbr,
                      currentLang: localizeState.currentLanguage,
                      name: "Italian".localize,
                    ),
                    LanguageItem(
                      flag: Assets.flagEs,
                      lang: Langs.spanish.abbr,
                      currentLang: localizeState.currentLanguage,
                      name: "Spanish".localize,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
