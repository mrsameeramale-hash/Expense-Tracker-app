import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  static Database? _db;
  static Future<Database>get db async{
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }
  static Future<Database>initDB() async{
    final path = join (await getDatabasesPath(),'expense.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db,version) async{
        await db.execute('''
        CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        amount REAL,
        date TEXT
        )
        ''' );
      },

    );
  }
  static Future<int>insert(Map<String,dynamic>data) async{
    final dbClient = await db;
    return dbClient.insert('expenses',data);
  }
  static Future<List<Map<String,dynamic>>> getAll() async{
    final dbClient = await db;
    return dbClient.query('expenses',orderBy: 'date DESC');
  }
  static Future<int> delete(int id) async {
    final dbClient = await db;
    return dbClient.delete('expenses', where: 'id=?', whereArgs: [id]);
  }

  static Future<int> update(Map<String, dynamic> data) async {
    final dbClient = await db;
    return dbClient.update(
      'expenses',
      data,
      where: 'id=?',
      whereArgs: [data['id']],
    );
  }

}