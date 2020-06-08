import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/constants.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/repositories/repositories.dart';

class MockMovieRepositories extends Mock implements MoviesRepositories {}

main() {
  final Category popular = Category();
  final Category nowPlaying = Category();
  final Category topRate = Category();
  final Category upComing = Category();
  final Category trending = Category();
  final List<Genre> genres = [];
  group("SettingBloc", () {
    HomeBloc bloc;
    MockMovieRepositories repository;
    setUp(() {
      final getIt = GetIt.instance;
      getIt.reset();
      getIt.registerLazySingleton<MoviesRepositories>(() => MockMovieRepositories());

      repository = getIt<MoviesRepositories>();
      bloc = HomeBloc();
    });
    tearDown(() {
      bloc.close();
    });
    test("initial state", () {
      expect(bloc.state, InitState());
    });
    blocTest(
      "getAppVersion: [LoadingState, LoadedState]",
      build: () async {
        when(repository.getMoviesByCategory(CategoryType.POPULAR)).thenAnswer((_) => Future.value(popular));
        when(repository.getMoviesByCategory(CategoryType.NOW_PLAYING)).thenAnswer((_) => Future.value(nowPlaying));
        when(repository.getMoviesByCategory(CategoryType.TOP_RATE)).thenAnswer((_) => Future.value(topRate));
        when(repository.getMoviesByCategory(CategoryType.UP_COMING)).thenAnswer((_) => Future.value(upComing));
        when(repository.getGenres()).thenAnswer((_) => Future.value(genres));
        when(repository.getTrending()).thenAnswer((_) => Future.value(trending));
        return bloc;
      },
      act: (bloc) => bloc.add(GetData()),
      expect: [
        LoadingState(),
        LoadedHomeData(
          popular: popular,
          nowPlaying: nowPlaying,
          topRate: topRate,
          upComing: upComing,
          genres: genres,
          trending: trending,
        )
      ],
    );
  });
}
