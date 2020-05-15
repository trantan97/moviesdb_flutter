import 'package:moviesdb/src/constants.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/data/models/movies.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/repositories/repositories.dart';
import 'package:moviesdb/src/services/services.dart';
import 'package:moviesdb/src/viewmodels/view_models.dart';
import 'package:moviesdb/src/extension.dart';

class GenreViewModel extends BaseModel {
  MoviesRepositories moviesRepositories = locator<MoviesRepositories>();
  final Genre genre;
  MoviesByGenre moviesByGenre;
  bool hasReachedMax = false;
  bool loadingMore = false;

  GenreViewModel({this.genre});

  getMoviesByGenre() async {
    setBusy(true);
    moviesByGenre = await moviesRepositories.getMoviesByGenre(genre.id);
    hasReachedMax = moviesByGenre.page == moviesByGenre.totalPages;
    setBusy(false);
  }

  loadMore() async {
    if (loadingMore) return;
    loadingMore = true;
    final loadMore = await moviesRepositories.getMoviesByGenre(
      genre.id,
      page: moviesByGenre.page + 1,
    );
    loadMore.movies = moviesByGenre.movies + loadMore.movies;
    moviesByGenre = loadMore;
    hasReachedMax = moviesByGenre.page == moviesByGenre.totalPages;
    notifyListeners();
    loadingMore = false;
  }
}
