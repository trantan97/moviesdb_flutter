// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorDatabaseProvider {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseProviderBuilder databaseBuilder(String name) =>
      _$DatabaseProviderBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseProviderBuilder inMemoryDatabaseBuilder() =>
      _$DatabaseProviderBuilder(null);
}

class _$DatabaseProviderBuilder {
  _$DatabaseProviderBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$DatabaseProviderBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DatabaseProviderBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DatabaseProvider> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$DatabaseProvider();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DatabaseProvider extends DatabaseProvider {
  _$DatabaseProvider([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao _movieDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `table_favorite` (`id` INTEGER, `title` TEXT NOT NULL, `overview` TEXT, `poster_path` TEXT, `release_date` TEXT, `vote_average` REAL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'table_favorite',
            (Movie item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'poster_path': item.porterPath,
                  'release_date': item.releaseDate,
                  'vote_average': item.voteAverage
                },
            changeListener),
        _movieDeletionAdapter = DeletionAdapter(
            database,
            'table_favorite',
            ['id'],
            (Movie item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'poster_path': item.porterPath,
                  'release_date': item.releaseDate,
                  'vote_average': item.voteAverage
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _table_favoriteMapper = (Map<String, dynamic> row) => Movie(
      row['id'] as int,
      row['poster_path'] as String,
      row['title'] as String,
      row['overview'] as String,
      row['release_date'] as String,
      row['vote_average'] as double);

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  final DeletionAdapter<Movie> _movieDeletionAdapter;

  @override
  Future<List<Movie>> getMovies() async {
    return _queryAdapter.queryList('SELECT * FROM table_favorite',
        mapper: _table_favoriteMapper);
  }

  @override
  Future<Movie> findMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM table_favorite WHERE id = ?',
        arguments: <dynamic>[id], mapper: _table_favoriteMapper);
  }

  @override
  Stream<List<Movie>> getMoviesAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM table_favorite',
        queryableName: 'table_favorite',
        isView: false,
        mapper: _table_favoriteMapper);
  }

  @override
  Future<int> addMovie(Movie movie) {
    return _movieInsertionAdapter.insertAndReturnId(
        movie, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteMovie(Movie movie) {
    return _movieDeletionAdapter.deleteAndReturnChangedRows(movie);
  }
}
