part of './book_viewer.dart';

extension BookViewerContent on BookViewerState {
  PageView bookViewerContent() {
    return PageView(
      onPageChanged: pageChangeHandle,
      controller: _pageController,
      children: [
        for (final chapter in _book.chapters)
          NotificationListener(
            onNotification: calculateScrollIndicator,
            child: ListView.separated(
              controller: _verseScrollController,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              itemCount: chapter.length,
              itemBuilder: (context, index) {
                String title =
                    "${_book.name} - Cap. ${_currentPage + 1} / Ver. ${index + 1}";
                String content = chapter[index];

                return VerseItem(title: title, content: content);
              },
            ),
          ),
      ],
    );
  }
}
