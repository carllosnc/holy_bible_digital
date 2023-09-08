import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstTime = SharedPrefs().prefs.getBool('welcome') ?? true;
  String searchKey = '';
  bool showSearch = false;

  final TextEditingController _searchController = TextEditingController();

  Wrap appTitle() {
    return const Wrap(
      spacing: 10,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        Text(
          "Bíblia Sagrada",
          style: TextStyle(fontSize: 18),
        ),
        AppVersion()
      ],
    );
  }

  Widget searchField() {
    return SizedBox(
      height: 40,
      child: TextField(
        autofocus: true,
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            searchKey = value.toLowerCase();
          });
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          hintText: 'Pesquisar livro',
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

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
        surfaceTintColor: Theme.of(context).colorScheme.background,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            height: 1,
          ),
        ),
        title: showSearch ? searchField() : appTitle(),
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
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
      ),
      body: ListOfBooks(searchKey: searchKey),
      bottomNavigationBar: const Bookmark(),
    );
  }
}
