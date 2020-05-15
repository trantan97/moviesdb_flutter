import 'package:flutter/material.dart';
import 'package:moviesdb/src/data/models/models.dart';
import 'package:moviesdb/src/services/view_model_provider.dart';
import 'package:moviesdb/src/ui/widgets/widgets.dart';
import 'package:moviesdb/src/viewmodels/view_models.dart';
import 'package:provider/provider.dart';

class GenreScreen extends StatelessWidget {
  static const routeName = "/GenreScreen";

  @override
  Widget build(BuildContext context) {
    Genre genre = ModalRoute
        .of(context)
        .settings
        .arguments;
    return ViewModelProvider<GenreViewModel>.withoutConsumer(
      viewModel: GenreViewModel(genre: genre),
      onModelReady: (model) => model.getMoviesByGenre(),
      builder: (context, model, _) =>
          Scaffold(
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
            body: _body(context, model),
          ),
    );
  }

  Widget _body(BuildContext context, GenreViewModel model) {
    return Selector<GenreViewModel, bool>(
      builder: (context, busy, _) {
        if (busy) {
          return Center(
            child: ProgressLoading(size: 24),
          );
        }
        return ListMoviesByGenre();
      },
      selector: (context, model) => model.busy,
    );
  }
}
