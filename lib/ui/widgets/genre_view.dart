import 'package:flutter/material.dart';
import 'package:moviesdb/data/models/models.dart';

class GenreView extends StatelessWidget {
  final Genre genre;

  const GenreView({Key key, this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Text(
          genre.name ?? "",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
