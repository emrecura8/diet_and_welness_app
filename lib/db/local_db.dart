import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:the_diet_and_welness_app/models/exercise_model.dart';

class LocalDB {
  static final LocalDB _instance = LocalDB._internal();
  factory LocalDB() => _instance;
  LocalDB._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'wellness_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE exercises (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            category TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE favorites (
            id TEXT PRIMARY KEY
          )
        ''');
        await db.execute('''
          CREATE TABLE user_profiles (
            id TEXT PRIMARY KEY,
            name TEXT,
            age INTEGER,
            weight REAL,
            height REAL,
            bmi REAL,
            goal TEXT
          )
        ''');
      },
    );
  }

  // --- Exercise CRUD ---
  Future<void> insertExercises(List<Exercise> exercises) async {
    final db = await database;
    final batch = db.batch();
    for (final ex in exercises) {
      batch.insert(
        'exercises',
        ex.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Exercise>> getExercises() async {
    final db = await database;
    final maps = await db.query('exercises');
    return maps.map((map) => Exercise.fromMap(map)).toList();
  }

  Future<void> clearExercises() async {
    final db = await database;
    await db.delete('exercises');
  }

  // --- Favorites ---
  Future<void> setFavorite(String exerciseId, bool isFavorite) async {
    final db = await database;
    if (isFavorite) {
      await db.insert('favorites', {
        'id': exerciseId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      await db.delete('favorites', where: 'id = ?', whereArgs: [exerciseId]);
    }
  }

  Future<List<String>> getFavoriteIds() async {
    final db = await database;
    final maps = await db.query('favorites');
    return maps.map((row) => row['id'] as String).toList();
  }

  Future<bool> isFavorite(String exerciseId) async {
    final db = await database;
    final maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [exerciseId],
    );
    return maps.isNotEmpty;
  }

  // --- User Profile ---
  Future<void> saveUserProfile(
    String userId,
    Map<String, dynamic> profile,
  ) async {
    final db = await database;
    await db.insert('user_profiles', {
      'id': userId,
      'name': profile['name'],
      'age': profile['age'],
      'weight': profile['weight'],
      'height': profile['height'],
      'bmi': profile['bmi'],
      'goal': profile['goal'],
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final db = await database;
    final maps = await db.query(
      'user_profiles',
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}
