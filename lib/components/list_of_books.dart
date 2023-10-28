import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holy_bible_digital/notifiers/bible_notifier.dart';
import '/imports/app.dart';
import '/core/extensions/string_extensions.dart';

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
        var books = bible.books
            .where((book) =>
                book.name.toLowerCase().removeDiacritics().contains(searchKey))
            .toList();

        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            Book book = books[index];
            String chapter = labels(bible.lang)["chapter"]
                .toString()
                .pluralize(book.chapters.length);

            return ListTile(
              onTap: () {
                index = bible.books.indexOf(book);

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
