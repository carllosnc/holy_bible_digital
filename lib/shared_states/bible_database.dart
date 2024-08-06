import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '/imports.dart';

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

class _BibleDatabase extends ChangeNotifier {
  late Future<Database> _database;

  var folderData = [];
  var verseData = [];
  Folder? currentFolder;

  bool isLoading = false;

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

  Future<void> createFolder(Folder folder) async {
    var db = await _database;

    await db.insert(
      'folder',
      folder.toJson(),
    );

    await getFolders();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getFolders() async {
    isLoading = true;

    final db = await _database;
    final result = await db.query(
      'folder',
    );

    folderData = result.map((e) => Folder.fromJson(e)).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<Folder?> getFolderById(int id) async {
    isLoading = true;

    final db = await _database;

    final result = await db.query(
      'folder',
      where: 'id = ?',
      whereArgs: [id],
    );

    currentFolder = Folder.fromJson(result.first);

    if (result.isEmpty) {
      return null;
    }

    isLoading = false;
    notifyListeners();

    return Folder.fromJson(result.first);
  }

  Future<void> removeFolder(int id, BuildContext context) async {
    isLoading = true;

    var db = await _database;
    await db.delete('folder', where: 'id = ?', whereArgs: [id]);

    getFolders();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addVerse({
    required Verse verse,
    required String folderName,
  }) async {
    isLoading = true;

    var db = await _database;
    await db.insert('verse', verse.toJson());

    isLoading = false;
    notifyListeners();
  }

  Future<void> removeVerse({
    required int id,
    required BuildContext context,
    required int folderId,
  }) async {
    isLoading = true;

    final db = await _database;

    await db.delete(
      'verse',
      where: 'id = ?',
      whereArgs: [id],
    );

    await getVersesFromFolder(folderId);

    isLoading = false;
    notifyListeners();
  }

  Future<void> getVersesFromFolder(int id) async {
    isLoading = true;

    final db = await _database;

    var result = await db.query(
      'verse',
      where: 'folderId = ?',
      whereArgs: [id],
    );

    verseData = result.map((e) {
      return Verse.fromJson({
        ...e,
        'folderId': e['folderId'].toString(),
      });
    }).toList();

    isLoading = false;
    notifyListeners();
  }
}

final bibleDatabase = _BibleDatabase();
