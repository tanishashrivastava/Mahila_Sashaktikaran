import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:final_project/models/article.dart';

class ArticlesDatabase {
  static final ArticlesDatabase instance = ArticlesDatabase._init();
  static Database? _database;

  ArticlesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "article.db");
    bool dbExists = await io.File(path).exists();

    if (!dbExists) {
      ByteData data = await rootBundle.load(join("assets", "article.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await io.File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, version: 1);
  }

  Future<Articles> readNote(String id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablearticles,
      columns: ArticlesFields.values,
      where: '${ArticlesFields.article_id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Articles.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Articles>> readAllNotes() async {
    final db = await instance.database;

    final result = await db.query(tablearticles);

    return result.map((json) => Articles.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
