import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/extensions/string_extensions.dart';
import '/imports.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({super.key});

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  @override
  void initState() {
    super.initState();

    bibleDatabase.getFolders();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bibleNotifier.currentBible,
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              labels(value.lang)['folders'],
              style: const TextStyle(fontSize: 18),
            ),
            actions: const [
              CreateFolderButton(),
            ],
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
                        Icon(
                          Icons.folder_off_outlined,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                          size: 100,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          labels(value.lang)['noFolders'],
                          style: const TextStyle(fontSize: 18),
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
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
