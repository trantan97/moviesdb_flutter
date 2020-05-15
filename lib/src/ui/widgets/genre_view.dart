import 'package:flutter/material.dart';
import 'package:moviesdb/src/data/models/models.dart';

class GenreView extends StatelessWidget {
  final Genre genre;
  final Function(Genre genre) onClick;
  double textSize;
  double paddingHorizontal;
  double paddingVertical;

  GenreView({
    Key key,
    this.genre,
    this.onClick,
    this.textSize = 14,
    this.paddingHorizontal = 16,
    this.paddingVertical = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick != null ? onClick(genre) : {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Text(
          genre.name ?? "",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}
