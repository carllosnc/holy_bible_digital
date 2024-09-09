import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localize/localize.dart';
import '/imports.dart';

saveVerseAction({
  required BuildContext context,
  required String title,
  required String content,
}) {
  bibleDatabase.getFolders();

  void saveVerse({
    required String folderId,
    required BuildContext context,
    required String folderName,
  }) async {
    Verse verse = Verse(
      title: title,
      content: content,
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
                    Text(
                      'No folder created yet'.localize,
                      style: TextStyle(
                        color: context.textColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FilledButton(
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(
                          context.buttonTextColor,
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          context.buttonColor,
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
}
