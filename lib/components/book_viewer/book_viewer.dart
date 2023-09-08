import 'package:flutter/material.dart';
import '/imports/app.dart';

part './book_viewer_header.dart';
part './book_viewer_content.dart';
part './book_viewer_bottom.dart';

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

  bool calculateScrollIndicator(notification) {
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
      appBar: bookViewerHeader(context),
      body: bookViewerContent(),
      bottomNavigationBar: bookViewerBottom(context),
    );
  }
}
