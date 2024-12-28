import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocationDBHelper {
  static final LocationDBHelper _instance = LocationDBHelper._internal();
  static Database? _database;

  factory LocationDBHelper() => _instance;

  LocationDBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'locations.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE locations(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            latitude TEXT,
            longitude TEXT,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  Future<bool> insertLocation(String latitude, String longitude) async {
    try {
      final db = await database;
      final id = await db.insert(
        'locations',
        {
          'latitude': latitude,
          'longitude': longitude,
          'timestamp': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return id > 0; // If an ID is returned, insertion was successful.
    } catch (e) {
      // Log the error if needed
      print("Error inserting location: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getAllLocations() async {
    final db = await database;
    return await db.query('locations');
  }
}
