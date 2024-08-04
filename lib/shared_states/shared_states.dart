import 'package:flutter/material.dart';
import 'theme_state.dart';
import 'bookmark_state.dart';
import 'bible_state.dart';

mixin SharedState<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    themeState.addListener(action);
    bookmarkState.addListener(action);
    bibleState.addListener(action);
  }

  @override
  void dispose() {
    super.dispose();
    themeState.removeListener(action);
    bookmarkState.removeListener(action);
    bibleState.removeListener(action);
  }

  void action() {
    setState(() {});
  }
}
