import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/base_bloc/base.dart';
import 'package:moviesdb/src/blocs/detail_movie_bloc/blocs.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/repositories/repositories.dart';

class DetailMovieBloc extends Bloc<BaseEvent, BaseState> {
  MoviesRepositories moviesRepositories = locator<MoviesRepositories>();

  @override
  BaseState get initialState => InitState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetDetailMovie) {
      yield LoadingState();
      final movie = await moviesRepositories.getDetailMovie(event.movieId);
      yield LoadedState<Movie>(data: movie);
    }
  }
}
