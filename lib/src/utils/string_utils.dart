import 'package:intl/intl.dart';
import 'package:moviesdb/src/constants.dart';

getCategoryUrl(String categoryType) => "${ApiConst.MOVIE}$categoryType";

getImageUrl(String imageUrl, {String imageSize = ImageSize.original}) =>
    "${ApiConst.BASE_IMAGE_URL}/$imageSize/$imageUrl";

getMovieDetailUrl(String movieId) => "${ApiConst.MOVIE}$movieId";

getRunTime(int runtime) {
  int hour = runtime ~/ 60;
  int minute = runtime % 60;
  return "${hour}h ${minute}min";
}

getReleaseDate(String releaseDate) {
  DateTime date = DateFormat("yyyy-MM-dd", "en").parse(releaseDate);
  return DateFormat("dd MMMM yyyy").format(date);
}

getThumbnailPath(String key) => "https://img.youtube.com/vi/$key/hqdefault.jpg";
