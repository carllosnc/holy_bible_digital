import 'package:flutter/material.dart';
import '/imports/app.dart';
import './book_viewer_bottom.dart';
import './book_viewer_content.dart';

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

class BookViewerState extends State<BookViewer> {
  late PageController _pageController;
  late ScrollController _scrollController;
  late ScrollController _verseScrollController;
  final BibleService _bibleService = BibleService();
  late Book _book;
  late int _currentPage;

  num schollIndicator = 0;

  @override
  void initState() {
    super.initState();

    _currentPage = widget.chapter;
    _book = _bibleService.bible.books[widget.book];

    _pageController = PageController(
      initialPage: _currentPage,
    );

    _scrollController = ScrollController(
      initialScrollOffset: ((_currentPage * 60) - 170).toDouble(),
    );

    _verseScrollController = ScrollController();
  }

  // call this function when a page is changed
  void pageChangeHandle(index) {
    _verseScrollController = ScrollController();

    setState(() {
      _currentPage = index;
    });

    _scrollController.animateTo(
      ((_currentPage * 60) - 170).toDouble(),
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
        schollIndicator = scrollIndicator;
      });
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: BookViewerContent(
        pageController: _pageController,
        verseScrollController: _verseScrollController,
        onScrollNotification: calculateScrollIndicatorHandle,
        onPageChange: pageChangeHandle,
        currentPage: _currentPage,
        book: _book,
      ),
      bottomNavigationBar: BookViewerBottom(
        pageController: _pageController,
        scrollController: _scrollController,
        currentPage: _currentPage,
        book: _book,
      ),
    );
  }
}
