import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/imports.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

var sqlCreateFolderTable = '''
  CREATE TABLE IF NOT EXISTS folder (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT
  );
''';

var sqlCreateVerseTable = '''
  CREATE TABLE IF NOT EXISTS verse (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    folderId INTEGER NOT NULL,
    FOREIGN KEY (folderId) REFERENCES folder(id)
  );
''';

class _BibleDatabase {
  late Future<Database> _database;

  final folderData = StreamController<List<Map<String, Object?>>>.broadcast();
  final verseData = StreamController<List<Map<String, Object?>>>.broadcast();

  init() async {
    _database = openDatabase(
      join(
        await getDatabasesPath(),
        'flutter.db',
      ),
      onCreate: (db, version) async {
        await db.execute(sqlCreateFolderTable);
        await db.execute(sqlCreateVerseTable);
      },
      version: 1,
    );
  }

  Future<void> addFolder(Folder folder, BuildContext context) async {
    await _database.then((db) async {
      await db.insert(
        'folder',
        folder.toJson(),
      );
    });

    if (context.mounted) {
      Navigator.of(context).pop();
    }

    getFolders();
  }

  Future<List<Folder>> getFolders() async {
    final db = await _database;

    final result = await db.query(
      'folder',
    );

    folderData.add(result);

    return result.map((e) => Folder.fromJson(e)).toList();
  }

  Future<Folder?> getFolderById(int id) async {
    final db = await _database;

    final result = await db.query(
      'folder',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return Folder.fromJson(result.first);
  }

  Future<void> removeFolder(int id, BuildContext context) async {
    await _database.then((db) async {
      await db.delete(
        'folder',
        where: 'id = ?',
        whereArgs: [id],
      );
    });

    getFolders();

    if (context.mounted) {
      context.go('$homePath/folders');
    }
  }

  Future<void> addVerse(Verse verse, BuildContext context) async {
    await _database.then((db) async {
      await db.insert(
        'verse',
        verse.toJson(),
      );
    });

    if (context.mounted) {
      showSnackBar(
        context: context,
        content: const Text('Verse added'),
      );

      Navigator.of(context).pop();
    }
  }

  Future<void> removeVerse(int id) async {
    await _database.then((db) async {
      await db.delete(
        'verse',
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  Future<List<Verse>> getVersesFromFolder(int id) async {
    final db = await _database;

    var result = await db.query(
      'verse',
      where: 'folderId = ?',
      whereArgs: [id],
    );

    return result.map((e) {
      return Verse.fromJson({
        ...e,
        'folderId': e['folderId'].toString(),
      });
    }).toList();
  }
}

final bibleDatabase = _BibleDatabase();
