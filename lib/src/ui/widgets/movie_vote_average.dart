import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MovieVoteAverage extends StatelessWidget {
  final double size;
  final double voteAverage;

  const MovieVoteAverage({Key key, this.size = 20, this.voteAverage = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.orangeAccent, width: 1),
        color: Colors.black12,
      ),
      child: Stack(
        children: <Widget>[
          ClipOval(
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                 _getColor(voteAverage),
                ],
                durations: [9000],
                heightPercentages: [0.9 - (voteAverage / 10.0)],
                gradientBegin: Alignment.bottomCenter,
                gradientEnd: Alignment.topCenter,
              ),
              size: Size(size, size),
              waveAmplitude: -9,
            ),
          ),
          Center(
            child: Text(
              voteAverage.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 9,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
  List<Color> _getColor(double voteAverage){
    if(voteAverage >= 8) return [Colors.red, Color(0xEEF44336)];
    if(voteAverage >= 5) return [Colors.orange,Colors.orange.withOpacity(0.8)];
     return [Colors.green,Colors.green.withOpacity(0.8)];
  }
}
