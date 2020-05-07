import 'package:flutter/material.dart';
import 'package:moviesdb/data/models/models.dart';
import 'package:moviesdb/ui/widgets/widgets.dart';
import 'package:moviesdb/utils/language.dart';

class HomeListGenre extends StatelessWidget {
  final List<Genre> genres;

  const HomeListGenre({Key key, this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: <Widget>[
              Text(
                Language.of(context).getText("genres"),
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
        Wrap(
          children: genres.map((genre) => GenreView(genre: genre)).toList(),
        )
      ],
    );
  }
}
