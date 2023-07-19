import 'package:flutter/material.dart';
import 'package:flutter_starter/core/helpers/formaters.dart';
import '/domain/domain.dart';
import '/components/components.dart';
import '/data/data.dart';
import '/notifiers/notifiers.dart';

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
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final BibleService bibleService = BibleService();
  bool pinned = false;
  late Book book;
  late int currentPage;

  // call this function when the page is created
  @override
  void initState() {
    super.initState();

    currentPage = widget.chapter;
    book = bibleService.bible.books[widget.book];

    if (BookmarkNotifier().pin.value == "${widget.book}-$currentPage") {
      pinned = true;
    }
  }

  // call this function when a page is changed
  void pageChangeHandle(index) {
    if (BookmarkNotifier().pin.value == "${widget.book}-$index") {
      setState(() {
        pinned = true;
      });
    } else {
      setState(() {
        pinned = false;
      });
    }

    setState(() {
      currentPage = index;
    });

    _scrollController.animateTo(
      ((index * 60) - 170).toDouble(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  // call this function when a chapter is pinned
  void pinChangeHandle() async {
    setState(() {
      pinned = true;
    });

    BookmarkNotifier().setPin("${widget.book}-$currentPage");
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
          CircleAvatar(
            backgroundColor: pinned
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background,
            child: IconButton(
              onPressed: pinChangeHandle,
              icon: Icon(
                Icons.push_pin_outlined,
                color: pinned
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _pageController.animateToPage(
                currentPage - 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            icon: const Icon(Icons.chevron_left),
          ),
          IconButton(
            onPressed: () {
              _pageController.animateToPage(
                currentPage + 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            icon: const Icon(Icons.chevron_right),
          ),
        ],
        title: Text(
          "${book.name.adaptName()} - Cap: ${currentPage + 1}",
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: PageView(
        onPageChanged: pageChangeHandle,
        controller: _pageController,
        children: [
          for (final chapter in book.chapters)
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              itemCount: chapter.length,
              itemBuilder: (context, index) {
                String title =
                    "${book.name} - Cap. ${currentPage + 1} / Ver. ${index + 1}";
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
          itemCount: book.chapters.length,
          itemBuilder: (context, index) {
            if (index == currentPage) {
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
