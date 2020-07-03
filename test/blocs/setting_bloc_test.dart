import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/repositories/repositories.dart';
import 'package:package_info/package_info.dart';

class MockSettingRepository extends Mock implements SettingRepository {}

main() {
  final PackageInfo packageInfo = PackageInfo(version: "0");
  group("SettingBloc", () {
    SettingBloc bloc;
    MockSettingRepository repository;
    setUp(() {
      final getIt = GetIt.instance;
      getIt.reset();
      getIt.registerLazySingleton<SettingRepository>(() => MockSettingRepository());
      
      repository = getIt<SettingRepository>();
      bloc = SettingBloc();
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
        when(repository.getAppInfo()).thenAnswer((_) => Future.value(packageInfo));
        return bloc;
      },
      act: (bloc) => bloc.add(GetAppVersion()),
      expect: [LoadingState(), LoadedState(data: packageInfo.version)],
    );
  });
}
