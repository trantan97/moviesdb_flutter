import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/repositories/repositories.dart';

import 'home_bloc_test.dart';

main() {
  final genre = Genre()..id = 1;
  final MoviesByGenre moviesByGenre = MoviesByGenre()
    ..movies = []
    ..page = 1
    ..totalPages = 2;
  MoviesByGenre loadMore = MoviesByGenre()
    ..movies = []
    ..page = 2
    ..totalPages = 2;
  group("GenreBloc", () {
    GenreBloc bloc;
    MockMovieRepositories repository;
    setUp(() {
      final getIt = GetIt.instance;
      getIt.reset();
      getIt.registerLazySingleton<MoviesRepositories>(() => MockMovieRepositories());

      repository = getIt<MoviesRepositories>();
      bloc = GenreBloc();
    });
    tearDown(() {
      bloc.close();
    });
    test("initial state", () {
      expect(bloc.state, InitState());
    });
    blocTest(
      "getMovieByGenre",
      build: () async {
        when(repository.getMoviesByGenre(genre.id)).thenAnswer((_) => Future.value(moviesByGenre));
        return bloc;
      },
      act: (bloc) => bloc.add(GetMoviesByGenre(genre)),
      expect: [
        LoadingState(),
        LoadedState(data: moviesByGenre),
      ],
      wait: Duration(milliseconds: 700),
    );
    blocTest(
      "LoadMoreMoviesByGenre",
      build: () async {
        when(repository.getMoviesByGenre(genre.id)).thenAnswer((_) => Future.value(moviesByGenre));
        when(repository.getMoviesByGenre(genre.id, page: moviesByGenre.page + 1))
            .thenAnswer((_) => Future.value(loadMore));
        bloc.add(GetMoviesByGenre(genre));
        await Future.delayed(Duration(milliseconds: 700));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMoreMoviesByGenre(genre)),
      expect: [
        LoadedState(data: loadMore),
      ],
      wait: Duration(milliseconds: 700),
    );
  });
}
