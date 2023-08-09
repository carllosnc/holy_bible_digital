import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holy_bible_digital/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';

class ListOfBooks extends StatelessWidget {
  final String searchKey;

  const ListOfBooks({
    super.key,
    this.searchKey = '',
  });

  @override
  Widget build(BuildContext context) {
    final BibleService bibleService = BibleService();

    String testament(int index) {
      if (index < 39) {
        return 'Velho testamento';
      } else {
        return 'Novo testamento';
      }
    }

    // filter books by searchKey
    var books = bibleService.bible.books
        .where((book) =>
            book.name.toLowerCase().removeDiacritics().contains(searchKey))
        .toList();

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        Book book = books[index];

        return ListTile(
          onTap: () {
            index = bibleService.bible.books.indexOf(book);

            var extras = {
              'book': index,
              'chapter': 0,
            };

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
            '${book.chapters.length} Capítulos · ${testament(index)}',
          ),
        );
      },
    );
  }
}
