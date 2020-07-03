import 'package:moviesdb/src/blocs/base_bloc/base.dart';
import 'package:moviesdb/src/data/models/models.dart';

class GetFavorites extends BaseEvent {}

class CheckFavorite extends BaseEvent {
  final Movie movie;

  CheckFavorite(this.movie);
}

class ClickedFavorite extends BaseEvent {
  final Movie movie;

  ClickedFavorite(this.movie);
}

class UnFavorite extends BaseEvent {
  final Movie movie;

  UnFavorite(this.movie);
}
