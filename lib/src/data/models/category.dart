import 'package:equatable/equatable.dart';
import 'package:moviesdb/src/data/models/models.dart';

class Category extends Equatable {
  String type;
  List<Movie> movies;
  int totalPages;
  int totalResults;
  int page;

  @override
  List<Object> get props => [type];

  static Category fromJson(Map<String, dynamic> json) {
    return Category()
      ..page = json["page"]
      ..totalPages = json["total_pages"]
      ..totalResults = json["total_results"]
      ..movies = json["results"]?.map((e) => Movie.formJson(e))?.toList()?.cast<Movie>();
  }
}
