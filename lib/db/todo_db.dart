import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo_model.dart';

class TodoDatabase {
  Database? _database;

  // Open connection to database
  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'todo.db';
    final path = join(dbpath, dbname);
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    return _database!;
  }

  // Create database table
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        startDate TEXT,
        endDate TEXT,
        creationDate TEXT,
        isChecked INTEGER
      )
    ''');
  }

  // Function to add data to database
  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return await db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Function to update specific data from database
  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    return await db
        .update('todo', todo.toMap(), where: 'id == ?', whereArgs: [todo.id]);
  }

  // Function to delete specific data from database
  Future<int> deleteTodo(Todo todo) async {
    final db = await database;

    return await db.delete('todo', where: 'id == ?', whereArgs: [todo.id]);
  }

  // Function to get lists of data from database
  Future<List<Todo>> getTodo() async {
    final db = await database;
    List<Map<String, dynamic>> items =
        await db.query('todo', orderBy: 'id DESC');

    return List.generate(
      items.length,
      (i) => Todo(
          id: items[i]['id'],
          title: items[i]['title'],
          startDate: DateTime.parse(items[i]['startDate']),
          endDate: DateTime.parse(items[i]['endDate']),
          creationDate: DateTime.parse(items[i]['creationDate']),
          isChecked: items[i]['isChecked'] == 1 ? true : false),
    );
  }
}
