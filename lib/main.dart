import 'package:flutter/material.dart';
import 'package:loopplayer/Prefs.dart';
import 'package:loopplayer/providers/AudioPlayerProvider.dart';
import 'package:loopplayer/providers/LoopProvider.dart';
import 'package:loopplayer/providers/SongProvider.dart';
import 'package:loopplayer/screens/LoopPlayerScreen.dart';
import 'package:loopplayer/themes/AppThemes.dart';
import 'package:provider/provider.dart';



void main() async{
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => SongProvider()),
            ChangeNotifierProvider(create: (context) => AudioPlayerProvider()),
            ChangeNotifierProvider(create: (context) => LoopProvider())
          ],
          child: LoopPlayerApp()
      )
  );

  await AppPreferences().initPrefs();

}

class LoopPlayerApp extends StatelessWidget{
  const LoopPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AudioPlayerProvider>().init();

    return MaterialApp(
      home: LoopPlayer(),
      darkTheme: AppThemes().darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}

