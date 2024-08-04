import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'components/home_title.dart';
import 'components/search_book.dart';
import 'components/translate_button.dart';
import 'components/book_list.dart';
import 'components/bookmark.dart';
import 'components/set_theme_button.dart';
import '/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SharedState {
  String searchKey = '';
  bool showSearch = false;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: showSearch
            ? SearchBook(
                searchController: _searchController,
                onSearch: (value) {
                  setState(() {
                    searchKey = value;
                  });
                },
              )
            : const HomeTitle(),
        actions: [
          IconButton(
            icon: showSearch //
                ? const Icon(Icons.close_outlined, color: Colors.red)
                : const Icon(Icons.search_outlined),
            onPressed: () {
              setState(() {
                showSearch = !showSearch;

                if (!showSearch) {
                  _searchController.clear();
                  searchKey = '';
                }
              });
            },
          ),
          const TranslateButton(),
          const SetThemeButton(),
        ],
      ),
      body: BookList(searchKey: searchKey),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        onPressed: () {
          context.push('$homePath/folders');
        },
        child: Icon(
          Icons.folder_outlined,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      bottomNavigationBar: Bookmark(bible: bibleState.currentBible),
    );
  }
}
