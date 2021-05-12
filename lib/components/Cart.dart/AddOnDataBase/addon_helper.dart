import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'addOnData.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE addOnData(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, addonPrice INTEGER, addonCount INTEGER, vendorId INTEGER, addonId INTEGER, addonName TEXT, addonvendorName TEXT, addongst INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data);
  }

  static Future<List<Map<String, Object>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future querydata(id) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT * FROM addOnData WHERE addonId=$id');
  }

  static Future sqlIDquerydata(id) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT * FROM addOnData WHERE id=$id');
  }

  static Future incrementCounter(id, count) async {
    final db = await DBHelper.database();

    return db
        .rawUpdate('UPDATE addOnData SET addonCount = $count WHERE id = $id');
  }

  static Future decrementCounter(id, count) async {
    final db = await DBHelper.database();

    return db
        .rawUpdate('UPDATE addOnData SET addonCount = $count WHERE id = $id');
  }

  static Future<void> deleteData(String table, int id) async {
    final db = await DBHelper.database();

    db.delete(table, where: 'addonId = ?', whereArgs: [id]);
  }

  static Future<void> updateData(
      String table, int id, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }
}
