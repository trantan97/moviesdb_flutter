import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:moviesdb/services/services.dart';
import 'package:moviesdb/utils/utils.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Network());
}

void setupLocatorWithContext(BuildContext context) {
  locator.allowReassignment = true;
}
