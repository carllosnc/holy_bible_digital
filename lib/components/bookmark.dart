import 'package:flutter/material.dart';
import 'package:flutter_starter/core/helpers/formaters.dart';
import 'package:flutter_starter/notifiers/bookmark_notifier.dart';
import 'package:go_router/go_router.dart';
import '/data/data.dart';
import '/domain/domain.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    final BibleService bibleService = BibleService();

    return ValueListenableBuilder(
      valueListenable: BookmarkNotifier().pin,
      builder: (context, value, child) {
        if (value == null) {
          return const SizedBox.shrink();
        }

        int bookIndex = int.parse(value.split('-')[0]);
        int chapterIndex = int.parse(value.split('-')[1]);

        final Book book = bibleService.bible.books[bookIndex];

        return Container(
          height: 45,
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '📌 ${book.name.adaptName()} - Cap. ${chapterIndex + 1}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      onPressed: () {
                        var extras = {
                          'book': bookIndex,
                          'chapter': chapterIndex,
                        };

                        context.go('/book', extra: extras);
                      },
                      child: Text(
                        'Continuar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
