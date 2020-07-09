import 'package:floor/floor.dart';
import 'package:moviesdb/src/data/models/models.dart';

@dao
abstract class MovieDao {
  @Query("SELECT * FROM $TABLE_FAVORITE")
  Future<List<Movie>> getMovies();

  @Query("SELECT * FROM $TABLE_FAVORITE WHERE id = :id")
  Future<Movie> findMovieById(int id);

  @delete
  Future<int> deleteMovie(Movie movie);

  @insert
  Future<int> addMovie(Movie movie);

  @Query("SELECT * FROM $TABLE_FAVORITE")
  Stream<List<Movie>> getMoviesAsStream();
}
