import 'package:moviesdb/src/constants.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/extension.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/repositories/repositories.dart';
import 'package:moviesdb/src/services/services.dart';
import 'package:moviesdb/src/viewmodels/view_models.dart';

class HomeViewModel extends BaseModel {
  MoviesRepositories moviesRepositories = locator<MoviesRepositories>();
  Category popular;
  Category nowPlaying;
  Category topRate;
  Category upComing;
  Category trending;
  List<Genre> genres;
  int trendingPosition = 0;

  HomeViewModel() {}

  Future loadData() async {
    setBusy(true);
    List<Future> futures = [];
    futures.add(_loadPopular());
    futures.add(_loadNowPlaying());
    futures.add(_loadTopRate());
    futures.add(_loadUpComing());
    futures.add(_loadGenres());
    futures.add(_loadTrending());
    await Future.wait(futures);
    setBusy(false);
  }

  Future _loadPopular() async {
    popular = await moviesRepositories.getMoviesByCategory(CategoryType.POPULAR);
  }

  Future _loadNowPlaying() async {
    nowPlaying = await moviesRepositories.getMoviesByCategory(CategoryType.NOW_PLAYING);
  }

  Future _loadTopRate() async {
    topRate = await moviesRepositories.getMoviesByCategory(CategoryType.TOP_RATE);
  }

  Future _loadUpComing() async {
    upComing = await moviesRepositories.getMoviesByCategory(CategoryType.UP_COMING);
  }

  Future _loadGenres() async {
    genres = await moviesRepositories.getGenres();
  }

  Future _loadTrending() async {
    trending = await moviesRepositories.getTrending();
  }

  void changeTrendingPosition(int position) {
    trendingPosition = position;
    notifyListeners();
  }
}
