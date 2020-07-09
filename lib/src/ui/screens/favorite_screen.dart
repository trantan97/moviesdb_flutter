import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/ui/widgets/widgets.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = "/FavoriteScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc()..add(GetFavorites()),
      child: Scaffold(
        body: BlocBuilder<FavoriteBloc, BaseState>(
          builder: (context, state) {
            if (state is LoadedState) {
              final List<Movie> movies = state.data ?? [];
              return ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  print('----->${movies[index].toMap()}');
                  return ItemListMovie(
                    movie: movies[index],
                    onDismissed: (movie) {
                      context.bloc<FavoriteBloc>().add(UnFavorite(movie));
                    },
                  );
                },
              );
            }
            return Center(
              child: ProgressLoading(
                size: 24,
              ),
            );
          },
        ),
      ),
    );
  }
}
