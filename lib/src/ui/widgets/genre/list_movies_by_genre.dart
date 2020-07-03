import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/ui/widgets/widgets.dart';

class ListMoviesByGenre extends StatefulWidget {
  final Genre genre;

  const ListMoviesByGenre({Key key, this.genre}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Sate();
  }
}

class _Sate extends State<ListMoviesByGenre> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 100;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, BaseState>(
      builder: (context, state) {
        if (state is LoadedState<MoviesByGenre>) {
          final List<Movie> movies = state.data.movies ?? [];
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: state.data.page < state.data.totalPages ? movies.length + 1 : movies.length,
            itemBuilder: (context, index) {
              return index < movies.length
                  ? ItemListMovie(movie: movies[index])
                  : Center(child: ProgressLoading(size: 20));
            },
            controller: _scrollController,
          );
        }
        return Wrap();
      },
    );
  }

  _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<GenreBloc>(context).add(LoadMoreMoviesByGenre(widget.genre));
    }
  }
}
