import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool _busy;

  bool get busy => _busy;

  void setBusy(bool isBusy) {
    _busy = isBusy;
    notifyListeners();
  }
}
