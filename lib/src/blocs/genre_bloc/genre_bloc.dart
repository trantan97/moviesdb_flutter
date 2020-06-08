import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/base_bloc/base.dart';
import 'package:moviesdb/src/blocs/genre_bloc/genre_event.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class GenreBloc extends Bloc<BaseEvent, BaseState> {
  MoviesRepositories moviesRepositories = locator<MoviesRepositories>();
  bool loadingMore = false;

  @override
  BaseState get initialState => InitState();

  @override
  Stream<Transition<BaseEvent, BaseState>> transformEvents(Stream<BaseEvent> events, transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetMoviesByGenre) {
      yield LoadingState();
      final moviesByGenre = await moviesRepositories.getMoviesByGenre(event.genre.id);
      yield LoadedState<MoviesByGenre>(data: moviesByGenre);
    }
    if (event is LoadMoreMoviesByGenre && canLoadMore) {
      final moviesByGenre = (state as LoadedState<MoviesByGenre>).data;
      final loadMore = await moviesRepositories.getMoviesByGenre(
        event.genre.id,
        page: moviesByGenre.page + 1,
      );

      loadMore.movies = moviesByGenre.movies + loadMore.movies;
      yield LoadedState<MoviesByGenre>(data: loadMore);
    }
  }

  bool get canLoadMore {
    if (state is LoadedState<MoviesByGenre>) {
      final moviesByGenre = (state as LoadedState<MoviesByGenre>).data;
      return moviesByGenre.page < moviesByGenre.totalPages;
    }
    return false;
  }
}
