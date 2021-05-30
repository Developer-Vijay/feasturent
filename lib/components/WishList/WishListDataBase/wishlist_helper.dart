import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class WishListDBhelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'wishListDat.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE wishListDat(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, isDineout INTEGER, isResturent INTEGER, average TEXT, imagepath TEXT, name TEXT, idDR INTEGER, rating TEXT, address TEXT, cusines TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await WishListDBhelper.database();
    db.insert(table, data);
  }

  static Future<List<Map<String, Object>>> getData(String table) async {
    final db = await WishListDBhelper.database();
    return db.query(table);
  }

  static Future querydata(id) async {
    final db = await WishListDBhelper.database();
    return db.rawQuery('SELECT * FROM wishListDat WHERE idDR=$id');
  }

  static Future<void> deleteData(String table, int id) async {
    final db = await WishListDBhelper.database();

    db.delete(table, where: 'idDR = ?', whereArgs: [id]);
  }
}
