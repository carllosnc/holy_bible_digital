import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import '/imports.dart';

class HomeTitle extends StatefulWidget {
  const HomeTitle({
    super.key,
  });

  @override
  State<HomeTitle> createState() => _HomeTitleState();
}

class _HomeTitleState extends State<HomeTitle> with SharedState, LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    Bible bible = bibleState.currentBible;

    var flag = Assets.flagPtbr;

    if (bible.lang == Langs.english.abbr) {
      flag = Assets.flagUs;
    } else if (bible.lang == Langs.french.abbr) {
      flag = Assets.flagFr;
    } else if (bible.lang == Langs.italian.abbr) {
      flag = Assets.flagIt;
    } else if (bible.lang == Langs.spanish.abbr) {
      flag = Assets.flagEs;
    }

    return Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Image.asset(
          flag,
          width: 20,
          height: 20,
        ),
        Text(
          "Holy Bible".localize,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
