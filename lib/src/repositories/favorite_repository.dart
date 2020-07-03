import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/services/database.dart';

class FavoriteRepository {
  DatabaseProvider databaseProvider = locator<DatabaseProvider>();

  Future<int> addFavorite(Movie movie) {
    return databaseProvider.addMovie(movie);
  }

  Future<bool> isFavorite(Movie movie) {
    return databaseProvider.checkExist(movie);
  }

  Future<List<Movie>> getFavorites() {
    return databaseProvider.getMovies();
  }

  Future<bool> deleteFavorite(Movie movie) {
    return databaseProvider.deleteMovie(movie);
  }
}
