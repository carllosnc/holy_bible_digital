import 'package:flutter/material.dart';
import 'package:holy_bible_digital/imports.dart';

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

          showSnackBar(
            context: context,
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
          );

          Navigator.pop(context);
        },
      ),
    );
  }
}
