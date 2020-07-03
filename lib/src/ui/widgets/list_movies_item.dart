import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moviesdb/src/constants.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/resources/resources.dart';
import 'package:moviesdb/src/ui/screens/screens.dart';
import 'package:moviesdb/src/ui/widgets/widgets.dart';
import 'package:moviesdb/src/utils/utils.dart';

class ItemListMovie extends StatelessWidget {
  final Movie movie;
  final Function(Movie movie) onDismissed;

  const ItemListMovie({Key key, this.movie, this.onDismissed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onDismissed == null) return _item(context);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _item(context),
      secondaryActions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 4),
          child: IconSlideAction(
            onTap: () => onDismissed(movie),
            color: Colors.redAccent,
            icon: Icons.delete_forever,
            caption: Language.of(context).getText("delete"),
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailMovieScreen.routeName, arguments: movie);
      },
      child: Container(
        height: 160,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.only(left: 56, top: 16),
                padding: EdgeInsets.only(left: 60),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(2, 8),
                    )
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 40, top: 8),
                          child: Text(
                            movie.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          movie.releaseDate,
                          style: TextStyle(
                            color: Colors.grey,
                            height: 1.5,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(bottom: 20, right: 8),
                            child: Text(
                              movie.overview,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: MovieVoteAverage(
                        voteAverage: movie.voteAverage,
                        size: 24,
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                    ],
                  ),
                );
              },
              placeholder: (context, url) => Container(
                width: 100,
                height: 140,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey,
                ),
                child: ProgressLoading(
                  size: 20,
                  strokeWidth: 1,
                  valueColor: Colors.black,
                ),
              ),
              errorWidget: (context, url, error) => _errorImage,
            ),
          ],
        ),
      ),
    );
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
}
