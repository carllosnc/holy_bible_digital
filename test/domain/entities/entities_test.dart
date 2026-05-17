import 'package:flutter_test/flutter_test.dart';
import 'package:holy_bible_digital/domain/entities/bible/bible.dart';
import 'package:holy_bible_digital/domain/entities/book/book.dart';
import 'package:holy_bible_digital/domain/entities/folder/folder.dart';
import 'package:holy_bible_digital/domain/entities/verse/verse.dart';

void main() {
  group('Folder Tests', () {
    test('fromJson creates a valid Folder', () {
      final json = {'id': 1, 'name': 'Favorites'};
      final folder = Folder.fromJson(json);
      expect(folder.id, 1);
      expect(folder.name, 'Favorites');
    });

    test('toJson returns a valid Map', () {
      final folder = Folder(id: 1, name: 'Favorites');
      final json = folder.toJson();
      expect(json['id'], 1);
      expect(json['name'], 'Favorites');
    });
  });

  group('Verse Tests', () {
    test('fromJson creates a valid Verse', () {
      final json = {'id': 1, 'title': 'Genesis 1:1', 'content': 'In the beginning...', 'folderId': '1'};
      final verse = Verse.fromJson(json);
      expect(verse.id, 1);
      expect(verse.title, 'Genesis 1:1');
      expect(verse.content, 'In the beginning...');
      expect(verse.folderId, '1');
    });

    test('toJson returns a valid Map', () {
      final verse = Verse(id: 1, title: 'Genesis 1:1', content: 'In the beginning...', folderId: '1');
      final json = verse.toJson();
      expect(json['id'], 1);
      expect(json['title'], 'Genesis 1:1');
      expect(json['content'], 'In the beginning...');
      expect(json['folderId'], '1');
    });
  });

  group('Book Tests', () {
    test('fromJson creates a valid Book', () {
      final json = {
        'abbrev': 'gn',
        'chapters': [
          ['In the beginning...', 'And the earth...'],
        ],
        'name': 'Genesis',
      };
      final book = Book.fromJson(json);
      expect(book.abbrev, 'gn');
      expect(book.chapters.length, 1);
      expect(book.chapters[0][0], 'In the beginning...');
      expect(book.name, 'Genesis');
    });

    test('toJson returns a valid Map', () {
      final book = Book(
        abbrev: 'gn',
        chapters: [
          ['In the beginning...', 'And the earth...'],
        ],
        name: 'Genesis',
      );
      final json = book.toJson();
      expect(json['abbrev'], 'gn');
      expect(json['chapters'], [
        ['In the beginning...', 'And the earth...'],
      ]);
      expect(json['name'], 'Genesis');
    });
  });

  group('Bible Tests', () {
    test('fromJson creates a valid Bible', () {
      final json = {
        'books': [
          {
            'abbrev': 'gn',
            'chapters': [
              ['In the beginning...'],
            ],
            'name': 'Genesis',
          },
        ],
        'lang': 'en',
      };
      final bible = Bible.fromJson(json);
      expect(bible.lang, 'en');
      expect(bible.books.length, 1);
      expect(bible.books[0].name, 'Genesis');
    });

    test('toJson returns a valid Map', () {
      final bible = Bible(
        books: [
          Book(
            abbrev: 'gn',
            chapters: [
              ['In the beginning...'],
            ],
            name: 'Genesis',
          ),
        ],
        lang: 'en',
      );
      final json = bible.toJson();
      expect(json['lang'], 'en');
      expect(json['books'].length, 1);
      expect(json['books'][0]['name'], 'Genesis');
    });
  });
}
