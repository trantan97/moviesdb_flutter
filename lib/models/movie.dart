import 'package:moviesdb/models/models.dart';

class Movie {
  int id;
  String backdropPath;
  List<Genre> genres;
  String title;
  String overview;
  String porterPath;
  List<Company> productionCompanies;
  String releaseDate;
  int runtime;
  List<Video> videos;
  List<Actor> cast;
}