import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localize/localize.dart';
import 'components/create_folder_button.dart';
import '/imports.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({super.key});

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> with LocalizeMixin, SharedState {
  @override
  void initState() {
    super.initState();

    bibleDatabase.getFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Folders'.localize,
          style: const TextStyle(fontSize: 18),
        ),
        actions: const [
          CreateFolderButton(),
        ],
      ),
      body: Builder(builder: (context) {
        if (bibleDatabase.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (bibleDatabase.folderData.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_outlined,
                  size: 100,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                ),
                Text(
                  'No folder created yet'.localize,
                  style: const TextStyle(fontSize: 18),
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
                context.push(
                  '$homePath/folder/${folder.id}',
                );
              },
              leading: const Icon(Icons.folder_outlined),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              title: Text(
                folder.name.capitalize(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
