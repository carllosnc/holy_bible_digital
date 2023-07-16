import 'package:flutter/material.dart';
import 'package:flutter_starter/core/helpers/formaters.dart';
import '/domain/domain.dart';
import '/components/components.dart';

class BookPage extends StatefulWidget {
  final Book book;
  final int page;

  const BookPage({
    super.key,
    required this.book,
    required this.page,
  });

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  late int currentPage;

  @override
  void initState() {
    super.initState();

    currentPage = widget.page;
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.push_pin_outlined),
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
          "${widget.book.name.adaptName()} - Cap: ${currentPage + 1}",
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });

          _scrollController.animateTo(
            ((index * 60) - 170).toDouble(),
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        controller: _pageController,
        children: [
          for (final chapter in widget.book.chapters)
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              itemCount: chapter.length,
              itemBuilder: (context, index) {
                String title =
                    "${widget.book.name} - Cap. ${currentPage + 1} / Ver. ${index + 1}";
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
          itemCount: widget.book.chapters.length,
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
