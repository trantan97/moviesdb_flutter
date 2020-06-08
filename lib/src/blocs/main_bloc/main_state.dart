import 'package:moviesdb/src/blocs/base_bloc/base.dart';

class MainState extends BaseState {
  final int index;

  MainState(this.index);
  @override
  List<Object> get props => [index];
}
