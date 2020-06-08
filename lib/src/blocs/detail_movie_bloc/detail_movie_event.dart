import 'package:moviesdb/src/blocs/base_bloc/base.dart';

class GetDetailMovie extends BaseEvent {
  final int movieId;

  GetDetailMovie(this.movieId);
}
