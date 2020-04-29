import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesdb/models/models.dart';

class HomeListMovies extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const HomeListMovies({Key key, this.title, List<Movie> movies})
      : this.movies = movies ?? const [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Text(
                  title,
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
          height: 170,
          width: widthScreen,
          color: Colors.blue,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _item(index),
            itemCount: this.movies.length,
          ),
        )
      ],
    );
  }

  Widget _item(int index) {
    Movie movie = movies[index];
    return Container(
      height: 170,
      width: 120,
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: movie.porterPath,
          )
        ],
      ),
    );
  }
}
