import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:final_project/models/rule.dart';

class RuleDatabase {
  static final RuleDatabase instance = RuleDatabase._init();
  static Database? _database;

  RuleDatabase._init();

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

  Future<List<Rule>> readRule(String id) async {
    final db = await instance.database;

    List<Rule> empty = [const Rule(id: 'Null', article_id: 'Null', rule: 'Null')];

    List maps;
    try {
      maps = await db.query(
        tablePenalty,
        columns: RuleFields.values,
        where: '${RuleFields.article_id} = ?',
        whereArgs: [id],
      );
    } catch (exception) {
      maps = [];
    }

    if (maps.isNotEmpty) {
      List<Rule> result = [];
      for (int i = 0; i < maps.length; i++) {
        result.add(Rule.fromJson(maps[i]));
      }

      return result;
    } else {
      return empty;
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
