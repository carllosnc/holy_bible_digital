import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports.dart';

class VerseItem extends StatelessWidget {
  final String title;
  final String content;

  const VerseItem({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    String formatedContent = content.replaceAll("&#x27;", "'");

    return ListTile(
      onTap: () {
        Verse verse = Verse(title: title, content: formatedContent);
        context.push('$homePath/verse', extra: verse);
      },
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            formatedContent,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
