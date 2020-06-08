import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/ui/widgets/widgets.dart';

class GenreScreen extends StatelessWidget {
  static const routeName = "/GenreScreen";

  @override
  Widget build(BuildContext context) {
    Genre genre = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      create: (_) => GenreBloc()..add(GetMoviesByGenre(genre)),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              genre.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          body: _Body(
            genre: genre,
          )),
    );
  }
}

class _Body extends StatelessWidget {
  final Genre genre;

  const _Body({Key key, this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: ProgressLoading(size: 24),
          );
        }
        if (state is LoadedState<MoviesByGenre>) {
          return ListMoviesByGenre(
            genre: genre,
          );
        }
        return Wrap();
      },
    );
  }
}
