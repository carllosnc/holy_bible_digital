import 'package:flutter/material.dart';
import 'package:flutter_starter/data/data.dart';
import 'package:flutter_starter/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('Check bible books', () async {
    final BibleRepository bibleRepository = BibleRepository();

    Bible bible = await bibleRepository.readBibleJson();

    expect(bible.books.length, 66);
  });
}
