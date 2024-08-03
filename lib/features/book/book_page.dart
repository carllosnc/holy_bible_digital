import 'package:flutter/material.dart';
import 'components/book_viewer.dart';

class BookPage extends StatelessWidget {
  final int book;
  final int chapter;

  const BookPage({
    super.key,
    required this.book,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    return BookViewer(
      book: book,
      chapter: chapter,
    );
  }
}
