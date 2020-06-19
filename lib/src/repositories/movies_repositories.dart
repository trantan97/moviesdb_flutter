import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:moviesdb/src/constants.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/services/services.dart';
import 'package:moviesdb/src/utils/utils.dart';
import 'package:moviesdb/src/extension.dart';

class MoviesRepositories {
  Network _network = locator<Network>();

  Future<Movie> getDetailMovie(int movieId) async {
    final response = await _network.get(
      url: getMovieDetailUrl(movieId.toString()),
      params: {"append_to_response": "credits,videos,similar"},
    );
    if (response.isSuccess) {
      return Movie.formJson(response.data);
    }
    return null;
  }

  Future<MoviesByGenre> getMoviesByGenre(int genreId, {int page = 1}) async {
    final response = await _network.get(
      url: ApiConst.DISCOVER_MOVIE_URL,
      params: {"with_genres": genreId, "page": page},
      options: buildServiceCacheOptions()
    );
    if (response.isSuccess) {
      MoviesByGenre moviesByGenre = Movies.fromJson<MoviesByGenre>(MoviesByGenre(), response.data);
      moviesByGenre.idGenre = genreId;
      return moviesByGenre;
    }
    return null;
  }

  Future<List<Genre>> getGenres() async {
    final response = await _network.get(url: ApiConst.GENRE_URL);
    if (response.isSuccess) {
      List<Genre> genres = response.data["genres"].map((e) => Genre.fromJson(e)).toList()?.cast<Genre>() ?? [];
      return genres;
    }
    return [];
  }

  Future<Category> getMoviesByCategory(String type, {int page = 1}) async {
    Category category;
    final response = await _network.get(url: getCategoryUrl(type), params: {"page": page});
    if (response.isSuccess) {
      category = Category.fromJson(response.data);
      category.type = type;
    }
    return category;
  }

  Future<Category> getTrending() async {
    Category trending;
    final response = await _network.get(url: ApiConst.TRENDING_URL);
    if (response.isSuccess) {
      trending = Category.fromJson(response.data);
    }
    return trending;
  }
}
