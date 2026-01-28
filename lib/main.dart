import 'package:flutter/material.dart';
import 'package:loopplayer/SongFileData.dart';
import 'package:loopplayer/components/AudioInfoView.dart';
import 'package:loopplayer/screens/AudioPickerScreen.dart';
import 'package:loopplayer/providers.dart';
import 'package:loopplayer/screens/LoopPickerScreen.dart';
import 'package:loopplayer/screens/LoopPlayerScreen.dart';
import 'package:loopplayer/screens/SettingsScreen.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';

void main(){
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => SongProvider()),
            ChangeNotifierProvider(create: (context) => ScreenProvider()),
            ChangeNotifierProvider(create: (context) => AudioPlayerProvider()),
          ],
          child: MaterialApp(home: MainView(),)
      )
  );
}

class MainView extends StatelessWidget{
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final index = context.watch<ScreenProvider>().currentIndex;

    context.read<AudioPlayerProvider>().initPlayer();

    switch (index) {
      case 0:
        return const LoopPlayer();
      case 1:
        return const AudioPicker(back: false);
      case 2:
        return const AudioPicker(back: true);
      case 3:
        return const LoopPicker(back: false);
      case 4:
        return const LoopPicker(back: true);
      case 5:
        return const SettingsScreen();
      default:
        return const LoopPlayer();
    }
  }
}

