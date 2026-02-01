import 'package:flutter/material.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';

class PlayerControls extends StatelessWidget{
  final VoidCallback playLogic;
  final VoidCallback toggleLoop;
  final VoidCallback restart;
  final ValueChanged<int> searchPosition;

  final bool isPaused;
  final bool isPlaying;
  final bool isLooping;

  const PlayerControls({super.key, required this.playLogic, required this.toggleLoop, required this.restart, required this.searchPosition, required this.isPlaying, required this.isLooping, required this.isPaused});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          IconButton(onPressed: () => searchPosition(-2000), icon: Icon(Icons.fast_rewind_sharp, size: 48,),color: colors.accent,),
          IconButton(onPressed: () => toggleLoop(), icon: Icon(isLooping ? Icons.repeat_one : Icons.repeat, size: 48),color: colors.accent),
          IconButton(onPressed: () => playLogic(), icon: Icon(isPlaying && !isPaused ? Icons.pause : Icons.play_arrow, size: 48),color: colors.accent),
          IconButton(onPressed: () => restart(), icon: Icon(Icons.replay, size: 48),color: colors.accent),
          IconButton(onPressed: () => searchPosition(2000), icon: Icon(Icons.fast_forward_sharp, size: 48),color: colors.accent),
        ],
      ),
    );
  }

}