import 'package:flutter/material.dart';
import '/imports.dart';

class Pin extends StatefulWidget {
  final int book;
  final int chapter;

  const Pin({
    super.key,
    required this.book,
    required this.chapter,
  });

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  bool pinned = false;

  @override
  void initState() {
    super.initState();

    if (bookmarkNotifier.pin.value == "${widget.book}-${widget.chapter}") {
      pinned = true;
    }
  }

  void pinAction(BuildContext context) async {
    var bookChapter = "${widget.book}-${widget.chapter}";
    var currentPin = bookmarkNotifier.pin.value;

    if (currentPin == bookChapter) {
      setState(() {
        pinned = false;
      });

      bookmarkNotifier.setPin(null);
      return;
    }

    setState(() {
      pinned = true;
    });

    showSnackBar(
      context: context,
      content: const Text('Capítulo fixado!'),
    );

    bookmarkNotifier.setPin(bookChapter);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => pinAction(context),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          pinned //
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.surface,
        ),
      ),
      icon: Icon(
        Icons.push_pin_outlined,
        size: 22,
        color: pinned //
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
