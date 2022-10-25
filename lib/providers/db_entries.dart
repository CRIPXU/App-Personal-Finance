

import 'package:exp_app/models/entries_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBEntries {
  static Database? _database;
  static final DBEntries db = DBEntries._();
  DBEntries._();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'ExpensesDB.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              '''CREATE TABLE Entries(
            id INTEGER PRIMARY KEY, 
            link INTEGER, 
            year INTEGER, 
            month INTEGER,
            day INTEGER,
            comment TEXT,
            expense DOUBLE
          )'''
          );
          await db.execute(
              '''CREATE TABLE Entries (
            id INTEGER PRIMARY KEY,
            year INTEGER, 
            month INTEGER,
            day INTEGER,
            comment TEXT,
            entries DOUBLE
          )'''
          );
        }
    );
  }

  addEntries(EntriesModel exp) async {
    final db = await database;
    final response = await db.insert('Entries', exp.toJson());
    return response;
  }

  Future<List<EntriesModel>> getEntriesByDate(int month, int year) async {
    final db = await database;
    final response = await db.query('Entries', where: 'month = ? and year = ?',
        whereArgs: [month, year] );
    List<EntriesModel> etList = response.isNotEmpty
        ? response.map((e) => EntriesModel.fromJson(e)).toList()
        : [];
    return etList;
  }

  Future<int> updateEntries(EntriesModel exp) async {
    final db = await database;
    final response = db.update('Entries', exp.toJson(),
        where: 'id = ?', whereArgs: [exp.id] );
    return response;
  }
  Future<int> deleteEntries(int id) async {
    final db = await database;
    final response = db.delete('Entries', where: 'id = ?', whereArgs: [id]);
    return response;
  }
}
  /*
  -----Entrie------
   */


