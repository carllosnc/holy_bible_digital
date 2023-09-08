part of './book_viewer.dart';

extension BookViewerHeader on BookViewerState {
  AppBar bookViewerHeader(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              height: 0,
            ),
            Container(
              width: schollIndicator.toDouble(),
              color: Theme.of(context).colorScheme.primary,
              height: 4,
            ),
          ],
        ),
      ),
      actions: [
        Pin(
          key: UniqueKey(),
          book: widget.book,
          chapter: _currentPage,
        ),
        Arrow(
          key: UniqueKey(),
          type: ArrowType.previous,
          pageController: _pageController,
          currentPage: _currentPage,
        ),
        Arrow(
          key: UniqueKey(),
          type: ArrowType.next,
          pageController: _pageController,
          currentPage: _currentPage,
        ),
      ],
      title: Text(
        "${_book.name.adaptName()} - Cap: ${_currentPage + 1}",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
