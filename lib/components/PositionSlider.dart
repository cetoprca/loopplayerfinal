import 'package:flutter/cupertino.dart';
import 'package:loopplayer/components/LoopSlider.dart';

class PositionSlider extends StatelessWidget{
  final Duration position;
  final Duration duration;

  final ValueChanged<int> moveValue;

  const PositionSlider({super.key, required this.position, required this.duration, required this.moveValue});

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 300,
            children: [
              Text(formatDuration(position)),
              Text(formatDuration(duration)),
            ],
          ),
          LoopSlider(position: position, duration: duration, moveValue: moveValue)
        ],
      ),
    );
  }

}