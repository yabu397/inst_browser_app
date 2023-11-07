import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BookmarkLocalDBService {
  BookmarkLocalDBService._privateConstructor();
  static final BookmarkLocalDBService instance =
      BookmarkLocalDBService._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  final String _dbName = 'local_storage.db';
  final int _databaseVersion = 1;
  static const table = 'bookmarks';
  _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, _dbName);
    // データベース接続
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future deleteLocalDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, _dbName);
    deleteDatabase(dbPath);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            url TEXT NOT NULL
          )
          ''');
  }
}
