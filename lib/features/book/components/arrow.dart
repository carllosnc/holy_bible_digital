import 'package:flutter/material.dart';

enum ArrowType { next, previous }

class Arrow extends StatefulWidget {
  final PageController pageController;
  final int currentPage;
  final ArrowType type;

  const Arrow({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.type,
  });

  @override
  State<Arrow> createState() => _ArrowState();
}

class _ArrowState extends State<Arrow> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.pageController.animateToPage(
          widget.type == ArrowType.next ? widget.currentPage + 1 : widget.currentPage - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
      icon: Icon(
        widget.type == ArrowType.next ? Icons.chevron_right : Icons.chevron_left,
      ),
    );
  }
}
