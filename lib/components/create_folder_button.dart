import 'package:flutter/material.dart';
import 'package:holy_bible_digital/imports.dart';

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
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Criar pasta',
                  style: TextStyle(fontSize: 20),
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
                          validator: (value) => value!.isEmpty ? 'Nome da pasta é obrigatório' : null,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.folder_outlined),
                            labelText: 'Nome da pasta',
                          ),
                        ),
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
                            createFolder(context);
                          },
                          child: Text(
                            "Criar",
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
