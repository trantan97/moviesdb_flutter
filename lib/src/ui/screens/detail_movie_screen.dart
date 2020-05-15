import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesdb/src/constants.dart';
import 'package:moviesdb/src/data/models/movie.dart';
import 'package:moviesdb/src/services/services.dart';
import 'package:moviesdb/src/ui/screens/screens.dart';
import 'package:moviesdb/src/ui/widgets/widgets.dart';
import 'package:moviesdb/src/utils/language.dart';
import 'package:moviesdb/src/utils/utils.dart';
import 'package:moviesdb/src/viewmodels/view_models.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatelessWidget {
  static const routeName = "/DetailMovie";
  YoutubePlayerController _playerController;

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return ViewModelProvider<DetailMovieViewModel>.withoutConsumer(
      viewModel: DetailMovieViewModel(),
      onModelReady: (model) => model.getDetailMovie(movie.id),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<DetailMovieViewModel>(
      builder: (context, model, _) {
        if (model.busy) return Center(child: ProgressLoading(size: 32));
        return Container(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _youtubeView(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            _information(context, model.movie),
                            _genre(context, model.movie),
                            _trailer(context, model.movie),
                            _casts(context, model.movie),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _youtubeView() {
    return Consumer<DetailMovieViewModel>(
      builder: (context, model, _) {
        final videos = model.movie.videos;
        if (videos.length > 0) {
          _playerController = YoutubePlayerController(
            initialVideoId: videos.first.key,
            flags: YoutubePlayerFlags(
              mute: true,
              loop: true,
            ),
          );
          return YoutubePlayer(
            controller: _playerController,
            showVideoProgressIndicator: false,
            bottomActions: <Widget>[
              SizedBox(width: 14.0),
              CurrentPosition(),
              SizedBox(width: 8.0),
              ProgressBar(isExpanded: true),
              Text(
                _playerController.metadata.duration.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
              FullScreenButton(),
            ],
          );
        }

        return AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            imageUrl: getImageUrl(model.movie.backdropPath, imageSize: ImageSize.w500),
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              alignment: Alignment.center,
              child: ProgressLoading(
                size: 20,
                strokeWidth: 1,
                valueColor: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _information(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(2, 2),
            )
          ]),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: MovieVoteAverage(
                  size: 28,
                  voteAverage: movie.voteAverage,
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Language.of(context).getText("information"),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      getRunTime(movie.runtime),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      height: 14,
                      width: 1,
                      margin: EdgeInsets.only(left: 8, right: 8),
                      color: Colors.grey,
                    ),
                    Text(
                      getReleaseDate(movie.releaseDate),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Text(movie.overview),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genre(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(2, 2),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              Language.of(context).getText("genres"),
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Wrap(
            children: movie.genres
                .map((genre) => GenreView(
                      genre: genre,
                      onClick: (genre) => Navigator.of(context).pushNamed(GenreScreen.routeName, arguments: genre),
                      paddingVertical: 4,
                      textSize: 12,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _trailer(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              Language.of(context).getText("trailers"),
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: movie.videos.map((video) {
              return GestureDetector(
                onTap: () => _playerController.load(video.key),
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                              imageUrl: getThumbnailPath(video.key),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                    alignment: Alignment.center,
                                    child: ProgressLoading(
                                      size: 20,
                                      strokeWidth: 1,
                                      valueColor: Colors.black,
                                    ),
                                  ),
                              errorWidget: (context, url, _) => Container(
                                    color: Colors.grey,
                                  )),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                            gradient: LinearGradient(
                                colors: [Colors.black87, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                          ),
                          child: Text(
                            video.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _casts(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              Language.of(context).getText("casts"),
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: movie.cast.map((actor) {
              return GestureDetector(
                onTap: () => {},
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                              imageUrl: getImageUrl(actor.profilePath, imageSize: ImageSize.w300),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                    alignment: Alignment.center,
                                    child: ProgressLoading(
                                      size: 20,
                                      strokeWidth: 1,
                                      valueColor: Colors.black,
                                    ),
                                  ),
                              errorWidget: (context, url, _) => Container(
                                    color: Colors.grey,
                                  )),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                            padding: EdgeInsets.all(4),
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                              gradient: LinearGradient(
                                  colors: [Colors.black87, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  actor.name,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "as ${actor.character}",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
