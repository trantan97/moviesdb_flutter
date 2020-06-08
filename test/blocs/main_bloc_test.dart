import 'package:bloc_test/bloc_test.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:test/test.dart';

main() {
  final index = 1;
  group("MainBloc", () {
    MainBloc bloc;

    setUp(() {
      bloc = MainBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test("initial state", () {
      expect(bloc.state, MainState(0));
    });
    blocTest(
      "ChangeIndexBottomNavigation: emits [MainState]",
      build: () async {
        return bloc;
      },
      act: (bloc) => bloc.add(ChangeIndexBottomNavigation(index)),
      expect: [MainState(index)],
    );
  });
}
