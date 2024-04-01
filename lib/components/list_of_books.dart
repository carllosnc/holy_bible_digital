import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/extensions/string_extensions.dart';
import '/imports.dart';

class ListOfBooks extends StatelessWidget {
  final String searchKey;

  const ListOfBooks({
    super.key,
    this.searchKey = '',
  });

  String testament({
    required int index,
    required String lang,
  }) {
    if (index < 39) {
      return labels(lang)["old testament"];
    } else {
      return labels(lang)["new testament"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bibleNotifier.currentBible,
      builder: (context, Bible bible, child) {
        var books = bible //
            .books
            .where((book) => book.name.toLowerCase().removeDiacritics().contains(searchKey))
            .toList();

        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            Book book = books[index];
            String chapter = labels(bible.lang)["chapter"].toString().pluralize(book.chapters.length);

            return ListTile(
              onTap: () {
                index = bible.books.indexOf(book);

                var extras = {
                  'book': index,
                  'chapter': 0,
                };

                context.push('$homePath/book', extra: extras);
              },
              title: Text(
                book.name,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(Icons.chevron_right_outlined),
              subtitle: Text(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  fontSize: 16,
                ),
                '${book.chapters.length} $chapter · ${testament(
                  index: index,
                  lang: bible.lang,
                )}',
              ),
            );
          },
        );
      },
    );
  }
}
