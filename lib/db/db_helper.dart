import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "task";

  static initDb() async {
    if (_db != null) {
      debugPrint("not null db");
      return;
    } else {
      try {
        String _path = "${await getDatabasesPath()}task.db";
        debugPrint("in database path");
        _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version) async {
            debugPrint("create a new one");
            await db.execute(
              "CREATE TABLE $_tableName("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "title STRING, note TEXT, date STRING,"
              "startTime STRING, endTime STRING,"
              "remind INTEGER, repeat STRING,"
              "color INTEGER,"
              "isCompleted INTEGER)",
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  static insert(Task? task) async {
    print("insert something");
    try {
      return await _db!.insert(
        _tableName,
        task!.toJson(),
      );
    } catch (e) {
      print("we are here");
      return 90000;
    }
  }

  static delete(Task task) async {
    print("delete something");
    return await _db!.delete(
      _tableName,
      where: "id=?",
      whereArgs: [task.id],
    );
  }

  static deleteAll() async {
    print("delete All something");
    return await _db!.delete(
      _tableName,
    );
  }

  static query() async {
    print("query something");
    return await _db!.query(
      _tableName,
    );
  }

  static update(int id) async {
    print("update something");
    return await _db!.rawUpdate("""
    UPDATE task
    SET isCompleted = ?
    WHERE id = ?
       """, [1, id]);
  }
}
