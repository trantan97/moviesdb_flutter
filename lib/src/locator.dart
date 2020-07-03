import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:moviesdb/src/services/services.dart';
import 'package:moviesdb/src/utils/utils.dart';

import 'repositories/repositories.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Network());
  locator.registerLazySingleton(() => DatabaseProvider.databaseProvider);
  locator.registerLazySingleton<MoviesRepository>(() => MoviesRepository());
  locator.registerLazySingleton<SettingRepository>(() => SettingRepository());
  locator.registerLazySingleton<FavoriteRepository>(() => FavoriteRepository());
}

void setupLocatorWithContext(BuildContext context) {
  locator.allowReassignment = true;
  locator.registerLazySingleton(() => Language.of(context));
}
