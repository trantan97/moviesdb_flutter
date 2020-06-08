import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/blocs/home_bloc/home_event.dart';
import 'package:moviesdb/src/blocs/home_bloc/home_state.dart';
import 'package:moviesdb/src/constants.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/repositories/repositories.dart';

class HomeBloc extends Bloc<BaseEvent, BaseState> {
  MoviesRepositories moviesRepositories = locator<MoviesRepositories>();

  @override
  BaseState get initialState => InitState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetData) {
      yield LoadingState();
      final popular = await moviesRepositories.getMoviesByCategory(CategoryType.POPULAR);
      final nowPlaying = await moviesRepositories.getMoviesByCategory(CategoryType.NOW_PLAYING);
      final topRate = await moviesRepositories.getMoviesByCategory(CategoryType.TOP_RATE);
      final upComing = await moviesRepositories.getMoviesByCategory(CategoryType.UP_COMING);
      final genres = await moviesRepositories.getGenres();
      final trending = await moviesRepositories.getTrending();
      yield LoadedHomeData(
        popular: popular,
        nowPlaying: nowPlaying,
        topRate: topRate,
        upComing: upComing,
        genres: genres,
        trending: trending,
      );
    }
    if(event is ChangeTrendingPosition){
      if(state is LoadedHomeData){
        yield LoadedHomeData.copy(state)..trendingPosition = event.position;
      }
    }
  }
}
