import 'package:flutter/material.dart';

class LoopSlider extends StatelessWidget{
  final Duration position;
  final Duration duration;

  final ValueChanged<int> moveValue;

  const LoopSlider({super.key, required this.position, required this.duration, required this.moveValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: 0,
          max: duration.inSeconds.toDouble().clamp(0.0, duration.inSeconds.toDouble()),
          value: position.inSeconds.toDouble(),
          onChanged: (value) => moveValue(value.toInt())),
      ],
    );
  }
}