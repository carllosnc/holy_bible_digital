import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '/imports.dart';

class Bookmark extends StatefulWidget {
  final Bible bible;

  const Bookmark({super.key, required this.bible});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> with SharedState {
  @override
  Widget build(BuildContext context) {
    if (bookmarkState.pin == null) {
      return const SizedBox.shrink();
    }

    int bookIndex = int.parse(bookmarkState.pin!.split('-')[0]);
    int chapterIndex = int.parse(bookmarkState.pin!.split('-')[1]);

    final Book book = widget.bible.books[bookIndex];

    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
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
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onPressed: () {
                    var extras = {
                      'book': bookIndex,
                      'chapter': chapterIndex,
                    };
                    context.go('$homePath/book', extra: extras);
                  },
                  child: Text(labels(widget.bible.lang)['continue']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
