import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localize/localize.dart';
import '/imports.dart';

class SaveVerse extends StatefulWidget {
  final String title;
  final String content;

  const SaveVerse({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<SaveVerse> createState() => _SaveVerseState();
}

class _SaveVerseState extends State<SaveVerse> with LocalizeMixin, SharedState {
  @override
  void initState() {
    super.initState();

    bibleDatabase.getFolders();
  }

  void saveVerse({
    required String folderId,
    required BuildContext context,
    required String folderName,
  }) async {
    Verse verse = Verse(
      title: widget.title,
      content: widget.content,
      folderId: folderId,
    );

    await bibleDatabase.addVerse(
      verse: verse,
      folderName: folderName,
    );

    if (context.mounted) {
      showSnackBar(
        context: context,
        backgroundColor: Colors.green.shade800,
        content: Text(
          "${'Verse added to'.localize} ${folderName.capitalize()}",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.bookmark_add_outlined),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            if (bibleDatabase.isLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
                title: Text(
                  'Folders'.localize,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              body: Builder(
                builder: (context) {
                  if (bibleDatabase.folderData.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No folder created yet'.localize),
                          const SizedBox(
                            height: 10,
                          ),
                          FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            onPressed: () {
                              context.push("$homePath/folders");
                            },
                            child: Text("Create folder".localize),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: bibleDatabase.folderData.length,
                    itemBuilder: (context, index) {
                      Folder folder = bibleDatabase.folderData[index];

                      return ListTile(
                        onTap: () {
                          saveVerse(
                            folderName: folder.name,
                            folderId: folder.id.toString(),
                            context: context,
                          );
                        },
                        leading: const Icon(Icons.folder_outlined),
                        title: Text(
                          folder.name.capitalize(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
