import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  // Member variable for the factory
  static final DatabaseFactory factory = databaseFactoryFfiWeb;
  final Database db;

  static Future<DatabaseHelper> createInstance() async {
    Database database = await factory.openDatabase('my_database.db');
    return DatabaseHelper._(database);
  }

  // Private constructor
  DatabaseHelper._(this.db);

  void createUserTable() {
    db.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER
      );
    ''');
  }

  void insertUser(String name, int age) {
    db.execute('INSERT INTO users (name, age) VALUES (?, ?)', [name, age]);
  }

  Future<List<Map<String, Object?>>> getUsers() {
    return db.rawQuery('SELECT * FROM users');
  }
}

