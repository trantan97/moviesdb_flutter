import 'package:equatable/equatable.dart';
import 'package:moviesdb/src/data/models/models.dart';

class Movie extends Equatable {
  int id;
  String backdropPath;
  List<Genre> genres;
  String title;
  String overview;
  String porterPath;
  List<Company> productionCompanies;
  String releaseDate;
  int runtime;
  int revenue;
  int budget;
  List<Video> videos;
  List<Actor> cast;
  double voteAverage;
  int voteCount;

  @override
  List<Object> get props => [id, title];

  static Movie formJson(Map<String, dynamic> json) {
    return Movie()
      ..id = json["id"]
      ..backdropPath = json["backdrop_path"]
      ..title = json["title"]
      ..overview = json["overview"]
      ..porterPath = json["poster_path"]
      ..releaseDate = json["release_date"]
      ..runtime = json["runtime"]
      ..revenue = json["revenue"]
      ..budget = json["budget"]
      ..voteAverage = json["vote_average"] * 1.0
      ..voteCount = json["vote_count"]
      ..genres = json["genres"]?.map((e) => Genre.fromJson(e))?.toList()?.cast<Genre>()
      ..productionCompanies =
          json["production_companies"]?.map((e) => Company.fromJson(e))?.toList()?.cast<Company>() ?? []
      ..videos = json["videos"] != null
          ? json["videos"]["results"]?.map((e) => Video.fromJson(e))?.toList()?.cast<Video>()
          : []
      ..cast = json["credits"] != null
          ? json["credits"]["cast"]?.map((e) => Actor.fromJson(e))?.toList()?.cast<Actor>()
          : [];
  }

  Map<String, dynamic> toMap() {
    return Map<String, dynamic>()
      ..["id"] = id
      ..["poster_path"] = porterPath
      ..["title"] = title
      ..["overview"] = overview
      ..["release_date"] = releaseDate
      ..["vote_average"] = voteAverage;
  }
}
