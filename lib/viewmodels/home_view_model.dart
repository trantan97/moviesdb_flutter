import 'package:flutter/cupertino.dart';
import 'package:moviesdb/constants.dart';
import 'package:moviesdb/locator.dart';
import 'package:moviesdb/data/models/models.dart';
import 'package:moviesdb/services/services.dart';
import 'package:moviesdb/utils/utils.dart';
import 'package:moviesdb/viewmodels/view_models.dart';
import 'package:moviesdb/extension.dart';

class HomeViewModel extends BaseModel {
  final BuildContext _context;
  Language _language;
  int _fistPage = 1;
  Network _network = locator<Network>();
  Category popular;
  Category nowPlaying;
  Category topRate;
  Category upComing;
  Category trending;
  List<Genre> genres;
  int trendingPosition = 0;

  HomeViewModel(this._context) {
    _language = Language.of(_context);
  }

  Future loadData() async {
    setBusy(true);
    List<Future> futures = [];
    futures.add(_loadPopular());
    futures.add(_loadNowPlaying());
    futures.add(_loadTopRate());
    futures.add(_loadUpComing());
    futures.add(_loadGenres());
    futures.add(_loadTrending());
    await Future.wait(futures);
    setBusy(false);
  }

  Future _loadPopular() async {
    final params = Map<String, dynamic>()..["page"] = _fistPage;
    final response = await _network.get(url: getCategoryUrl(CategoryType.POPULAR), params: params);
    if (response.isSuccess) {
      popular = Category.fromJson(response.data);
      popular.name = _language.getText("category_popular");
    }
  }

  Future _loadNowPlaying() async {
    final params = Map<String, dynamic>()..["page"] = _fistPage;
    final response = await _network.get(url: getCategoryUrl(CategoryType.NOW_PLAYING), params: params);
    if (response.isSuccess) {
      nowPlaying = Category.fromJson(response.data);
      nowPlaying.name = _language.getText("category_now_playing");
    }
  }

  Future _loadTopRate() async {
    final params = Map<String, dynamic>()..["page"] = _fistPage;
    final response = await _network.get(url: getCategoryUrl(CategoryType.TOP_RATE), params: params);
    if (response.isSuccess) {
      topRate = Category.fromJson(response.data);
      topRate.name = _language.getText("category_top_rated");
    }
  }

  Future _loadUpComing() async {
    final params = Map<String, dynamic>()..["page"] = _fistPage;
    final response = await _network.get(url: getCategoryUrl(CategoryType.UP_COMING), params: params);
    if (response.isSuccess) {
      upComing = Category.fromJson(response.data);
      upComing.name = _language.getText("category_up_coming");
    }
  }

  Future _loadGenres() async {
    final response = await _network.get(url: ApiConst.GENRE_URL);
    if (response.isSuccess) {
      genres = response.data["genres"].map((e) => Genre.fromJson(e)).toList()?.cast<Genre>() ?? [];
    }
  }

  Future _loadTrending() async {
    final response = await _network.get(url: ApiConst.TRENDING_URL);
    if (response.isSuccess) {
      trending = Category.fromJson(response.data);
      trending.name = _language.getText("trending");
    }
  }

  void changeTrendingPosition(int position) {
    trendingPosition = position;
    notifyListeners();
  }
}
