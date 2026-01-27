import 'package:flutter/material.dart';
import 'package:loopplayer/SongFileData.dart';
import 'package:loopplayer/audioInfoView.dart';
import 'package:loopplayer/audiopicker.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
        create: (context) => SongProvider(),
      child: MaterialApp(home: AudioPicker(back: false),),
    )
  );
}

class LoopPlayer extends StatelessWidget{
  const LoopPlayer({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Row(children: [Icon(Icons.menu), Text("LoopPlayer", style: TextStyle(color: Colors.yellowAccent),), Icon(Icons.folder), Icon(Icons.save), Icon(Icons.file_open)],),),
        body: Center(
          child: Column(
            children: [
              AudioInfoView(songFileData: SongFileData())
            ],
          ),
        ),
      ),
    );
  }
}

