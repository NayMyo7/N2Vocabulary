import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class N2VocabularyDatabase {
  static const _assetDbPath = 'assets/N2Vocabulary';
  static const _dbFileName = 'N2Vocabulary';

  Database? _db;
  Completer<Database>? _dbCompleter;

  Future<Database> get database async {
    if (_db != null) return _db!;

    if (_dbCompleter != null) {
      return _dbCompleter!.future;
    }

    _dbCompleter = Completer<Database>();
    try {
      final db = await _open();
      _db = db;
      _dbCompleter!.complete(db);
      return db;
    } catch (e) {
      _dbCompleter!.completeError(e);
      _dbCompleter = null;
      rethrow;
    }
  }

  Future<Database> _open() async {
    final dbFile = await _ensureDbFile();
    final db = await openDatabase(dbFile.path);
    return db;
  }

  Future<File> _ensureDbFile() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbDir = Directory(p.join(appDir.path, 'database'));
    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
    }

    final dbFile = File(p.join(dbDir.path, _dbFileName));
    if (await dbFile.exists()) {
      return dbFile;
    }

    final bytes = await rootBundle.load(_assetDbPath);
    final buffer = bytes.buffer;
    await dbFile.writeAsBytes(
      buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      flush: true,
    );

    return dbFile;
  }

  Future<List<Map<String, Object?>>> rawQuery(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db = await database;
    return db.rawQuery(sql, arguments);
  }

  Future<int> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await database;
    return db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<void> close() async {
    final db = _db;
    _db = null;
    _dbCompleter = null;
    await db?.close();
  }
}
