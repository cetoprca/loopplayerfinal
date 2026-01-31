import 'package:flutter/material.dart';
import 'package:loopplayer/providers/AudioPlayerProvider.dart';
import 'package:loopplayer/providers/SongProvider.dart';
import 'package:loopplayer/screens/LoopPlayerScreen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => SongProvider()),
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
    context.read<AudioPlayerProvider>().init();

    return LoopPlayer();
  }
}

