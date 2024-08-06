import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localize/localize.dart';
import '/imports.dart';

class BookList extends StatefulWidget {
  final String searchKey;

  const BookList({
    super.key,
    this.searchKey = '',
  });

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> with LocalizeMixin, SharedState {
  String testament({
    required int index,
    required String lang,
  }) {
    if (index < 39) {
      return "Old testament".localize;
    } else {
      return "New testament".localize;
    }
  }

  @override
  Widget build(BuildContext context) {
    var books = bibleState
        .currentBible //
        .books
        .where((book) => book.name.toLowerCase().removeDiacritics().contains(widget.searchKey))
        .toList();

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        Book book = books[index];
        String chapter = "Chapter".localize.pluralize(book.chapters.length);

        return ListTile(
          onTap: () {
            index = bibleState.currentBible.books.indexOf(book);

            var extras = {
              'book': index,
              'chapter': 0,
            };

            context.push('$homePath/book', extra: extras);
          },
          title: Text(
            book.name,
            style: TextStyle(
              fontSize: 23 * fontSizeState.ratio,
              fontWeight: FontWeight.w600,
            ),
          ),
          // trailing: const Icon(Icons.chevron_right_outlined),
          subtitle: Text(
            style: TextStyle(
              color: context.textColor,
              fontSize: 16 * fontSizeState.ratio,
            ),
            '${book.chapters.length} $chapter · ${testament(
              index: index,
              lang: bibleState.currentBible.lang,
            )}',
          ),
        );
      },
    );
  }
}
