import 'package:moviesdb/constants.dart';
import 'package:moviesdb/locator.dart';
import 'package:moviesdb/models/models.dart';
import 'package:moviesdb/services/services.dart';
import 'package:moviesdb/viewmodels/view_models.dart';
import 'package:moviesdb/extension.dart';

class HomeViewModel extends BaseModel {
  int _fistPage = 1;
  Network _network = locator<Network>();
  List<Movie> popular;
  List<Movie> nowPlaying;
  List<Movie> topRate;
  List<Movie> upComing;

  Future loadData() async {
    setBusy(true);
    List<Future> futures = [];
    futures.add(_loadPopular());
    await Future.wait(futures);
//    await Future.delayed(Duration(seconds: 33));
    setBusy(false);
  }

  Future _loadPopular() async {
    final params = Map<String, dynamic>()..["page"] = _fistPage;
    final response = await _network.get(url: ApiConst.CATEGORY + CategoryType.POPULAR, params: params);
    if (response.isSuccess) {
    }
  }
}
