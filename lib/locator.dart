import 'package:get_it/get_it.dart';
import 'package:moviesdb/services/services.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(()=>Network());
}