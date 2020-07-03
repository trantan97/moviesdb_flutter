import 'package:moviesdb/src/data/models/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

const String DB_NAME = "movies_database.db";
const String TABLE_FAVORITE = "favorite";

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider._();
  Database _database;

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: (db, version) {
        return db.execute("""CREATE TABLE $TABLE_FAVORITE (
            id INTEGER PRIMARY KEY,
            poster_path TEXT,
            title TEXT,
            overview TEXT,
            release_date TEXT,
            vote_average REAL
        )""");
      },
    );
  }

  Future close() {
    return _database?.close();
  }

  //delete the database
  Future deleteDB() async {
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }

  Future<int> addMovie(Movie movie) async {
    final db = await database;
    return await db.insert(TABLE_FAVORITE, movie.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<bool> checkExist(Movie movie) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_FAVORITE, where: "id = ?", whereArgs: [movie.id]);
    return maps.isNotEmpty;
  }

  Future<List<Movie>> getMovies() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_FAVORITE);
    return maps.map((e) => Movie.formJson(e)).toList();
  }

  Future<bool> deleteMovie(Movie movie) async {
    final db = await database;
    final result = await db.delete(TABLE_FAVORITE, where: "id = ?", whereArgs: [movie.id]);
    return result >= 0;
  }
}
