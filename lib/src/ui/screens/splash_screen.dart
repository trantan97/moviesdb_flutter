import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moviesdb/src/resources/resources.dart';
import 'package:moviesdb/src/ui/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "SplashScreen";

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<SplashScreen> {
  Timer _timer;

  startTimer() async {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 2), navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(MainScreen.routeName, (_) => false);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            Images.logo,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
