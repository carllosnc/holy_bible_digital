import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import 'save_verse_action.dart';
import '/imports.dart';

class SaveVerse extends StatefulWidget {
  final String title;
  final String content;

  const SaveVerse({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<SaveVerse> createState() => _SaveVerseState();
}

class _SaveVerseState extends State<SaveVerse> with LocalizeMixin, SharedState {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.bookmark_add_outlined),
      onPressed: () {
        saveVerseAction(
          context: context,
          title: widget.title,
          content: widget.content,
        );
      },
    );
  }
}
