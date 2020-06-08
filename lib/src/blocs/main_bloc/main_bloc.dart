import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/base_bloc/base.dart';
import 'package:moviesdb/src/blocs/main_bloc/blocs.dart';

class MainBloc extends Bloc<BaseEvent, BaseState> {
  @override
  BaseState get initialState => MainState(0);

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ChangeIndexBottomNavigation) {
      yield MainState(event.index);
    }
  }
}
