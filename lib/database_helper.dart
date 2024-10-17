import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'note.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async{
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    print("database path : ${path}");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,content TEXT)'''
    );
  }
  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<bool> checkExistingNote(String title) async{
    final db = await database;
    final result = await db.query('notes',where: 'title = ?',whereArgs: [title]);
    return result.isNotEmpty;
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

 Future<int> updateNote(Note note) async{
    final db = await database;
    return await db.update('notes',note.toMap(),where: 'id = ?',whereArgs: [note.id]);
 }

  Future<void> deleteDatabaseFile() async {

    String path = join(await getDatabasesPath(), 'notes.db');

    print("database path :$path");

    try {
      await deleteDatabase(path);
      print('Database deleted successfully.');
    } catch (e) {
      print('Error deleting database: $e');
    }
  }

}