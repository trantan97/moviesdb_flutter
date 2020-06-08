import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:moviesdb/src/app.dart';
import 'package:moviesdb/src/blocs/simple_bloc_delegate.dart';
import 'package:moviesdb/src/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  setupLocator();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}
