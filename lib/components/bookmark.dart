import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '/notifiers/notifiers.dart';
import '/data/data.dart';
import '/domain/domain.dart';
import '/core/core.dart';

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
          height: 55,
          color:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.7),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        //icon pin
                        const Icon(
                          Icons.push_pin_outlined,
                          size: 20,
                        ),
                        Text(
                          '${book.name.adaptName()} - Cap. ${chapterIndex + 1}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: FilledButton(
                      onPressed: () {
                        var extras = {
                          'book': bookIndex,
                          'chapter': chapterIndex,
                        };
                        context.go('/book', extra: extras);
                      },
                      child: const Text(
                        'Continuar',
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
