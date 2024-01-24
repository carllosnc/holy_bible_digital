import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports/app.dart';

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
        context.push('/verse', extra: verse);
      },
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            formatedContent,
            style: const TextStyle(
              fontSize: 19,
            ),
          ),
        ],
      ),
    );
  }
}
