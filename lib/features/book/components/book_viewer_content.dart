import 'package:flutter/material.dart';
import 'verse_item.dart';
import '/imports.dart';

typedef PageChangeHandle = void Function(int index);
typedef ScrollNotificationHandle = bool Function(Notification notification);

class BookViewerContent extends StatelessWidget {
  final PageController pageController;
  final ScrollController verseScrollController;
  final ScrollNotificationHandle onScrollNotification;
  final PageChangeHandle onPageChange;
  final int currentPage;
  final Book book;

  const BookViewerContent({
    super.key,
    required this.pageController,
    required this.verseScrollController,
    required this.onScrollNotification,
    required this.onPageChange,
    required this.currentPage,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: onPageChange,
      controller: pageController,
      children: [
        for (final chapter in book.chapters)
          NotificationListener(
            onNotification: onScrollNotification,
            child: ListView.separated(
              controller: verseScrollController,
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                height: 10,
              ),
              padding: const EdgeInsets.symmetric(vertical: 5),
              itemCount: chapter.length,
              itemBuilder: (context, index) {
                String title = "${book.name} - Cap. ${currentPage + 1} / Ver. ${index + 1}";
                String content = chapter[index];

                return VerseItem(title: title, content: content);
              },
            ),
          ),
      ],
    );
  }
}
