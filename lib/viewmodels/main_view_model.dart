import 'package:moviesdb/viewmodels/view_models.dart';

class MainViewModel extends BaseModel {
  int selectedIndex = 0;

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
