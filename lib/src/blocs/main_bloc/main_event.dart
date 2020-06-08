import 'package:moviesdb/src/blocs/base_bloc/base.dart';

class ChangeIndexBottomNavigation extends BaseEvent{
  final int index;

  ChangeIndexBottomNavigation(this.index);
}