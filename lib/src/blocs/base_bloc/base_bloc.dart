import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/base_bloc/base.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  @override
  BaseState get initialState => InitState();
}
