import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
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

class _FolderPageState extends State<FolderPage> with LocalizeMixin, SharedState {
  @override
  void initState() {
    super.initState();

    bibleDatabase.getFolderById(
      int.parse(widget.folderId),
    );

    bibleDatabase.getVersesFromFolder(
      int.parse(widget.folderId),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (bibleDatabase.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: Text(
          bibleDatabase.currentFolder!.name.capitalize(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onPressed: () async {
              await deleteFolder(context);
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (bibleDatabase.verseData.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_outlined,
                  size: 100,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                ),
                Center(
                  child: Text(
                    'No one verse in this folder'.localize,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            );
          }

          return ListView.separated(
            itemCount: bibleDatabase.verseData.length,
            padding: const EdgeInsets.symmetric(vertical: 5),
            separatorBuilder: (context, index) => Divider(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              height: 10,
            ),
            addRepaintBoundaries: true,
            itemBuilder: (context, index) {
              Verse verse = bibleDatabase.verseData[index];

              return Dismissible(
                key: UniqueKey(),
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
                  if (context.mounted) {
                    showSnackBar(
                      context: context,
                      backgroundColor: Colors.red.shade800,
                      content: const Text(
                        "Verse removed",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  await bibleDatabase.removeVerse(
                    id: verse.id!,
                    context: context,
                    folderId: int.parse(widget.folderId),
                  );
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
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<dynamic> deleteFolder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete folder'.localize),
          content: Text('Are you sure you want to delete this folder?'.localize),
          actions: [
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'.localize),
            ),
            OutlinedButton(
              onPressed: () async {
                await bibleDatabase.removeFolder(
                  int.parse(widget.folderId),
                  context,
                );

                if (context.mounted) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Yes'.localize),
            ),
          ],
        );
      },
    );
  }
}
