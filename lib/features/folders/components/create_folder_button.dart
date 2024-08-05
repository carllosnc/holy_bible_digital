import 'package:flutter/material.dart';
import 'package:localize/localize.dart';
import '/imports.dart';

class CreateFolderButton extends StatefulWidget {
  const CreateFolderButton({
    super.key,
  });

  @override
  State<CreateFolderButton> createState() => _CreateFolderButtonState();
}

class _CreateFolderButtonState extends State<CreateFolderButton> with LocalizeMixin, SharedState {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  createFolder(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var folder = Folder(
        name: nameController.text,
      );

      await bibleDatabase.createFolder(folder);

      if (context.mounted) {
        Navigator.of(context).pop();
      }
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
            return Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                title: Text(
                  'Create folder'.localize,
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
                              ? 'Name is required'.localize //
                              : null,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.folder_outlined),
                            labelText: 'Folder name'.localize,
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
                            'Create'.localize,
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
  }
}
