import 'dart:async';

import 'package:floor/floor.dart';
import 'package:moviesdb/src/data/dao/movie_dao.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

const String DB_NAME = "movies_database.db";

@Database(version: 1, entities: [Movie])
abstract class DatabaseProvider extends FloorDatabase {
  static DatabaseProvider _database;

  static Future<DatabaseProvider> get databaseProvider async {
    if (_database == null) {
      _database = await $FloorDatabaseProvider.databaseBuilder(DB_NAME).build();
    }
    return _database;
  }

  MovieDao get movieDao;
}
