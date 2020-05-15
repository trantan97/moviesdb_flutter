import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesdb/src/constants.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/resources/images.dart';
import 'package:moviesdb/src/ui/screens/screens.dart';
import 'package:moviesdb/src/ui/widgets/widgets.dart';
import 'package:moviesdb/src/utils/utils.dart';

class HomeListMovies extends StatelessWidget {
  final Category category;

  const HomeListMovies({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: <Widget>[
                Text(
                  _getNameCategory(context, category),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.chevron_right)
              ],
            ),
          ),
        ),
        Container(
          height: 190,
          width: widthScreen,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _item(context, index),
            itemCount: this.category?.movies?.length ?? 0,
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, int index) {
    Movie movie = category.movies[index];
    return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(DetailMovieScreen.routeName, arguments: movie),
        child: Stack(
          children: <Widget>[
            Container(
              width: 120,
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: getImageUrl(movie.porterPath, imageSize: ImageSize.w300),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: 100,
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(2, 8),
                              )
                            ]),
                      );
                    },
                    placeholder: (context, url) => Container(
                      width: 100,
                      height: 140,
                      alignment: Alignment.center,
                      child: ProgressLoading(
                        size: 20,
                        strokeWidth: 1,
                        valueColor: Colors.black,
                      ),
                    ),
                    errorWidget: (context, url, error) => _errorImage,
                  ),
                  Container(
                    width: 100,
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      movie.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 16,
              child: MovieVoteAverage(
                size: 20,
                voteAverage: movie.voteAverage,
              ),
            )
          ],
        ));
  }

  Widget get _errorImage {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: AssetImage(Images.no_image),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(2, 8),
          )
        ],
      ),
    );
  }

  String _getNameCategory(BuildContext context, Category category) {
    String name;
    switch (category.type) {
      case CategoryType.POPULAR:
        name = Language.of(context).getText("category_popular");
        break;
      case CategoryType.UP_COMING:
        name = Language.of(context).getText("category_up_coming");
        break;
      case CategoryType.TOP_RATE:
        name = Language.of(context).getText("category_top_rated");
        break;
      default:
        name = Language.of(context).getText("category_now_playing");
    }
    return name;
  }
}
