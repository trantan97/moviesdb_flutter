import 'package:moviesdb/src/blocs/base_bloc/base.dart';
import 'package:moviesdb/src/data/models/models.dart';

class LoadedHomeData extends BaseState {
  Category popular;
  Category nowPlaying;
  Category topRate;
  Category upComing;
  Category trending;
  List<Genre> genres;
  int trendingPosition = 0;

  LoadedHomeData({this.popular, this.nowPlaying, this.topRate, this.upComing, this.trending, this.genres});

  @override
  List<Object> get props => [popular, nowPlaying, topRate, upComing, trending, genres, trendingPosition];

  static LoadedHomeData copy(LoadedHomeData homeData) {
    return LoadedHomeData(
      popular: homeData.popular,
      trending: homeData.trending,
      genres: homeData.genres,
      upComing: homeData.upComing,
      topRate: homeData.topRate,
      nowPlaying: homeData.nowPlaying,
    );
  }
}
