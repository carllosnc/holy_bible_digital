import 'package:flutter/material.dart';
import 'package:holy_bible_digital/imports.dart';

class SearchBook extends StatelessWidget {
  final Function onSearch;
  final TextEditingController searchController;

  const SearchBook({
    super.key,
    required this.onSearch,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bibleNotifier.currentBible,
      builder: (context, Bible bible, child) {
        return SizedBox(
          height: 40,
          child: TextField(
            autofocus: true,
            controller: searchController,
            onChanged: (value) {
              onSearch(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              hintText: labels(bible.lang)['searchPlaceholder']!,
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        );
      },
    );
  }
}
