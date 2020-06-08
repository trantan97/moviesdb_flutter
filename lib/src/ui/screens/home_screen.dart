import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/constants.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/ui/screens/screens.dart';
import 'package:moviesdb/src/ui/widgets/widgets.dart';
import 'package:moviesdb/src/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return BlocBuilder<HomeBloc, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ));
        }
        if (state is LoadedHomeData) {
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
                      flexibleSpace: flexibleSpace(state, statusBarHeight),
                    ),
                  ];
                },
                body: ScrollConfiguration(
                  behavior: NoGrowlingBehavior(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: <Widget>[
                          HomeListMovies(category: state.upComing),
                          HomeListMovies(category: state.nowPlaying),
                          HomeListMovies(category: state.popular),
                          HomeListMovies(category: state.topRate),
                          HomeListGenre(
                            genres: state.genres,
                            onClick: (genre) =>
                                Navigator.of(context).pushNamed(GenreScreen.routeName, arguments: genre),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Wrap();
      },
    );
  }

  Widget flexibleSpace(LoadedHomeData loadedState, double statusBarHeight) {
    return LayoutBuilder(
      builder: (context, boxContain) {
        final currentHeight = boxContain.biggest.height;
        return FlexibleSpaceBar(
          centerTitle: true,
          title: AnimatedOpacity(
            opacity: currentHeight <= 56 + statusBarHeight ? 1 : 0,
            duration: Duration(milliseconds: 50),
            child: Text(
              "Movie Info",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          background: Center(
            child: Stack(
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: false,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      BlocProvider.of<HomeBloc>(context).add(ChangeTrendingPosition(index));
                    },
                    autoPlay: true,
                  ),
                  items: loadedState.trending.movies
                      .getRange(0, 5)
                      .map((movie) => itemTrending(context, movie, statusBarHeight))
                      .toList(),
                ),
                Positioned(
                  bottom: 8,
                  right: 0,
                  left: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: PageIndicator(
                      itemCount: 5,
                      currentIndex: loadedState.trendingPosition,
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.white30,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget itemTrending(BuildContext context, Movie movie, double statusBarHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailMovieScreen.routeName, arguments: movie);
      },
      child: Stack(
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
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: statusBarHeight,
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
      ),
    );
  }
}
