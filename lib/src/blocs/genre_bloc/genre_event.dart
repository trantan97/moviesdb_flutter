import 'package:moviesdb/src/blocs/base_bloc/base.dart';
import 'package:moviesdb/src/data/models/genre.dart';

class GetMoviesByGenre extends BaseEvent {
  final Genre genre;

  GetMoviesByGenre(this.genre);
}
class LoadMoreMoviesByGenre extends BaseEvent {
  final Genre genre;

  LoadMoreMoviesByGenre(this.genre);
}
