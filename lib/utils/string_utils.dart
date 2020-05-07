import 'package:moviesdb/constants.dart';

getCategoryUrl(String categoryType) => "${ApiConst.CATEGORY}$categoryType";

getImageUrl(String imageUrl, {String imageSize = ImageSize.original}) =>
    "${ApiConst.BASE_IMAGE_URL}/$imageSize/$imageUrl";
