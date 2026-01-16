import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'task.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE task(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            deskripsi TEXT,
            status INTEGER
          )
        ''');
      },
    );
  }

  // CREATE
  Future<int> insertTask(Task task) async {
    final dbClient = await db;
    return await dbClient.insert('task', task.toMap());
  }

  // READ
  Future<List<Task>> getTasks() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> result =
        await dbClient.query('task');

    return result.map((e) => Task(
      id: e['id'],
      nama: e['nama'],
      deskripsi: e['deskripsi'],
      status: e['status'],
    )).toList();
  }

  // UPDATE
  Future<int> updateTask(Task task) async {
    final dbClient = await db;
    return await dbClient.update(
      'task',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // DELETE
  Future<int> deleteTask(int id) async {
    final dbClient = await db;
    return await dbClient.delete(
      'task',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
