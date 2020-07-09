import 'package:moviesdb/src/data/dao/movie_dao.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/services/database.dart';

class FavoriteRepository {
  MovieDao _movieDao;

  Future<MovieDao> get movieDao async {
    if (_movieDao == null) {
      _movieDao = (await DatabaseProvider.databaseProvider).movieDao;
    }
    return _movieDao;
  }

  Future<int> addFavorite(Movie movie) async{
    final dao = await movieDao;
    return dao.addMovie(movie);
  }

  Future<bool> isFavorite(Movie movie) async {
    final dao = await movieDao;
    final result = await dao.findMovieById(movie.id) != null;
    return result;
  }

  Future<List<Movie>> getFavorites() async{
    final dao = await movieDao;
    return dao.getMovies();
  }

  Future<bool> deleteFavorite(Movie movie) async {
    final dao = await movieDao;
    final result = await dao.deleteMovie(movie);
    return result > 0;
  }
}
