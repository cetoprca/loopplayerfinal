import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loopplayer/SongFileData.dart';
import 'package:loopplayer/components/AudioInfoView.dart';
import 'package:loopplayer/components/LoopPlayerAppBar.dart';
import 'package:loopplayer/components/PlayerControls.dart';
import 'package:loopplayer/components/PositionSlider.dart';
import 'package:loopplayer/components/SideMenu.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:loopplayer/components/StartEndSlider.dart';
import 'package:loopplayer/providers.dart';
import 'package:loopplayer/screens/AudioPickerScreen.dart';
import 'package:loopplayer/screens/LoopPickerScreen.dart';
import 'package:provider/provider.dart';

class LoopPlayer extends StatefulWidget{
  const LoopPlayer({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoopPlayerState();
  }
}

class LoopPlayerState extends State<LoopPlayer>{
  bool _isMenuOpen = false;
  @override
  void initState() {
    super.initState();
  }

  void _openMenu(){
    setState(() {
      _isMenuOpen ? _isMenuOpen = false : _isMenuOpen = true;
    });
  }

  Future<void> _playLogic() async{
    bool isPlaying = context.read<AudioPlayerProvider>().playing;
    bool isPaused = context.read<AudioPlayerProvider>().paused;

    if(isPlaying){
      if(isPaused){
        await context.read<AudioPlayerProvider>().resume();
      }else{
        await context.read<AudioPlayerProvider>().pause();
      }
    }else{
      await context.read<AudioPlayerProvider>().play();
    }
  }

  Future<void> _toggleLoop() async{
    await context.read<AudioPlayerProvider>().toggleLoop();
  }

  Future<void> _restart() async{
    await context.read<AudioPlayerProvider>().restart();
  }

  Future<void> _searchPosition(int milliseconds) async{
    await context.read<AudioPlayerProvider>().searchPosition(milliseconds);
  }

  Future<void> _seek(int second) async{
    await context.read<AudioPlayerProvider>().seek(second);
  }

  Future<void> _changeStart(int second) async{
    await context.read<AudioPlayerProvider>().changeStart(second);
  }

  Future<void> _changeEnd(int second) async{
    await context.read<AudioPlayerProvider>().changeEnd(second);
  }


  @override
  Widget build(BuildContext context) {
    final songFileData = context.watch<SongProvider>().songFileData;

    context.read<AudioPlayerProvider>().changeSong(songFileData);

    bool isPlaying = context.watch<AudioPlayerProvider>().isPlaying;
    bool isPaused = context.watch<AudioPlayerProvider>().isPaused;
    bool isLooping = context.watch<AudioPlayerProvider>().isLooping;
    Duration position = context.watch<AudioPlayerProvider>().position;
    Duration duration = context.watch<AudioPlayerProvider>().duration;

    Duration start = context.watch<AudioPlayerProvider>().start;
    Duration end = context.watch<AudioPlayerProvider>().end;

    bool error = context.watch<AudioPlayerProvider>().error;

    if(error){
      Fluttertoast.showToast(
        msg: "Ha ocurrido un error abriendo el archivo",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG
      );
    }

    return Scaffold(
      appBar: LoopPlayerAppBar(
        back: false,
        openMenu: _openMenu,
        text: "LoopPlay",
        buttons: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoopPicker(back: true)));
              },
              icon: Icon(Icons.folder_outlined, size: 40,)),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.save, size: 40)),
          IconButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AudioPicker(back: true)));
              },
              icon: Icon(Icons.audio_file_outlined, size: 40)),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    AudioInfoView(songFileData: songFileData),
                    SizedBox(height: 20,),
                    PositionSlider(position: position, duration: duration, moveValue: _seek),
                    StartEndSlider(position: start, duration: duration, moveValue: _changeStart, start: true),
                    StartEndSlider(position: end, duration: duration, moveValue: _changeEnd, start: false),
                  ],
                )
              ),
              PlayerControls(
                  playLogic: _playLogic,
                  toggleLoop: _toggleLoop,
                  restart: _restart,
                  searchPosition: _searchPosition,
                  isPlaying: isPlaying,
                  isLooping: isLooping,
                  isPaused: isPaused
              )
            ],
          ),
          SideMenu(isMenuOpen: _isMenuOpen)
        ],
      ),
    );
  }
}