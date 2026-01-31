import 'package:flutter/material.dart';
import 'package:loopplayer/components/LoopSlider.dart';

class StartEndSlider extends StatelessWidget{
  final bool start;
  final Duration position;
  final Duration duration;
  final VoidCallback moveForward;
  final VoidCallback moveBackward;

  final ValueChanged<int> moveValue;

  const StartEndSlider({super.key, required this.position, required this.duration, required this.moveValue, required this.start, required this.moveForward, required this.moveBackward});

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
    return Column(
      children: [
        Center(
          child: Row(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    width: 30,
                    height: 30,
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                  onTap: () => moveBackward()
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 50,
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(start ? "A" : "B", textAlign: TextAlign.center,),
                    Text(formatDuration(position), textAlign: TextAlign.center,)
                  ],
                )
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: 30,
                  height: 30,
                  child: Icon(Icons.arrow_forward_rounded),
                ),
                onTap: () => moveForward()
              )
            ],
          ),
        ),
        LoopSlider(position: position, duration: duration, moveValue: moveValue)
      ],
    );
  }
}