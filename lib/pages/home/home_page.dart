import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holy_bible_digital/notifiers/bible_notifier.dart';
import '../../components/translate_button.dart';
import '/imports/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstTime = sharedPrefs.prefs.getBool('welcome') ?? true;
  String searchKey = '';
  bool showSearch = false;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      return Welcome(
        onPressed: () {
          setState(() {
            firstTime = false;
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
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
            icon: showSearch
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
              context.push('/settings');
            },
          ),
        ],
      ),
      body: ListOfBooks(searchKey: searchKey),
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

        if (bible.lang == 'en') {
          flag = Assets.flagUs;
        } else if (bible.lang == 'fr') {
          flag = Assets.flagFr;
        } else if (bible.lang == 'it') {
          flag = Assets.flagIt;
        } else if (bible.lang == 'es') {
          flag = Assets.flagEs;
        }

        return Wrap(
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            const Text(
              "Bíblia Sagrada",
              style: TextStyle(fontSize: 20),
            ),
            Image.asset(
              flag,
              width: 20,
              height: 20,
            )
          ],
        );
      },
    );
  }
}
