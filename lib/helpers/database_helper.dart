import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return database;
  }

  Future<void> saveToDatabase(
      String email, String password, String firstName, String lastName) async {
    final db = await database;

    await db.insert(
      'users',
      {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
