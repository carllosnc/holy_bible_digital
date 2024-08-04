import 'package:flutter/material.dart';
import 'book_viewer_bottom.dart';
import 'book_viewer_content.dart';
import 'package:localize/localize.dart';
import 'pin.dart';
import 'arrow.dart';

import '/imports.dart';

class BookViewer extends StatefulWidget {
  final int book;
  final int chapter;

  const BookViewer({
    super.key,
    required this.book,
    required this.chapter,
  });

  @override
  State<BookViewer> createState() => BookViewerState();
}

class BookViewerState extends State<BookViewer> with LocalizeMixin, SharedState {
  late PageController _pageController;
  late ScrollController _scrollController;
  late ScrollController _verseScrollController;
  late int _currentPage;

  num _scrollIndicator = 0;

  @override
  void initState() {
    super.initState();

    _currentPage = widget.chapter;

    _pageController = PageController(
      initialPage: _currentPage,
    );

    _scrollController = ScrollController(
      initialScrollOffset: ((_currentPage * 60)).toDouble(),
    );

    _verseScrollController = ScrollController();
  }

  void pageChangeHandle(index) {
    _verseScrollController = ScrollController();
    double width = MediaQuery.of(context).size.width;

    setState(() {
      _currentPage = index;
    });

    _scrollController.animateTo(
      ((_currentPage * 60) - ((width / 2) - 35)).toDouble(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  bool calculateScrollIndicatorHandle(notification) {
    num total = _verseScrollController.positions.last.maxScrollExtent;

    if (total > 0) {
      num withSize = MediaQuery.of(context).size.width;

      num current = _verseScrollController.positions.last.pixels;

      num percent = current / total;

      num scrollIndicator = withSize * percent;

      setState(() {
        _scrollIndicator = scrollIndicator;
      });
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Book book = bibleState.currentBible.books[widget.book];

    return Scaffold(
      appBar: AppBar(
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
                width: _scrollIndicator.toDouble(),
                color: Theme.of(context).colorScheme.onSurface,
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
          "${book.name.adaptName()} - Cap: ${_currentPage + 1}",
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: BookViewerContent(
        pageController: _pageController,
        verseScrollController: _verseScrollController,
        onScrollNotification: calculateScrollIndicatorHandle,
        onPageChange: pageChangeHandle,
        currentPage: _currentPage,
        book: book,
      ),
      bottomNavigationBar: BookViewerBottom(
        pageController: _pageController,
        scrollController: _scrollController,
        currentPage: _currentPage,
        book: book,
      ),
    );
  }
}
