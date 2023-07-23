import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/data/data.dart';
import '/domain/domain.dart';

class ListOfBooks extends StatelessWidget {
  const ListOfBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final BibleService bibleService = BibleService();

    String testament(int index) {
      if (index < 39) {
        return 'VT';
      } else {
        return 'NT';
      }
    }

    return ListView.builder(
      itemCount: bibleService.bible.books.length,
      itemBuilder: (context, index) {
        Book book = bibleService.bible.books[index];

        var extras = {
          'book': index,
          'chapter': 0,
        };

        return ListTile(
          onTap: () {
            context.push('/book', extra: extras);
          },
          title: Text(
            book.name,
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          trailing: const Icon(Icons.chevron_right_outlined),
          subtitle: Text(
            '${testament(index)} · ${book.chapters.length} capítulos',
          ),
        );
      },
    );
  }
}
