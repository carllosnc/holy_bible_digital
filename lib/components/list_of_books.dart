import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/data/data.dart';
import '/domain/domain.dart';

class ListOfBooks extends StatelessWidget {
  const ListOfBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final BibleRepository bibleRepository = BibleRepository();

    return FutureBuilder(
      future: bibleRepository.readBibleJson(),
      builder: (context, AsyncSnapshot<Bible> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        Bible bible = snapshot.data!;

        return ListView.builder(
          itemCount: bible.books.length,
          itemBuilder: (context, index) {
            Book book = bible.books[index];

            var extras = {
              'book': book,
              'page': 0,
            };

            return ListTile(
              onTap: () {
                context.push('/book', extra: extras);
              },
              title: Text(
                book.name,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              leading: Text(
                "${index + 1}",
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right_outlined),
              subtitle: Text('${book.chapters.length} capítulos'),
            );
          },
        );
      },
    );
  }
}
