import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressLoading extends StatelessWidget {
  final double size;
  final Color valueColor;
  final double strokeWidth;

  const ProgressLoading({Key key, this.size, this.valueColor, this.strokeWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(valueColor),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
