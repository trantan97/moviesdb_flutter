import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviesdb/constants.dart';
import 'package:moviesdb/data/models/models.dart';
import 'package:moviesdb/services/services.dart';
import 'package:moviesdb/ui/widgets/widgets.dart';
import 'package:moviesdb/utils/utils.dart';
import 'package:moviesdb/viewmodels/view_models.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(context),
      onModelReady: (model) => model.loadData(),
      builder: (context, model, _) {
        if (model.busy)
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ));
        return Scaffold(
          body: ScrollConfiguration(
            behavior: NoGrowlingBehavior(),
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 150.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
//                        title: Text(
//                          "Movie Info",
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 16.0,
//                          ),
//                        ),
                      background: Center(
                        child: Stack(
                          children: <Widget>[
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 180,
                                enlargeCenterPage: false,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  model.changeTrendingPosition(index);
                                },
                                autoPlay: true,
                              ),
                              items: model.trending.movies.getRange(0, 5).map((movie) => itemTrending(movie)).toList(),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              left: 0,
                              child: Container(
                                alignment: Alignment.center,
                                child: PageIndicator(
                                  itemCount: 5,
                                  currentIndex: model.trendingPosition,
                                  selectedColor: Colors.white,
                                  unSelectedColor: Colors.white30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: <Widget>[
                      HomeListMovies(category: model.topRate),
                      HomeListMovies(category: model.popular),
                      HomeListMovies(category: model.nowPlaying),
                      HomeListMovies(category: model.upComing),
                      HomeListGenre(genres: model.genres)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget itemTrending(Movie movie) {
    return Stack(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: getImageUrl(movie.backdropPath, imageSize: ImageSize.w500),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            child: ProgressLoading(
              size: 20,
              strokeWidth: 1,
              valueColor: Colors.black,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black45, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
        Positioned(
          top: 30,
          left: 8,
          width: 350,
          child: Text(
            movie.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
