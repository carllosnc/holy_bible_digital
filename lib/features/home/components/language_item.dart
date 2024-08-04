import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import '/imports.dart';

class LanguageItem extends StatefulWidget {
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
  State<LanguageItem> createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> with SharedState, LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.currentLang == widget.lang //
          ? Theme.of(context).colorScheme.onSurface.withOpacity(0.1)
          : null,
      child: ListTile(
        leading: Image.asset(
          widget.flag,
          width: 25,
          height: 25,
        ),
        trailing: widget.currentLang == widget.lang ? const Icon(Icons.check) : null,
        title: Text(widget.name),
        onTap: () {
          bibleState.setBible(widget.lang);
          localizeState.setLanguage(widget.lang);

          showSnackBar(
            context: context,
            content: Row(
              children: [
                Image.asset(
                  widget.flag,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 10),
                Text("Language changed".localize),
              ],
            ),
          );

          Navigator.pop(context);
        },
      ),
    );
  }
}
