import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/repositories/repositories.dart';
import 'package:moviesdb/src/viewmodels/view_models.dart';

class DetailMovieViewModel extends BaseModel {
  MoviesRepositories moviesRepositories = locator<MoviesRepositories>();
  Movie movie;

  getDetailMovie(int movieId) async {
    setBusy(true);
    movie =  await moviesRepositories.getDetailMovie(movieId);
    setBusy(false);
  }
}
