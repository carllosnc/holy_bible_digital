import 'package:flutter/material.dart';
import '/imports.dart';

class BookViewerBottom extends StatelessWidget {
  final PageController pageController;
  final ScrollController scrollController;
  final int currentPage;
  final Book book;

  const BookViewerBottom({
    super.key,
    required this.pageController,
    required this.scrollController,
    required this.currentPage,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.lineColor,
            width: 1,
          ),
        ),
      ),
      height: 70,
      child: ListView.separated(
        controller: scrollController,
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: book.chapters.length,
        itemBuilder: (context, index) {
          if (index == currentPage) {
            return GestureDetector(
              onTap: () {
                pageController.jumpToPage(index);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            );
          }

          return GestureDetector(
            onTap: () {
              pageController.animateToPage(
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
                  color: context.lineColor,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
