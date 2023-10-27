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

  void pinAction(BuildContext context) async {
    setState(() {
      pinned = true;
    });

    bookmarkNotifier.setPin("${widget.book}-${widget.chapter}");

    //show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Center(
          child: Text(
            "Marcação salva.",
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: pinned
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.background,
      child: IconButton(
        onPressed: () => pinAction(context),
        icon: Icon(
          Icons.push_pin_outlined,
          color: pinned
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
