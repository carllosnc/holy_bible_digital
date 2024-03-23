import 'package:flutter/material.dart';
import '/imports/app.dart';

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

  showPinMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            "Marcação salva.",
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        duration: const Duration(seconds: 1),
      ),
    );
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

    showPinMessage(context);
    bookmarkNotifier.setPin(bookChapter);
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 18,
      backgroundColor: pinned //
          ? Theme.of(context).colorScheme.onSurface
          : Theme.of(context).colorScheme.background,
      child: IconButton(
        onPressed: () => pinAction(context),
        icon: Icon(
          size: 18,
          Icons.push_pin_outlined,
          color: pinned //
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
