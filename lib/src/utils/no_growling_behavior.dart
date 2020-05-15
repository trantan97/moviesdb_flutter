//Remove scroll glow

import 'package:flutter/material.dart';

class NoGrowlingBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}