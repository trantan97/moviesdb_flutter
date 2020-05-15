import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:moviesdb/src/services/services.dart';
import 'package:moviesdb/src/utils/utils.dart';

import 'repositories/repositories.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Network());
  locator.registerLazySingleton<MoviesRepositories>(() => MoviesRepositories());
  locator.registerLazySingleton<SettingRepositories>(() => SettingRepositories());
}

void setupLocatorWithContext(BuildContext context) {
  locator.allowReassignment = true;
  locator.registerLazySingleton(() => Language.of(context));
}
