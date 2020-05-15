import 'package:equatable/equatable.dart';
import 'package:moviesdb/src/data/models/models.dart';

abstract class Movies extends Equatable {
  List<Movie> movies;
  int totalPages;
  int totalResults;
  int page;

  @override
  List<Object> get props => [page, totalPages];

  static fromJson<T extends Movies>(T movies, Map<String, dynamic> json) {
    return movies
      ..page = json["page"]
      ..totalPages = json["total_pages"]
      ..totalResults = json["total_results"]
      ..movies = json["results"]?.map((e) => Movie.formJson(e))?.toList()?.cast<Movie>();
  }
}

class MoviesByGenre extends Movies {
  int idGenre;

  @override
  List<Object> get props => [idGenre, page, totalPages];
}
