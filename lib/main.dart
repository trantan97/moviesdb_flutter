import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:moviesdb/app.dart';
import 'package:moviesdb/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  setupLocator();
  runApp(App());
}
