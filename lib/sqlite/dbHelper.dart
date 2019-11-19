import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:n_r_d/models/nailArt.dart';
 
class DBHelper {
  static final DBHelper _dbHelper = DBHelper._internal();

  static const String ID = 'id';
  static const String BRANDNAME = 'brand_name';
  static const String COLORNAME = 'color_name';
  static const String NAILTYPE = 'nail_type';
  static const String TABLE = 'nail_art';
  static const String DB_NAME = 'nail_art.db';
 
  DBHelper._internal();

  factory DBHelper(){
    return _dbHelper;
  }
  
 // Creating new db or using existing
  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }
 
 // Open the database
  Future<Database> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, DB_NAME);
    var db = await openDatabase(
      path, 
      version: 1, 
      onCreate: _createDb);
    return db;
  }
 
 // Creating new table
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $TABLE (
        $ID INTEGER PRIMARY KEY, 
        $BRANDNAME TEXT, 
        $COLORNAME TEXT,
        $NAILTYPE TEXT)
      ''');
  }
 
 Future<int> insert(NailArt nailArt) async {
    Database db = await this.db;
    var result = await db.insert(TABLE, nailArt.toMap());
    return result;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + nailArt.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }
 
  Future<List> getNailArts() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $TABLE ORDER BY $BRANDNAME");
    return result;
  }
 
  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
      await db.rawQuery("SELECT count (*) from $TABLE")
    );
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    return await db.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }
 
  Future<int> update(NailArt nailArt) async {
    Database db = await this.db;
    return await db.update(TABLE, nailArt.toMap(),
        where: '$ID = ?', whereArgs: [nailArt.id]);
  }
 
  Future close() async {
    Database db = await this.db;
    db.close();
  }
}