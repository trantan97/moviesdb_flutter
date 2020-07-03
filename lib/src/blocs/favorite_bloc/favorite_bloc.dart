import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesdb/src/blocs/base_bloc/base.dart';
import 'package:moviesdb/src/blocs/blocs.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/repositories/repositories.dart';

class FavoriteBloc extends Bloc<BaseEvent, BaseState> {
  final FavoriteRepository repository = locator<FavoriteRepository>();

  @override
  BaseState get initialState => InitState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ClickedFavorite) {
      try {
        yield (LoadingState());
        final result = await repository.isFavorite(event.movie);
        if (result == true) {
          await repository.deleteFavorite(event.movie);
          yield (NormalState());
        } else if (result == false) {
          await repository.addFavorite(event.movie);
          yield (FavoriteState());
        }
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    } else if (event is CheckFavorite) {
      try {
        yield (LoadingState());
        final result = await repository.isFavorite(event.movie);
        yield (result == true ? FavoriteState() : NormalState());
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    } else if (event is GetFavorites) {
      try {
        yield (LoadingState());
        final result = await repository.getFavorites();
        yield (LoadedState(data: result));
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    } else if (event is UnFavorite) {
      try {
        await repository.deleteFavorite(event.movie);
      } catch (e) {
        yield (ErrorState(data: e.toString()));
      }
    }
  }
}
