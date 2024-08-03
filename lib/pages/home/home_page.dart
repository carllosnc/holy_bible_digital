import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            : const Hometitle(),
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
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.push('$homePath/settings');
            },
          ),
        ],
      ),
      body: ListOfBooks(searchKey: searchKey),
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
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: bibleNotifier.currentBible,
        builder: (context, value, child) {
          return Bookmark(bible: value);
        },
      ),
    );
  }
}

class Hometitle extends StatelessWidget {
  const Hometitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bibleNotifier.currentBible,
      builder: (context, Bible bible, child) {
        var flag = Assets.flagPtbr;

        if (bible.lang == Langs.english.abbr) {
          flag = Assets.flagUs;
        } else if (bible.lang == Langs.french.abbr) {
          flag = Assets.flagFr;
        } else if (bible.lang == Langs.italian.abbr) {
          flag = Assets.flagIt;
        } else if (bible.lang == Langs.spanish.abbr) {
          flag = Assets.flagEs;
        }

        return ValueListenableBuilder(
          valueListenable: bibleNotifier.currentBible,
          builder: (context, Bible bible, child) {
            return Wrap(
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Image.asset(
                  flag,
                  width: 20,
                  height: 20,
                ),
                Text(
                  labels(bible.lang)['title'],
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
