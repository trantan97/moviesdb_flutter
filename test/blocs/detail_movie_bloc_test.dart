import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/repositories/repositories.dart';

import 'home_bloc_test.dart';

main() {
  final movieId = 1;
  final Movie movie = Movie();
  group("GenreBloc", () {
    DetailMovieBloc bloc;
    MockMovieRepositories repository;
    setUp(() {
      final getIt = GetIt.instance;
      getIt.reset();
      getIt.registerLazySingleton<MoviesRepositories>(() => MockMovieRepositories());

      repository = getIt<MoviesRepositories>();
      bloc = DetailMovieBloc();
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
        when(repository.getDetailMovie(movieId)).thenAnswer((_) => Future.value(movie));
        return bloc;
      },
      act: (bloc) => bloc.add(GetDetailMovie(movieId)),
      expect: [
        LoadingState(),
        LoadedState(data: movie),
      ],
    );
  });
}
