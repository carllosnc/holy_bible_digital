import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/extensions/string_extensions.dart';
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

class _SaveVerseState extends State<SaveVerse> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            bibleDatabase.getFolders();

            return ValueListenableBuilder(
              valueListenable: bibleNotifier.currentBible,
              builder: (context, Bible bible, child) {
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    title: Text(
                      labels(bible.lang)['folders'],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  body: StreamBuilder<List<Map<String, Object?>>>(
                    stream: bibleDatabase.folderData.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(labels(bible.lang)['noFolders']),
                                const SizedBox(
                                  height: 10,
                                ),
                                FilledButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.push("$homePath/folders");
                                  },
                                  child: Text(labels(bible.lang)['createFolder']),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var folder = Folder.fromJson(snapshot.data![index]);

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
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                );
              },
            );
          },
        );
      },
      icon: const Icon(Icons.bookmark_add_outlined),
    );
  }

  void saveVerse({
    required String folderId,
    required BuildContext context,
    required String folderName,
  }) {
    Verse verse = Verse(
      title: widget.title,
      content: widget.content,
      folderId: folderId,
    );

    bibleDatabase.addVerse(
      verse: verse,
      folderName: folderName,
      context: context,
    );
  }
}
