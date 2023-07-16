import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '/domain/domain.dart';

class BibleRepository {
  Future<Bible> readBibleJson() async {
    final input = await rootBundle.loadString('./assets/data/acf.json');

    final bibleJson = json.decode(input);

    List<Book> bibleBooks = [];

    for (var book in bibleJson) {
      bibleBooks.add(Book.fromJson(book));
    }

    final bible = Bible(books: bibleBooks);

    return bible;
  }
}
