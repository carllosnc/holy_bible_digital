import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../verse/components/save_verse_action.dart';
import '/imports.dart';

class VerseItem extends StatefulWidget {
  final String title;
  final String content;

  const VerseItem({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<VerseItem> createState() => _VerseItemState();
}

class _VerseItemState extends State<VerseItem> with SharedState {
  @override
  Widget build(BuildContext context) {
    String formatedContent = widget.content.replaceAll("&#x27;", "'");

    return ListTile(
      onTap: () {
        Verse verse = Verse(title: widget.title, content: formatedContent);
        context.push('$homePath/verse', extra: verse);
      },
      onLongPress: () {
        saveVerseAction(
          context: context,
          title: widget.title,
          content: formatedContent,
        );
      },
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title.toUpperCase(),
            style: TextStyle(
              fontSize: 11 * fontSizeState.ratio,
              fontWeight: FontWeight.w800,
              color: context.titleColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            formatedContent,
            style: TextStyle(
              fontSize: 20 * fontSizeState.ratio,
              color: context.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
