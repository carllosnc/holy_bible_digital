import 'package:flutter/material.dart';
import '/imports.dart';

class FolderPage extends StatefulWidget {
  final String folderId;

  const FolderPage({
    super.key,
    required this.folderId,
  });

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  Folder? folderDetails;
  List<Verse> verses = [];

  @override
  void initState() {
    super.initState();

    bibleDatabase.getFolderById(int.parse(widget.folderId)).then((folder) {
      setState(() {
        folderDetails = folder;
      });
    });

    bibleDatabase.getVersesFromFolder(int.parse(widget.folderId)).then((verses) {
      setState(() {
        this.verses = verses;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (folderDetails == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        title: Text(
          folderDetails!.name,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onPressed: () {
              deleteFolder(context);
            },
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (verses.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                size: 100,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              ),
              const Center(
                child: Text(
                  'Nenhum verso nesta pasta',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        }

        return ListView.separated(
          itemCount: verses.length,
          padding: const EdgeInsets.symmetric(vertical: 5),
          separatorBuilder: (context, index) => Divider(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            height: 10,
          ),
          addRepaintBoundaries: true,
          itemBuilder: (context, index) {
            Verse verse = verses[index];

            return Dismissible(
              key: Key(verse.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Theme.of(context).colorScheme.onSurface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              onDismissed: (direction) async {
                await bibleDatabase.removeVerse(verse.id!);
              },
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      verse.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      verse.content,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                onTap: () {},
              ),
            );
          },
        );
      }),
    );
  }

  Future<dynamic> deleteFolder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir pasta'),
          content: const Text('Tem certeza que deseja excluir esta pasta?'),
          actions: <Widget>[
            FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Não'),
            ),
            OutlinedButton(
              onPressed: () {
                bibleDatabase.removeFolder(
                  int.parse(widget.folderId),
                  context,
                );
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
