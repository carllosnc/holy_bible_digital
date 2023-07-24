import 'package:flutter/material.dart';
import 'package:holy_bible_digital/core/helpers/formaters.dart';
import '/domain/domain.dart';
import '/components/components.dart';
import '/data/data.dart';

class BookPage extends StatefulWidget {
  final int book;
  final int chapter;

  const BookPage({
    super.key,
    required this.book,
    required this.chapter,
  });

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late PageController _pageController;
  late ScrollController _scrollController;
  final BibleService _bibleService = BibleService();
  late Book _book;
  late int _currentPage;

  // call this function when the page is created
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
  }

  // call this function when a page is changed
  void pageChangeHandle(index) {
    setState(() {
      _currentPage = index;
    });

    _scrollController.animateTo(
      ((_currentPage * 60) - 170).toDouble(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            height: 1,
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
      body: PageView(
        onPageChanged: pageChangeHandle,
        controller: _pageController,
        children: [
          for (final chapter in _book.chapters)
            ListView.separated(
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
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        height: 70,
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemCount: _book.chapters.length,
          itemBuilder: (context, index) {
            if (index == _currentPage) {
              return GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(index);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }

            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
