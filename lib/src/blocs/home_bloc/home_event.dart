import 'package:moviesdb/src/blocs/base_bloc/base.dart';

class GetData extends BaseEvent {}

class ChangeTrendingPosition extends BaseEvent {
  final position;

  ChangeTrendingPosition(this.position);
}
