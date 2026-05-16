import 'package:flutter/material.dart';
import 'package:localize/localize.dart';

class SearchBook extends StatefulWidget {
  final Function onSearch;
  final TextEditingController searchController;

  const SearchBook({
    super.key,
    required this.onSearch,
    required this.searchController,
  });

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> with LocalizeMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        autofocus: true,
        controller: widget.searchController,
        onChanged: (value) {
          widget.onSearch(value);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          hintText: "Search book".localize,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
