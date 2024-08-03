import 'package:flutter/material.dart';
import '/imports.dart';

class CreateFolderButton extends StatefulWidget {
  const CreateFolderButton({
    super.key,
  });

  @override
  State<CreateFolderButton> createState() => _CreateFolderButtonState();
}

class _CreateFolderButtonState extends State<CreateFolderButton> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  createFolder(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var folder = Folder(
        name: nameController.text,
      );

      await bibleDatabase.addFolder(folder, context);
    }

    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.create_new_folder_outlined),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return ValueListenableBuilder(
              valueListenable: bibleNotifier.currentBible,
              builder: (context, currentBible, child) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      labels(currentBible.lang)['createFolder'],
                      style: const TextStyle(fontSize: 20),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: nameController,
                              validator: (value) => value!.isEmpty //
                                  ? labels(currentBible.lang)['nameIsRequired']! //
                                  : null,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.folder_outlined),
                                labelText: labels(currentBible.lang)['folderName'],
                              ),
                            ),
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
                                createFolder(context);
                              },
                              child: Text(
                                labels(currentBible.lang)['create'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
