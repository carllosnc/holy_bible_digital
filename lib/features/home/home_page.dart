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
          IconButton(
            onPressed: () {
              context.push('$homePath/folders');
            },
            icon: const Icon(
              Icons.folder_outlined,
            ),
          ),
          const SetThemeButton(),
        ],
      ),
      body: BookList(searchKey: searchKey),
      bottomNavigationBar: Bookmark(bible: bibleState.currentBible),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton.outlined(
              onPressed: () {
                fontSizeState.increaseFontSize();
              },
              icon: const Icon(Icons.add),
            ),
            const SizedBox(height: 3),
            Text(
              fontSizeState.ratio.abs().toStringAsFixed(1),
            ),
            const SizedBox(height: 3),
            IconButton.outlined(
              onPressed: () {
                fontSizeState.decreaseFontSize();
              },
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
