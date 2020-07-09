import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:moviesdb/src/data/models/models.dart';

const String TABLE_FAVORITE = "table_favorite";

@Entity(tableName: TABLE_FAVORITE)
class Movie extends Equatable {
  @primaryKey
  int id;
  @ignore
  String backdropPath;
  @ignore
  List<Genre> genres;
  @ColumnInfo(name: "title", nullable: false)
  String title;
  @ColumnInfo(name: "overview", nullable: true)
  String overview;
  @ColumnInfo(name: "poster_path", nullable: true)
  String porterPath;
  @ignore
  List<Company> productionCompanies;
  @ColumnInfo(name: "release_date", nullable: true)
  String releaseDate;
  @ignore
  int runtime;
  @ignore
  int revenue;
  @ignore
  int budget;
  @ignore
  List<Video> videos;
  @ignore
  List<Actor> cast;
  @ColumnInfo(name: "vote_average", nullable: true)
  double voteAverage;
  @ignore
  int voteCount;

  @override
  List<Object> get props => [id, title];

  Movie(this.id, this.porterPath, this.title, this.overview, this.releaseDate, this.voteAverage);

  Movie.empty();

  static Movie formJson(Map<String, dynamic> json) {
    return Movie.empty()
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
